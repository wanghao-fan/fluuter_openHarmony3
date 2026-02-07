import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'force_graph/force_directed_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter for openHarmony'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 创建示例数据
  final List<Node> _nodes = [
    Node(
      id: '1',
      label: 'Node 1',
      position: Offset(100, 100),
      color: Colors.blue,
      size: 25,
    ),
    Node(
      id: '2',
      label: 'Node 2',
      position: Offset(200, 150),
      color: Colors.red,
      size: 20,
    ),
    Node(
      id: '3',
      label: 'Node 3',
      position: Offset(150, 250),
      color: Colors.green,
      size: 22,
    ),
    Node(
      id: '4',
      label: 'Node 4',
      position: Offset(300, 200),
      color: Colors.yellow,
      size: 18,
    ),
    Node(
      id: '5',
      label: 'Node 5',
      position: Offset(250, 300),
      color: Colors.purple,
      size: 20,
    ),
    Node(
      id: '6',
      label: 'Node 6',
      position: Offset(350, 100),
      color: Colors.orange,
      size: 16,
    ),
    Node(
      id: '7',
      label: 'Node 7',
      position: Offset(400, 250),
      color: Colors.teal,
      size: 24,
    ),
  ];

  final List<Edge> _edges = [
    Edge(id: '1-2', sourceId: '1', targetId: '2'),
    Edge(id: '1-3', sourceId: '1', targetId: '3'),
    Edge(id: '2-4', sourceId: '2', targetId: '4'),
    Edge(id: '3-4', sourceId: '3', targetId: '4'),
    Edge(id: '3-5', sourceId: '3', targetId: '5'),
    Edge(id: '4-6', sourceId: '4', targetId: '6'),
    Edge(id: '5-7', sourceId: '5', targetId: '7'),
    Edge(id: '6-7', sourceId: '6', targetId: '7'),
    Edge(id: '1-5', sourceId: '1', targetId: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '力导向图（Force-Directed Graph）展示',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ForceDirectedGraph(
                nodes: _nodes,
                edges: _edges,
                width: 500,
                height: 400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '交互说明：',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('• 拖拽节点可以改变其位置'),
            const Text('• 节点会根据力导向算法自动布局'),
            const Text('• 拖拽时节点会变为红色'),
          ],
        ),
      ),
    );
  }
}
