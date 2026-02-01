import 'package:flutter/material.dart';
import 'components/sticky_header_list.dart';
import 'components/sticky_models.dart';

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
  // 粘性头部列表数据
  late List<StickyHeaderGroup> _stickyGroups;

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _stickyGroups = [
      StickyHeaderGroup(
        title: '电子产品',
        items: [
          StickyItemData(title: '智能手机', subtitle: '最新款智能手机'),
          StickyItemData(title: '笔记本电脑', subtitle: '高性能笔记本电脑'),
          StickyItemData(title: '平板电脑', subtitle: '轻薄平板电脑'),
          StickyItemData(title: '智能手表', subtitle: '多功能智能手表'),
          StickyItemData(title: '无线耳机', subtitle: '降噪无线耳机'),
        ],
      ),
      StickyHeaderGroup(
        title: '家居用品',
        items: [
          StickyItemData(title: '沙发', subtitle: '舒适布艺沙发'),
          StickyItemData(title: '床', subtitle: '实木双人床'),
          StickyItemData(title: '餐桌', subtitle: '现代简约餐桌'),
          StickyItemData(title: '椅子', subtitle: '人体工学椅子'),
        ],
      ),
      StickyHeaderGroup(
        title: '服装鞋帽',
        items: [
          StickyItemData(title: 'T恤', subtitle: '纯棉舒适T恤'),
          StickyItemData(title: '牛仔裤', subtitle: '修身牛仔裤'),
          StickyItemData(title: '外套', subtitle: '时尚休闲外套'),
          StickyItemData(title: '鞋子', subtitle: '百搭休闲鞋'),
          StickyItemData(title: '帽子', subtitle: '潮流棒球帽'),
          StickyItemData(title: '包包', subtitle: '实用单肩包'),
        ],
      ),
      StickyHeaderGroup(
        title: '食品饮料',
        items: [
          StickyItemData(title: '零食', subtitle: '各种美味零食'),
          StickyItemData(title: '饮料', subtitle: '健康饮品'),
          StickyItemData(title: '水果', subtitle: '新鲜水果'),
          StickyItemData(title: '蔬菜', subtitle: '有机蔬菜'),
        ],
      ),
      StickyHeaderGroup(
        title: '运动健身',
        items: [
          StickyItemData(title: '跑步机', subtitle: '家用跑步机'),
          StickyItemData(title: '哑铃', subtitle: '可调节哑铃'),
          StickyItemData(title: '瑜伽垫', subtitle: '防滑瑜伽垫'),
          StickyItemData(title: '运动服', subtitle: '透气运动服'),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StickyHeaderList(groups: _stickyGroups),
    );
  }
}
