enum HeroTagScopeType { home, subscriptions, community, user, list, unknown }

class HeroTagScope {
  const HeroTagScope(this.type, {this.id});

  final HeroTagScopeType type;
  final String? id;

  @override
  String toString() {
    if (id == null) return type.name;
    return '${type.name}-$id';
  }
}
