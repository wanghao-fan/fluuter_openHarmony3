import 'package:flutter/material.dart';
import 'components/grouped_list.dart';

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
  // 分组列表数据
  final List<GroupData> _groupData = [
    GroupData(
      title: '水果类',
      items: [
        GroupItemData(title: '苹果', subtitle: '新鲜红富士苹果'),
        GroupItemData(title: '香蕉', subtitle: '进口香蕉'),
        GroupItemData(title: '橙子', subtitle: '赣南脐橙'),
        GroupItemData(title: '草莓', subtitle: '新鲜草莓'),
      ],
    ),
    GroupData(
      title: '蔬菜类',
      items: [
        GroupItemData(title: '西红柿', subtitle: '有机西红柿'),
        GroupItemData(title: '黄瓜', subtitle: '新鲜黄瓜'),
        GroupItemData(title: '土豆', subtitle: '山东土豆'),
      ],
    ),
    GroupData(
      title: '肉类',
      items: [
        GroupItemData(title: '猪肉', subtitle: '土猪肉'),
        GroupItemData(title: '牛肉', subtitle: '澳洲牛肉'),
        GroupItemData(title: '鸡肉', subtitle: '散养鸡肉'),
        GroupItemData(title: '鱼肉', subtitle: '新鲜鱼肉'),
        GroupItemData(title: '羊肉', subtitle: '内蒙古羊肉'),
      ],
    ),
    GroupData(
      title: '乳制品',
      items: [
        GroupItemData(title: '牛奶', subtitle: '纯牛奶'),
        GroupItemData(title: '酸奶', subtitle: '风味酸奶'),
        GroupItemData(title: '奶酪', subtitle: '进口奶酪'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedList(groups: _groupData),
    );
  }
}
