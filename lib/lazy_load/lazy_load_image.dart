import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LazyLoadImage extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;
  final Duration fadeInDuration;
  final bool enableMemoryCache;
  final VoidCallback? onImageLoaded;

  const LazyLoadImage({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.placeholder = const Center(child: CircularProgressIndicator()),
    this.errorWidget = const Center(child: Icon(Icons.error, color: Colors.red)),
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.enableMemoryCache = true,
    this.onImageLoaded,
  }) : super(key: key);

  @override
  _LazyLoadImageState createState() => _LazyLoadImageState();
}

class _LazyLoadImageState extends State<LazyLoadImage> {
  bool _isVisible = false;
  bool _isLoading = false;
  bool _loadFailed = false;
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    // 初始检查可见性
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('初始化检查可见性');
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!_isVisible && _isInViewport()) {
      print('图片进入视口，开始加载: ${widget.imageUrl}');
      setState(() {
        _isVisible = true;
      });
      _loadImage();
    }
  }

  bool _isInViewport() {
    // 简化可见性检测，直接返回 true，确保图片能够加载
    return true;
  }

  Future<void> _loadImage() async {
    if (_isLoading || _loadFailed) return;

    setState(() {
      _isLoading = true;
    });

    try {
      print('开始加载图片: ${widget.imageUrl}');
      // 直接创建 NetworkImage 并触发加载
      final networkImage = NetworkImage(widget.imageUrl);
      
      // 强制加载图片
      await precacheImage(networkImage, context);
      print('图片加载成功: ${widget.imageUrl}');
      
      setState(() {
        _imageProvider = networkImage;
        _isLoading = false;
      });
      
      // 图片加载完成后调用回调
      if (widget.onImageLoaded != null) {
        widget.onImageLoaded!();
      }
    } catch (e) {
      print('图片加载失败: $e');
      setState(() {
        _loadFailed = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (!_isVisible) {
      return widget.placeholder;
    }

    if (_loadFailed) {
      return widget.errorWidget;
    }

    if (_imageProvider == null) {
      return widget.placeholder;
    }

    return Image(
      image: _imageProvider!,
      fit: widget.fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return widget.placeholder;
      },
      errorBuilder: (context, error, stackTrace) {
        print('图片显示错误: $error');
        setState(() {
          _loadFailed = true;
        });
        return widget.errorWidget;
      },
    );
  }
}
