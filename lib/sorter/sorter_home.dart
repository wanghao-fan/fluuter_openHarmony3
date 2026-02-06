import 'package:flutter/material.dart';
import 'sorter_widget.dart';

class SorterHome extends StatefulWidget {
  const SorterHome({Key? key}) : super(key: key);

  @override
  _SorterHomeState createState() => _SorterHomeState();
}

class _SorterHomeState extends State<SorterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('行排序工具'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 标题部分
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '行排序工具',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '对多行文本进行升序或降序排列',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // 排序工具组件
            SorterWidget(),
          ],
        ),
      ),
    );
  }
}
