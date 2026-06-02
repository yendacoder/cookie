import 'bootstrap.dart';
import 'core/providers/app_flavor_provider.dart';

void main() => bootstrap(
  additionalOverrides: [appFlavorProvider.overrideWithValue(.github)],
);
