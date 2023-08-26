
extension IterableUtil<E> on Iterable<E> {
  Iterable<E> whereNotNull() {
    return where((element) => element != null);
  }

  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Same as [elementAtOrNull], but also returns null for negative indices.
  E? elementAtOrNullSafe(int index) {
    if (index < 0) return null;
    return elementAtOrNull(index);
  }
}