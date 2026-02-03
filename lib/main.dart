import 'package:flutter/material.dart';
import 'components/cascader.dart';

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
  List<String> _selectedValues = [];
  String _selectedLabels = '请选择';

  // 级联选择数据源
  final List<CascaderOption> _options = [
    CascaderOption(
      value: 'beijing',
      label: '北京市',
      children: [
        CascaderOption(
          value: 'dongcheng',
          label: '东城区',
          children: [
            CascaderOption(value: 'dongzhimen', label: '东直门街道'),
            CascaderOption(value: 'gongti', label: '工体街道'),
          ],
        ),
        CascaderOption(
          value: 'xicheng',
          label: '西城区',
          children: [
            CascaderOption(value: 'xidan', label: '西单街道'),
            CascaderOption(value: 'liulichang', label: '琉璃厂街道'),
          ],
        ),
      ],
    ),
    CascaderOption(
      value: 'shanghai',
      label: '上海市',
      children: [
        CascaderOption(
          value: 'pudong',
          label: '浦东新区',
          children: [
            CascaderOption(value: 'lujiazui', label: '陆家嘴街道'),
            CascaderOption(value: 'jinqiao', label: '金桥街道'),
          ],
        ),
        CascaderOption(
          value: 'huangpu',
          label: '黄浦区',
          children: [
            CascaderOption(value: 'nanpu', label: '南浦街道'),
            CascaderOption(value: 'laoximen', label: '老西门街道'),
          ],
        ),
      ],
    ),
    CascaderOption(
      value: 'guangzhou',
      label: '广州市',
      children: [
        CascaderOption(
          value: 'tianhe',
          label: '天河区',
          children: [
            CascaderOption(value: 'tianyuhu', label: '天河北街道'),
            CascaderOption(value: 'shipai', label: '石牌街道'),
          ],
        ),
        CascaderOption(
          value: 'yuexiu',
          label: '越秀区',
          children: [
            CascaderOption(value: 'renminlu', label: '人民街道'),
            CascaderOption(value: 'huanshi', label: '环市街道'),
          ],
        ),
      ],
    ),
  ];

  void _handleCascaderChanged(List<String> values) {
    setState(() {
      _selectedValues = values;
      // 获取选中的标签
      _selectedLabels = _getSelectedLabels(values).join(' / ');
    });
  }

  List<String> _getSelectedLabels(List<String> values) {
    final labels = <String>[];
    var currentOptions = _options;

    for (final value in values) {
      final option = currentOptions.firstWhere(
        (option) => option.value == value,
        orElse: () => const CascaderOption(value: '', label: ''),
      );
      labels.add(option.label);
      if (option.children != null) {
        currentOptions = option.children!;
      }
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cascader 级联选择示例'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Cascader 级联选择示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            
            const Text(
              '选择地区:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            
            // 级联选择组件
            Cascader(
              options: _options,
              onChanged: _handleCascaderChanged,
              placeholder: '请选择地区',
              borderColor: Colors.grey,
              focusedBorderColor: Colors.deepPurple,
              dropdownBackgroundColor: Colors.white,
              textColor: Colors.black,
              selectedTextColor: Colors.white,
              selectedBackgroundColor: Colors.deepPurple,
              borderRadius: 4.0,
            ),
            
            const SizedBox(height: 30),
            
            const Text(
              '选择结果:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                _selectedLabels,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            
            const SizedBox(height: 30),
            
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '选中值: ${_selectedValues.join(', ')}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
