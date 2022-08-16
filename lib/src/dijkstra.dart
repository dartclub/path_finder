import 'package:path_finder/src/graph.dart';
import 'package:path_finder/src/queue.dart';

class Path<T> {
  T key;
  T? previous;
  num priority;
  Path(this.key, this.previous, this.priority);
}

List<Path<T>> dijkstra<T>(
  Graph<T> graph,
  T start,
  CalculateWeightFunction<T> calcWeight,
) {
  List<Path<T>> paths = [Path(start, null, 0)];

  final queue = PriorityQueue<T>();
  final visited = <T>[];

  _filter(Node<T> el) => el.self == start;
  queue.push(graph.nodes.singleWhere(_filter), 0);
  queue.pushAll(graph.nodes.where((el) => !_filter(el)));

  print(queue.items.map((e) => e.node.self));

  while (queue.isNotEmpty) {
    final min = queue.pop();
    visited.add(min.node.self);
    for (var neighbor in min.node.neighbours) {
      print('${min.node.self}: $neighbor');
      if (visited.contains(neighbor)) continue;
      num alt = min.priority + calcWeight(min.node, Node(neighbor, []));
      print('\talt: $alt');
      if (alt < queue.getPriorityByT(neighbor)) {
        print('\ttrue');
        paths.add(Path(neighbor, min.node.self, alt));
        queue.decreasePriorityByT(neighbor, alt);
      }
    }
  }

  return paths;
}

List<T> getShortestPath<T>(
    Graph<T> graph, T start, T end, CalculateWeightFunction<T> calcWeight) {
  var paths = dijkstra<T>(graph, start, calcWeight);
  print(paths.map((e) => '[${e.previous} -> ${e.key}, w: ${e.priority}]'));

  var path = paths.singleWhere((element) => element.key == end);
  var nodes = [path.key];
  var prev = path.previous;
  while (prev != null) {
    nodes.add(prev);
    prev = paths.singleWhere((element) => element.key == prev).previous;
  }
  return nodes;
}
