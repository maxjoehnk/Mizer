extension ListExtensions<T> on List<T> {
  int get lastIndex {
    return length - 1;
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
