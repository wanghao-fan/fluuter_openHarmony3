import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/image_carousel.dart';
import '../widgets/sku_selector.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, String> _selected = {};
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    for (final k in widget.product.attributes.keys) {
      final list = widget.product.attributes[k]!;
      if (list.isNotEmpty) _selected[k] = list.first;
    }
  }

  void _onSkuChanged(Map<String, String> selected, int quantity) {
    setState(() {
      _selected = Map.from(selected);
      _quantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final skuDesc = widget.product.skuDescription(_selected);
    return Scaffold(
      appBar: AppBar(title: const Text('商品详情')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCarousel(images: widget.product.images),
              const SizedBox(height: 12),
              Text(widget.product.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('¥ ${widget.product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, color: Colors.redAccent, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(widget.product.description),
              const Divider(height: 24),
              SkuSelector(attributes: widget.product.attributes, onChanged: _onSkuChanged),
              const SizedBox(height: 12),
              Text('已选: $skuDesc   数量: $_quantity', style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('已加入购物车：$skuDesc x $_quantity')));
                      },
                      child: const Text('加入购物车'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('购买：$skuDesc x $_quantity')));
                      },
                      child: const Text('立即购买'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
