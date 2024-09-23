import 'package:get/get.dart';

extension IndexedIterable<E> on Iterable<E> {

  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

}


extension IterableExtension<T> on Iterable<T>?{

  bool get isNullOrEmpty {
    return this == null || this!.isEmpty ;
  }

}

List<T> sort<T extends Comparable>(List<T> list) {
  list.sort();
  return list;
}
extension DuplicatedList<T> on List<T> {
  List<T> removeDuplicates() {
    var seen = <T>{};
    List<T> uniquelist = where((item) => seen.add(item)).toList();
    return uniquelist;
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key) =>
      toList()
        ..sort((a, b) => key(a).compareTo(key(b)));
}


