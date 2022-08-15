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
  CalculatePriorityFunction<T> calcPriority,
) {
  List<Path<T>> paths = [Path(start, null, 0)];

  var queue = PriorityQueue<T>();
  _filter(Node<T> el) => el.self == start;
  queue.push(graph.nodes.singleWhere(_filter));
  queue.pushAll(graph.nodes.where((el) => !_filter(el)));

  while (queue.isNotEmpty) {
    var min = queue.pop();
    for (var neighbor in min.node.neighbours) {
      num alt = min.priority + calcPriority(min.node, Node(neighbor, []));
      if (alt < queue.getPriorityByT(neighbor) &&
          min.priority != double.infinity) {
        paths.add(Path(neighbor, min.node.self, alt));
        queue.decreasePriorityByT(neighbor, alt);
      }
    }
  }

  return paths;
}

List<T> getShortestPath<T>(
    Graph<T> graph, T start, T end, CalculatePriorityFunction<T> calcPriority) {
  var paths = dijkstra(graph, start, calcPriority);
  var path = paths.singleWhere((element) => element.key == end);
  var nodes = [path.key];
  var prev = path.previous;
  while (prev != null) {
    nodes.add(prev);
    prev = paths.singleWhere((element) => element.key == prev).previous;
  }
  return nodes;
}
