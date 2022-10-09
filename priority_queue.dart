import 'heap.dart';
import 'queue.dart';

/// Exports to use in Dijkstra's algorithm.
export 'heap.dart' show Priority;

/// PriorityQueue follow Queue protocol. The generic type E
/// must extends [Comparable] since you need to sort the
/// elements.
class PriorityQueue<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueue({
    List<E>? elements,
    Priority priority = Priority.max,
  }) {
    _heap = Heap<E>(elements: elements, priority: priority);
  }

  late Heap<E> _heap;

  @override
  bool get isEmpty => _heap.isEmpty;

  @override
  E? get peek => _heap.peek;

  /// O(log n) since heap shift up itself
  @override
  bool enqueue(E element) {
    _heap.insert(element);
    return true;
  }

  ///O(log n) since you remove the root element from the heap by
  ///replacing it with the last heap element and then shifting
  ///down to validate the heap.
  @override
  E? dequeue() => _heap.remove();

  @override
  String toString() {
    return _heap.toString();
  }
}

void main() {
  final priorityQueue = PriorityQueueList(
    elements: [1, 12, 3, 4, 1, 6, 8, 7],
  );
  print(priorityQueue);
  priorityQueue.enqueue(5);
  priorityQueue.enqueue(0);
  priorityQueue.enqueue(10);
  print(priorityQueue);
  while (!priorityQueue.isEmpty) {
    print(priorityQueue.dequeue());
  }
}

///Exercise 1: prioritize a wait list
///prioritize someone with a military background followed by
///seniority
class Person extends Comparable<Person> {
  String name;
  int age;
  bool isMilitary;

  Person({
    required this.name,
    required this.age,
    required this.isMilitary,
  });

  @override
  int compareTo(Person other) {
    if (isMilitary == other.isMilitary) {
      return age.compareTo(other.age);
    }
    return isMilitary ? 1 : -1;

    // if (isMilitary && !other.isMilitary) {
    //   return 1;
    // } else if (!isMilitary && other.isMilitary) {
    //   return -1;
    // } else {
    //   return age.compareTo(other.age);
    //   // return other.age.compareTo(age);
    // }
  }

  @override
  String toString() {
    return 'Person{name: $name, age: $age, isMilitary: $isMilitary} \n';
  }
}

/// Exercise 2: list-base priority queue
/// construct a priority queue by implementing the Queue
/// interface with a list.
/// The high priority elements are at the end of the list.
class PriorityQueueList<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueueList({List<E>? elements, Priority priority = Priority.max}) {
    _priority = priority;
    _elements = elements ?? [];

    /// The sort algorithm in dart has time complexity of O(n
    /// log n)
    _elements.sort((a, b) => _compareByPriority(a, b));
  }

  /// This method returns an int following the requirements of the
  /// list's sort function.
  int _compareByPriority(E a, E b) {
    if (_priority == Priority.max) {
      return a.compareTo(b);
    }
    return b.compareTo(a);
  }

  late List<E> _elements;
  late Priority _priority;

  /// O(1) since you don't have to shift anything, so that makes
  /// dequeue also O(1), even better that the heap
  /// implementation.
  @override
  E? dequeue() {
    return isEmpty ? null : _elements.removeLast();
  }

  /// Inserting and removing from the beginning of a list is slow.
  /// If you put the high priority elements at the end of the
  /// list, then dequeuing will be a lighting-fast `removerLast`
  /// operation.
  @override
  bool enqueue(E element) {
    /// Start at the low priority end of the list and loop
    /// through every element.
    for (int i = 0; i < _elements.length; i++) {
      /// Check to see if the element you're adding has an even
      /// lower priority than the current element.
      if (_compareByPriority(element, _elements[i]) < 0) {
        /// If it does, insert the new element at the current
        /// index
        _elements.insert(i, element);
        return true;
      }
    }

    /// If you get to the end of the list, that means every other
    /// element was lower priority. Add the new element to the
    /// end of the list as the new highest priority element.
    _elements.add(element);
    return true;
  }

  @override
  bool get isEmpty => _elements.isEmpty;

  @override
  E? get peek => (isEmpty) ? null : _elements.last;

  @override
  String toString() => _elements.toString();
}
