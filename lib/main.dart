import 'package:flutter/material.dart';
import 'components/pagination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 1;
  int _totalPages = 20;
  int _pageSize = 10;
  int _totalItems = 200;
  List<String> _dataList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _dataList = List.generate(
        _pageSize,
        (index) => '第 $_currentPage 页 - 第 ${(index + 1)} 条数据',
      );
    });
  }

  void _handlePageChanged(int page) {
    setState(() {
      _currentPage = page;
      _loadData();
    });
  }

  void _handleSizeChanged(int size) {
    setState(() {
      _pageSize = size;
      _currentPage = 1;
      _totalPages = (_totalItems / size).ceil();
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination 分页示例'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Pagination 分页示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            // 数据列表
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_dataList[index]),
                      tileColor: index % 2 == 0 ? Colors.grey[50] : Colors.white,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // 分页组件
            Pagination(
              currentPage: _currentPage,
              totalPages: _totalPages,
              pageSize: _pageSize,
              totalItems: _totalItems,
              onPageChanged: _handlePageChanged,
              showTotal: true,
              showSizeChanger: true,
              onSizeChanged: _handleSizeChanged,
              showQuickJumper: true,
              activeColor: Colors.deepPurple,
              inactiveColor: Colors.grey,
              disabledColor: Colors.grey[300]!,
            ),
          ],
        ),
      ),
    );
  }
}
