import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeepLinkHandler extends StatefulWidget {
  final Widget? child;

  const DeepLinkHandler({super.key, this.child});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  String? _deepLink;
  Map<String, String>? _parsedParams;
  bool _isProcessing = false;
  TextEditingController _deepLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  @override
  void dispose() {
    _deepLinkController.dispose();
    super.dispose();
  }

  void _initDeepLinkListener() {
    _simulateDeepLink();
  }

  void _simulateDeepLink() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isProcessing = true;
      });

      const simulatedDeepLink = 'myapp://product?id=123&name=Flutter&price=99.99';
      _deepLinkController.text = simulatedDeepLink;
      _processDeepLink(simulatedDeepLink);

      setState(() {
        _isProcessing = false;
      });
    });
  }

  void _processDeepLink(String deepLink) {
    setState(() {
      _deepLink = deepLink;
      _parsedParams = _parseDeepLinkParams(deepLink);
    });
  }

  Map<String, String> _parseDeepLinkParams(String deepLink) {
    final params = <String, String>{};
    
    final queryIndex = deepLink.indexOf('?');
    if (queryIndex != -1 && queryIndex < deepLink.length - 1) {
      final queryString = deepLink.substring(queryIndex + 1);
      final paramPairs = queryString.split('&');
      
      for (final pair in paramPairs) {
        final keyValue = pair.split('=');
        if (keyValue.length == 2) {
          params[keyValue[0]] = keyValue[1];
        }
      }
    }
    
    return params;
  }

  Future<void> _copyDeepLinkToClipboard() async {
    if (_deepLink != null) {
      await Clipboard.setData(ClipboardData(text: _deepLink!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('深度链接已复制到剪贴板'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleUserInput() {
    final input = _deepLinkController.text.trim();
    if (input.isNotEmpty) {
      setState(() {
        _isProcessing = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        _processDeepLink(input);
        setState(() {
          _isProcessing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('深度链接已更新'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('深度链接处理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '深度链接输入',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _deepLinkController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '输入深度链接，例如：myapp://product?id=123&name=Flutter',
                          labelText: '深度链接',
                        ),
                        maxLines: 2,
                        onSubmitted: (value) {
                          _handleUserInput();
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _handleUserInput,
                        child: const Text('更新深度链接'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '深度链接状态',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_isProcessing)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (_deepLink != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('深度链接: $_deepLink'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _copyDeepLinkToClipboard,
                              child: const Text('复制深度链接'),
                            ),
                          ],
                        )
                      else
                        const Text('等待深度链接...'),
                    ],
                  ),
                ),
              ),
              if (_parsedParams != null && _parsedParams!.isNotEmpty)
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '解析参数',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ..._parsedParams!.entries.map((entry) => 
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text('${entry.key}: ${entry.value}'),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '深度链接说明',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('深度链接是一种特殊的 URL，用于直接打开应用并导航到特定页面或执行特定操作。'),
                      const SizedBox(height: 10),
                      const Text('在 Flutter for OpenHarmony 中，深度链接的处理流程：'),
                      const SizedBox(height: 5),
                      const Text('1. 配置应用的 URL Scheme'),
                      const Text('2. 监听来自平台的深度链接'),
                      const Text('3. 解析深度链接参数'),
                      const Text('4. 根据参数执行相应操作'),
                    ],
                  ),
                ),
              ),
              widget.child ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class DeepLinkConfigInfo extends StatelessWidget {
  const DeepLinkConfigInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '配置信息',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text('在 OpenHarmony 中配置 URL Scheme：'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[100],
              child: const Text(
                '''// 在 entry/src/main/config.json 中添加
{
  "module": {
    "abilities": [
      {
        "skills": [
          {
            "actions": ["ohos.want.action.viewData"],
            "entities": ["ohos.want.entity.url"],
            "uris": [
              {
                "scheme": "myapp",
                "host": "*"
              }
            ]
          }
        ]
      }
    ]
  }
}''',
                style: TextStyle(fontFamily: 'Monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}