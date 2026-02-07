import 'dart:math';
import 'package:flutter/material.dart';

class ForceDirectedGraph extends StatefulWidget {
  final List<Node> nodes;
  final List<Edge> edges;
  final double width;
  final double height;

  const ForceDirectedGraph({
    Key? key,
    required this.nodes,
    required this.edges,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ForceDirectedGraphState createState() => _ForceDirectedGraphState();
}

class Node {
  final String id;
  final String label;
  Offset position;
  Offset velocity;
  bool isDragging;
  final Color color;
  final double size;

  Node({
    required this.id,
    required this.label,
    required this.position,
    this.velocity = Offset.zero,
    this.isDragging = false,
    this.color = Colors.blue,
    this.size = 20.0,
  });
}

class Edge {
  final String id;
  final String sourceId;
  final String targetId;
  final Color color;
  final double width;

  Edge({
    required this.id,
    required this.sourceId,
    required this.targetId,
    this.color = Colors.grey,
    this.width = 1.0,
  });
}

class _ForceDirectedGraphState extends State<ForceDirectedGraph> {
  Map<String, Node> _nodeMap = {};
  Node? _draggedNode;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _initializeNodes();
  }

  void _initializeNodes() {
    _nodeMap = {
      for (var node in widget.nodes)
        node.id: Node(
          id: node.id,
          label: node.label,
          position: node.position,
          color: node.color,
          size: node.size,
        ),
    };
  }

  void _handlePanStart(DragStartDetails details) {
    final touchPosition = details.localPosition;
    for (var node in _nodeMap.values) {
      final distance = (node.position - touchPosition).distance;
      if (distance <= node.size) {
        setState(() {
          _draggedNode = node;
          _draggedNode!.isDragging = true;
          _dragOffset = touchPosition - node.position;
        });
        break;
      }
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_draggedNode != null) {
      setState(() {
        _draggedNode!.position = details.localPosition - _dragOffset;
      });
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_draggedNode != null) {
      setState(() {
        _draggedNode!.isDragging = false;
        _draggedNode = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          painter: _GraphPainter(
            nodes: _nodeMap.values.toList(),
            edges: widget.edges,
          ),
        ),
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  final List<Node> nodes;
  final List<Edge> edges;

  _GraphPainter({
    required this.nodes,
    required this.edges,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制边
    for (var edge in edges) {
      final sourceNode = nodes.firstWhere(
        (node) => node.id == edge.sourceId,
        orElse: () => Node(id: '', label: '', position: Offset.zero),
      );
      final targetNode = nodes.firstWhere(
        (node) => node.id == edge.targetId,
        orElse: () => Node(id: '', label: '', position: Offset.zero),
      );

      final paint = Paint()
        ..color = edge.color
        ..strokeWidth = edge.width
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        sourceNode.position,
        targetNode.position,
        paint,
      );
    }

    // 绘制节点
    for (var node in nodes) {
      final paint = Paint()
        ..color = node.isDragging ? Colors.red : node.color
        ..style = PaintingStyle.fill;

      // 绘制节点圆圈
      canvas.drawCircle(node.position, node.size, paint);

      // 绘制节点标签
      final textPainter = TextPainter(
        text: TextSpan(
          text: node.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: node.size * 0.6,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          node.position.dx - textPainter.width / 2,
          node.position.dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(_GraphPainter oldDelegate) {
    return true;
  }
}
