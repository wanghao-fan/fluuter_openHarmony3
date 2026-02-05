import 'package:flutter/material.dart';
import 'digital_asset_model.dart';
import 'asset_card_widget.dart';

class DigitalAssetDashboard extends StatefulWidget {
  const DigitalAssetDashboard({Key? key}) : super(key: key);

  @override
  _DigitalAssetDashboardState createState() => _DigitalAssetDashboardState();
}

class _DigitalAssetDashboardState extends State<DigitalAssetDashboard> {
  List<AssetCategory> _assetCategories = mockAssetCategories;
  String? _selectedCategoryId;
  bool _isRefreshing = false;

  void _onAssetTap(DigitalAsset asset) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(asset.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('平台: ${asset.platform}'),
              SizedBox(height: 8),
              Text('数值: ${asset.value} ${asset.unit}'),
              SizedBox(height: 8),
              Text('描述: ${asset.description}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('关闭'),
            ),
          ],
        );
      },
    );
  }

  void _onCategoryTap(String categoryId) {
    setState(() {
      _selectedCategoryId = _selectedCategoryId == categoryId ? null : categoryId;
    });
  }

  Future<void> _refreshAssets() async {
    setState(() {
      _isRefreshing = true;
    });
    
    // 模拟网络请求
    await Future.delayed(Duration(seconds: 1));
    
    // 可以在这里更新真实数据
    setState(() {
      _assetCategories = mockAssetCategories;
      _isRefreshing = false;
    });
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'edit':
        return Icons.edit;
      case 'library_music':
        return Icons.library_music;
      case 'school':
        return Icons.school;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshAssets,
      color: Colors.blue,
      backgroundColor: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '个人数字资产仪表盘',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '汇总展示你在各平台的数字资产',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Category tabs
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _assetCategories.map((category) {
                    bool isSelected = _selectedCategoryId == category.id;
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => _onCategoryTap(category.id),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getCategoryIcon(category.icon),
                                size: 16,
                                color: isSelected ? Colors.white : Colors.grey[600],
                              ),
                              SizedBox(width: 8),
                              Text(
                                category.title,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.grey[800],
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(${category.assets.length})',
                                style: TextStyle(
                                  color: isSelected ? Colors.white.withOpacity(0.8) : Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Asset grid
            Expanded(
              child: _isRefreshing
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('正在刷新数据...'),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _getFilteredAssets().length,
                      itemBuilder: (context, index) {
                        final asset = _getFilteredAssets()[index];
                        return AssetCardWidget(
                          asset: asset,
                          onTap: _onAssetTap,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<DigitalAsset> _getFilteredAssets() {
    if (_selectedCategoryId == null) {
      return _assetCategories.expand((category) => category.assets).toList();
    }
    final category = _assetCategories.firstWhere(
      (cat) => cat.id == _selectedCategoryId!,
      orElse: () => AssetCategory(id: '', title: '', icon: '', assets: []),
    );
    return category.assets;
  }
}
