import 'package:flutter/material.dart';
import 'morse_translator_widget.dart';

class MorseHome extends StatefulWidget {
  const MorseHome({Key? key}) : super(key: key);

  @override
  _MorseHomeState createState() => _MorseHomeState();
}

class _MorseHomeState extends State<MorseHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('摩斯电码翻译器'),
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
                    '摩斯电码翻译器',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '在文本和摩斯电码之间互相转换',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // 翻译器组件
            MorseTranslatorWidget(),
          ],
        ),
      ),
    );
  }
}
