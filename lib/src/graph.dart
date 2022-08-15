class Edge<T> {
  final List<T> list;
  T get start => list.first;
  T get end => list.last;
  final bool bothDirections;

  Edge(T start, T last, [this.bothDirections = true]) : list = [start, last];
}

class Node<T> {
  final List<T> neighbours;
  final T self;

  Node(this.self, this.neighbours);
}

class Graph<T> {
  final List<Edge<T>> edges;

  List<Node<T>> get nodes {
    Set<T> positions = {};
    for (var edge in edges) {
      positions.addAll(edge.list);
    }

    List<Node<T>> generatedNodes = [];
    for (var pos in positions) {
      List<T> neighbors = [];
      for (var edge in edges) {
        if (edge.start == pos) {
          neighbors.add(edge.end);
        } else if (edge.end == pos) {
          neighbors.add(edge.start);
        } else {
          // noffing
        }
      }
    }
    return generatedNodes.toList();
  }

  Graph(this.edges);
}
