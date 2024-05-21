import 'package:collection/collection.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

extension ListExtensions<T> on List<T> {
  int get lastIndex {
    return length - 1;
  }
}

extension MapWithIndex<T> on List<T> {
  List<R> mapEnumerated<R>(R Function(T, int i) callback) {
    return this.asMap().map((key, value) => MapEntry(key, callback(value, key))).values.toList();
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

  Iterable<T> fuzzySearch(List<String? Function(T)> fields, String? query) {
    if (query == null) {
      return this;
    }

    return this
        .map((item) {
          var r = fields.map((field) {
            var f = field(item) ?? "";

            return weightedRatio(f, query);
          }).max;

          return FuzzyItem(item, r);
        })
        .sorted((lhs, rhs) => rhs.ratio.compareTo(lhs.ratio))
        .take(20)
        .where((element) => element.ratio > 30)
        .map((e) => e.item);
  }
}

class FuzzyItem<T> {
  final T item;
  final int ratio;

  FuzzyItem(this.item, this.ratio);
}
