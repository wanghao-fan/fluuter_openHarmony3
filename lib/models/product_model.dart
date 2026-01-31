class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final List<String> images;
  /// attributes: {"颜色": ["红","蓝"], "尺寸": ["S","M","L"]}
  final Map<String, List<String>> attributes;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.attributes,
  });

  // 简单示例：根据已选属性生成 SKU 描述
  String skuDescription(Map<String, String> selected) {
    final parts = <String>[];
    selected.forEach((key, value) {
      parts.add('$key: $value');
    });
    return parts.join(' | ');
  }
}

// 提供一个示例商品用于演示
final demoProduct = Product(
  id: 'p001',
  title: '示例商品 - 舒适运动鞋',
  description: '轻盈透气，适合日常与运动。多色可选，多尺寸覆盖。',
  price: 299.0,
  images: [
    'https://via.placeholder.com/600x400.png?text=Image+1',
    'https://via.placeholder.com/600x400.png?text=Image+2',
    'https://via.placeholder.com/600x400.png?text=Image+3',
  ],
  attributes: {
    '颜色': ['红', '蓝', '黑'],
    '尺码': ['38', '39', '40', '41']
  },
);
