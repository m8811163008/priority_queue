abstract class Queue<E> {
  /// Inserts an element into the queue,
  /// and returns true if the operation
  /// was successful
  bool enqueue(E element);

  /// Removes the element with the highest
  /// priority and returns it. Returns
  /// null if the queue was empty.
  E? dequeue();

  /// Checks if the queue is empty
  bool get isEmpty;

  /// Returns the element with the highest priority without
  /// removing it. Returns null if the queue was empty
  E? get peek;
}
