extension ListExtensions<T> on List<T> {
  int get lastIndex {
    return length - 1;
  }
}

extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> distinct() {
    final ids = Set();

    return this.where((x) => ids.add(x));
  }

  Iterable<T> search(List<String? Function(T)> fields, String? query) {
    query = query?.toLowerCase();
    return this.where((element) {
      if (query == null) {
        return true;
      }
      return fields.any((field) => field(element)?.toLowerCase().contains(query!) ?? false);
    });
  }
}
