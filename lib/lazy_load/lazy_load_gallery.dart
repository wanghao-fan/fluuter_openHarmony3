import 'package:flutter/material.dart';
import 'lazy_load_image.dart';

class LazyLoadGallery extends StatefulWidget {
  const LazyLoadGallery({Key? key}) : super(key: key);

  @override
  _LazyLoadGalleryState createState() => _LazyLoadGalleryState();
}

class _LazyLoadGalleryState extends State<LazyLoadGallery> {
  late ScrollController _scrollController;
  int _visibleCount = 0;
  bool _isLoading = false;

//  'https://dummyimage.com/800x800/FF5733/FFFFFF&text=Image+1',
//     'https://dummyimage.com/800x800/33FF57/FFFFFF&text=Image+2',
//     'https://dummyimage.com/800x800/3357FF/FFFFFF&text=Image+3',
//     'https://dummyimage.com/800x800/FF33F5/FFFFFF&text=Image+4',
//     'https://dummyimage.com/800x800/F5FF33/000000&text=Image+5',
//     'https://dummyimage.com/800x800/33FFF5/000000&text=Image+6',
//     'https://dummyimage.com/800x800/FF8C33/FFFFFF&text=Image+7',
//     'https://dummyimage.com/800x800/8C33FF/FFFFFF&text=Image+8',
//     'https://dummyimage.com/800x800/33FF8C/000000&text=Image+9',
//     'https://dummyimage.com/800x800/FF3333/FFFFFF&text=Image+10',
//     'https://dummyimage.com/800x800/33FF33/000000&text=Image+11',
//     'https://dummyimage.com/800x800/3333FF/FFFFFF&text=Image+12',
//     'https://dummyimage.com/800x800/FF33FF/000000&text=Image+13',
//     'https://dummyimage.com/800x800/FFFF33/000000&text=Image+14',
//     'https://dummyimage.com/800x800/33FFFF/000000&text=Image+15',
//     'https://dummyimage.com/800x800/FF6633/FFFFFF&text=Image+16',
//     'https://dummyimage.com/800x800/6633FF/FFFFFF&text=Image+17',
//     'https://dummyimage.com/800x800/33FF66/000000&text=Image+18',
//     'https://dummyimage.com/800x800/FF3366/FFFFFF&text=Image+19',
//     'https://dummyimage.com/800x800/3366FF/FFFFFF&text=Image+20',
 
  // 模拟图片数据 - 使用 dummyimage.com 提供的随机纯色占位图
  final List<String> _imageUrls = [
    'https://picsum.photos/800/600?random=1',
    'https://picsum.photos/800/600?random=2',
    'https://picsum.photos/800/600?random=3',
    'https://picsum.photos/800/600?random=4',
    'https://picsum.photos/800/600?random=5',
    'https://picsum.photos/800/600?random=6',
    'https://picsum.photos/800/600?random=7',
    'https://picsum.photos/800/600?random=8',
    'https://picsum.photos/800/600?random=9',
    'https://picsum.photos/800/600?random=10',
    'https://picsum.photos/800/600?random=11',
    'https://picsum.photos/800/600?random=12',
    'https://picsum.photos/800/600?random=13',
    'https://picsum.photos/800/600?random=14',
    'https://picsum.photos/800/600?random=15',
    'https://picsum.photos/800/600?random=16',
    'https://picsum.photos/800/600?random=17',
    'https://picsum.photos/800/600?random=18',
    'https://picsum.photos/800/600?random=19',
    'https://picsum.photos/800/600?random=20',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreImages();
    }
  }

  Future<void> _loadMoreImages() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // 模拟加载更多图片
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      // 生成更多图片URL
      final startIndex = _imageUrls.length + 1;
      final colors = [
        'FF5733', '33FF57', '3357FF', 'FF33F5', 'F5FF33',
        '33FFF5', 'FF8C33', '8C33FF', '33FF8C', 'FF3333'
      ];
      
      for (int i = 0; i < 10; i++) {
        final colorIndex = i % colors.length;
        final textColor = (i % 2 == 0) ? 'FFFFFF' : '000000';
        _imageUrls.add('https://dummyimage.com/800x800/${colors[colorIndex]}/${textColor}&text=Image+${startIndex + i}');
      }
      _isLoading = false;
    });
  }

  void _onImageVisible() {
    setState(() {
      _visibleCount++;
      print('已加载图片数量: $_visibleCount');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = 2;
    final itemWidth = (screenWidth - 30) / crossAxisCount; // 30 是 padding 和 spacing 的总和

    return Scaffold(
      appBar: AppBar(
        title: const Text('图片懒加载画廊'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // 统计信息
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('总图片数: ${_imageUrls.length}'),
                  Text('已加载: $_visibleCount'),
                ],
              ),
            ),

            // 图片网格
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: _imageUrls.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _imageUrls.length) {
                    // 加载更多指示器
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      // 点击图片的交互效果
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('图片 ${index + 1} 被点击'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LazyLoadImage(
                          imageUrl: _imageUrls[index],
                          width: itemWidth,
                          height: itemWidth,
                          fit: BoxFit.cover,
                          placeholder: Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Text('加载中...', style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          errorWidget: Container(
                            color: Colors.grey[100],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          ),
                          onImageLoaded: _onImageVisible,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
