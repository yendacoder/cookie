import 'package:cookie/core/hero_tag_scope.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HeroTagScope', () {
    test('instances with the same type and id are equal', () {
      const a = HeroTagScope(.community, id: 'gaming');
      const b = HeroTagScope(.community, id: 'gaming');

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('instances with the same type and no id are equal', () {
      expect(
        const HeroTagScope(.unknown),
        equals(const HeroTagScope(.unknown)),
      );
    });

    test('instances differing by type are not equal', () {
      expect(
        const HeroTagScope(.home),
        isNot(equals(const HeroTagScope(.subscriptions))),
      );
    });

    test('instances differing by id are not equal', () {
      expect(
        const HeroTagScope(.community, id: 'gaming'),
        isNot(equals(const HeroTagScope(.community, id: 'other'))),
      );
    });
  });
}
