//to filter stream of list, using the function T to test it
//<T> -> extend stream with value of T
extension Filter<T> on Stream<List<T>>{
  Stream<List<T>> filter(bool Function(T) where) =>
    map((items) => items.where(where).toList());
}