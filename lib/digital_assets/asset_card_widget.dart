import 'package:flutter/material.dart';
import 'digital_asset_model.dart';

class AssetCardWidget extends StatefulWidget {
  final DigitalAsset asset;
  final Function(DigitalAsset)? onTap;

  const AssetCardWidget({
    Key? key,
    required this.asset,
    this.onTap,
  }) : super(key: key);

  @override
  _AssetCardWidgetState createState() => _AssetCardWidgetState();
}

class _AssetCardWidgetState extends State<AssetCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().whenComplete(() {
      if (widget.onTap != null) {
        widget.onTap!(widget.asset);
      }
    });
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'star':
        return Icons.star;
      case 'repo':
        return Icons.folder;
      case 'git_commit':
        return Icons.code;
      case 'article':
        return Icons.article;
      case 'text_fields':
        return Icons.text_fields;
      case 'visibility':
        return Icons.visibility;
      case 'music_note':
        return Icons.music_note;
      case 'queue_music':
        return Icons.queue_music;
      case 'mic':
        return Icons.mic;
      case 'school':
        return Icons.school;
      case 'card_membership':
        return Icons.card_membership;
      case 'access_time':
        return Icons.access_time;
      case 'code':
        return Icons.code;
      case 'edit':
        return Icons.edit;
      case 'library_music':
        return Icons.library_music;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(_scaleAnimation.value),
      alignment: Alignment.center,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with icon and platform
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: widget.asset.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getIcon(widget.asset.icon),
                            color: widget.asset.color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          widget.asset.platform,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.asset.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.asset.unit,
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.asset.color,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Title
                Text(
                  widget.asset.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),

                // Value
                Text(
                  '${widget.asset.value}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.asset.color,
                  ),
                ),
                SizedBox(height: 12),

                // Description
                Text(
                  widget.asset.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
