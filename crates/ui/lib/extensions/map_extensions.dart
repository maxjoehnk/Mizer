extension MapExtensions<TKey, TValue> on Map<TKey, TValue> {
  List<TResult> mapToList<TResult>(TResult map(TKey key, TValue value)) {
    return this.map((key, value) => MapEntry(key, map(key, value))).values.toList();
  }
}
