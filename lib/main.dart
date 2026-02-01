import 'package:flutter/material.dart';
import 'components/toolbar.dart';
import 'components/action_button.dart';

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
  bool _isLoading = false;

  void _handleButtonPress(String buttonName) {
    setState(() {
      _isLoading = true;
    });

    // 模拟网络请求
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      print('$buttonName 被点击了！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 自定义工具栏
          Toolbar(
            title: '工具栏示例',
            actions: [
              ToolbarAction(
                icon: Icons.search,
                tooltip: '搜索',
                onPressed: () => print('搜索按钮被点击'),
              ),
              ToolbarAction(
                icon: Icons.notifications,
                tooltip: '通知',
                onPressed: () => print('通知按钮被点击'),
              ),
              ToolbarAction(
                icon: Icons.settings,
                tooltip: '设置',
                onPressed: () => print('设置按钮被点击'),
              ),
              ToolbarAction(
                icon: Icons.more_vert,
                tooltip: '更多',
                onPressed: () => print('更多按钮被点击'),
              ),
            ],
          ),

          // 工具栏变体
          Toolbar(
            title: '彩色工具栏',
            actions: [
              ToolbarAction(
                icon: Icons.favorite,
                tooltip: '收藏',
                onPressed: () => print('收藏按钮被点击'),
                iconColor: Colors.red,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
              ToolbarAction(
                icon: Icons.share,
                tooltip: '分享',
                onPressed: () => print('分享按钮被点击'),
                iconColor: Colors.yellow,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ],
            backgroundColor: Colors.teal,
            titleColor: Colors.white,
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    '动作按钮示例',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 标准按钮
                  const Text('标准按钮:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  ActionButton(
                    text: '主要按钮',
                    onPressed: () => _handleButtonPress('主要按钮'),
                  ),
                  const SizedBox(height: 12),

                  // 带图标按钮
                  const Text('带图标按钮:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  ActionButton(
                    text: '保存',
                    icon: Icons.save,
                    onPressed: () => _handleButtonPress('保存按钮'),
                  ),
                  const SizedBox(height: 12),

                  // 轮廓按钮
                  const Text('轮廓按钮:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  ActionButton(
                    text: '取消',
                    icon: Icons.cancel,
                    onPressed: () => _handleButtonPress('取消按钮'),
                    isOutlined: true,
                  ),
                  const SizedBox(height: 12),

                  // 加载状态按钮
                  const Text('加载状态按钮:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  ActionButton(
                    text: '提交中...',
                    icon: Icons.send,
                    onPressed: () => _handleButtonPress('提交按钮'),
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 12),

                  // 彩色按钮
                  const Text('彩色按钮:', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          text: '成功',
                          icon: Icons.check_circle,
                          onPressed: () => _handleButtonPress('成功按钮'),
                          buttonColor: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ActionButton(
                          text: '警告',
                          icon: Icons.warning,
                          onPressed: () => _handleButtonPress('警告按钮'),
                          buttonColor: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          text: '错误',
                          icon: Icons.error,
                          onPressed: () => _handleButtonPress('错误按钮'),
                          buttonColor: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ActionButton(
                          text: '信息',
                          icon: Icons.info,
                          onPressed: () => _handleButtonPress('信息按钮'),
                          buttonColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    '悬浮动作按钮',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    color: Colors.grey[100],
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const Center(
                          child: Text('内容区域'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomFloatingActionButton(
                            icon: Icons.add,
                            tooltip: '添加',
                            onPressed: () => print('悬浮添加按钮被点击'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    '不同尺寸的悬浮按钮',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomFloatingActionButton(
                        icon: Icons.star,
                        tooltip: '小尺寸',
                        onPressed: () => print('小尺寸按钮被点击'),
                        size: 40,
                        backgroundColor: Colors.purple,
                      ),
                      CustomFloatingActionButton(
                        icon: Icons.star,
                        tooltip: '标准尺寸',
                        onPressed: () => print('标准尺寸按钮被点击'),
                        backgroundColor: Colors.indigo,
                      ),
                      CustomFloatingActionButton(
                        icon: Icons.star,
                        tooltip: '大尺寸',
                        onPressed: () => print('大尺寸按钮被点击'),
                        size: 64,
                        backgroundColor: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),

      // 右下角悬浮按钮
      floatingActionButton: CustomFloatingActionButton(
        icon: Icons.add,
        tooltip: '添加新项目',
        onPressed: () => print('主悬浮按钮被点击'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

