import 'package:path_finder/src/graph.dart';

class NodeWithPriority<T> {
  final Node<T> node;
  final num priority;

  NodeWithPriority(this.node, this.priority);
}

typedef CalculateWeightFunction<T> = num Function(Node<T>, Node<T>);

class PriorityQueue<T> {
  final List<NodeWithPriority<T>> _items = [];

  PriorityQueue();

  void push(Node<T> node, [num? priority]) =>
      _items.add(NodeWithPriority(node, priority ?? double.infinity));

  void pushAll(Iterable<Node<T>> nodes) => _items
      .addAll(nodes.map((node) => NodeWithPriority(node, double.infinity)));

  num getPriorityByT(T t) =>
      _items.singleWhere((el) => el.node.self == t).priority;

  void decreasePriorityByT(T t, num priority) {
    var index = _items.indexWhere((el) => el.node.self == t);
    _items[index] = NodeWithPriority(_items[index].node, priority);
    _items.sort((a, b) => b.priority.compareTo(a.priority));
  }

  NodeWithPriority<T> pop() => _items.removeAt(0);

  bool get isNotEmpty => _items.isNotEmpty;

  List<NodeWithPriority<T>> get items => _items;
}
