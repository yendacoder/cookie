enum HeroTagScopeType {
  home,
  subscriptions,
  moderating,
  community,
  user,
  list,
  unknown,
}

class HeroTagScope {
  const HeroTagScope(this.type, {this.id});

  final HeroTagScopeType type;
  final String? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HeroTagScope && other.type == type && other.id == id);

  @override
  int get hashCode => Object.hash(type, id);

  @override
  String toString() {
    if (id == null) return type.toString();
    return '${type.name}-$id';
  }
}
