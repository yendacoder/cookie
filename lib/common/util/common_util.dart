import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/common/util/string_util.dart';

extension EnumFromString on String {
  T toEnum<T extends Enum>(List<T> values) {
    final value = '.${snakeCaseToCamelCase()}';
    return values.firstWhere((e) => e.toString().endsWith(value),
        orElse: () => values.first);
  }

  T? toEnumOrNull<T extends Enum>(List<T> values) {
    final value = '.${snakeCaseToCamelCase()}';
    return values.firstWhereOrNull((e) => e.toString().endsWith(value));
  }

  DateTime toDateTime() {
    return DateTime.parse(this);
  }
}
