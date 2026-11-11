#!/usr/bin/env bash
# Builds the Play Store release (store flavor, Android App Bundle) with the
# maintainer build config from dart_defines.json.
#
# Usage: scripts/build_store.sh [--skip-checks]
#   --skip-checks   skip flutter analyze/test (not recommended)
# Env:
#   SKIP_ENDPOINT_CHECK=1   don't verify the feedback endpoint is reachable
set -euo pipefail

cd "$(dirname "$0")/.."

DEFINES=dart_defines.json
AAB=build/app/outputs/bundle/storeRelease/app-store-release.aab
SKIP_CHECKS=false

for arg in "$@"; do
  case "$arg" in
    --skip-checks) SKIP_CHECKS=true ;;
    -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
    *) echo "Unknown argument: $arg" >&2; exit 2 ;;
  esac
done

fail() { echo "error: $*" >&2; exit 1; }

# --- Build config ----------------------------------------------------------
[[ -f $DEFINES ]] ||
  fail "$DEFINES not found. Copy dart_defines.example.json and fill in real values."

read_define() {
  python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get(sys.argv[2], ""))' \
    "$DEFINES" "$1"
}

FEEDBACK_ENDPOINT=$(read_define FEEDBACK_ENDPOINT)
SUPPORT_EMAIL=$(read_define SUPPORT_EMAIL)

# Play policy requires an in-app feedback mechanism, so it must be enabled.
[[ -n $FEEDBACK_ENDPOINT ]] ||
  fail "FEEDBACK_ENDPOINT is empty in $DEFINES; the feedback screen would be hidden."
[[ $FEEDBACK_ENDPOINT == https://* ]] ||
  fail "FEEDBACK_ENDPOINT must be an https URL: $FEEDBACK_ENDPOINT"
[[ $FEEDBACK_ENDPOINT != *example.com* && $SUPPORT_EMAIL != *example.com* ]] ||
  fail "$DEFINES still contains placeholder example.com values."

if [[ ${SKIP_ENDPOINT_CHECK:-0} != 1 ]]; then
  # The feedback API answers GET with 405; anything else means it's not deployed.
  status=$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 "$FEEDBACK_ENDPOINT" || true)
  [[ $status == 405 ]] ||
    fail "feedback endpoint returned HTTP $status (expected 405). Is the worker deployed? Set SKIP_ENDPOINT_CHECK=1 to ignore."
fi

[[ -f android/key.properties ]] ||
  fail "android/key.properties not found; the release build can't be signed."

version=$(sed -n 's/^version: *//p' pubspec.yaml)
echo "Building Cookie $version (store)"
echo "  FEEDBACK_ENDPOINT = $FEEDBACK_ENDPOINT"
echo "  SUPPORT_EMAIL     = ${SUPPORT_EMAIL:-(none)}"

# --- Checks ----------------------------------------------------------------
flutter pub get
if [[ $SKIP_CHECKS == false ]]; then
  flutter analyze --fatal-infos
  flutter test
fi

# --- Build -----------------------------------------------------------------
flutter build appbundle --release \
  --flavor store -t lib/main.dart \
  --dart-define-from-file="$DEFINES"

echo
echo "Done: $AAB"
