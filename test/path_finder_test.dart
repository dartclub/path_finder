import 'package:path_finder/path_finder.dart';
import 'package:test/test.dart';

void main() {
  var graph = Graph<int>(
    [
      Edge(1, 2, weight: 5),
      Edge(1, 3, weight: 15),
      Edge(2, 3, weight: 6),
      Edge(4, 3, weight: 2),
    ],
  );
  test('test graph', () {
    for (var i = 0; i < graph.nodes.length; i++) {
      expect(graph.nodes.map((e) => e.self).contains(i + 1), true);
      expect(i + 1, graph.nodes[i].self);
    }
  });
  _calcPrio(start, end) => graph.edges
      .singleWhere(
        (element) =>
            element.start == start.self && element.end == end.self ||
            element.start == end.self && element.end == start.self,
      )
      .weight!;
  test('get paths / dijkstra', () {
    var paths = dijkstra<int>(
      graph,
      1,
      _calcPrio,
    );
    expect(paths[0].previous, null);
    expect(paths[0].key, 1);
    expect(paths[0].priority, 0);
  });
  test('get shortest single path', () {
    var shortestPath = getShortestPath(
      graph,
      1,
      4,
      _calcPrio,
    );
    print(shortestPath);
  });
}
