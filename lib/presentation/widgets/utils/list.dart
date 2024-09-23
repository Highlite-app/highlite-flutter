extension ListMapper<T> on List<T> {
  List<T> mapTo(List<T> destination, bool Function(T) condition) {
    for (var element in this) {
      if (condition(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  List<T> mapWithModify(
      List<T> destination, T Function(T) map, bool Function(T) condition) {
    for (var element in this) {
      element = map(element);
      if (condition(element)) {
        destination.add(element);
      }
    }
    return destination;
  }

  Future<List<T>> mapWithModifyFuture(List<T> destination,
      Future<T> Function(T) map, bool Function(T) condition) async {
    for (var element in this) {
      element = await map(element);
      if (condition(element)) {
        destination.add(element);
      }
    }
    return destination;
  }
}
