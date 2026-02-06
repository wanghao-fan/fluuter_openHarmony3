import 'package:flutter/material.dart';
import '../template_library/template_model.dart';
import '../template_library/template_list.dart';
import '../template_library/template_dialog.dart';

class TemplateDashboard extends StatefulWidget {
  final Function(String) onTemplateInsert;

  const TemplateDashboard({
    Key? key,
    required this.onTemplateInsert,
  }) : super(key: key);

  @override
  _TemplateDashboardState createState() => _TemplateDashboardState();
}

class _TemplateDashboardState extends State<TemplateDashboard> {
  late String _selectedCategoryId;
  late List<TemplateCategory> _categories;
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 初始化默认模板
    TemplateStorage.initializeDefaultTemplates();
    // 加载分类
    _categories = TemplateStorage.getCategories();
    if (_categories.isNotEmpty) {
      _selectedCategoryId = _categories[0].id;
    } else {
      _selectedCategoryId = '';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addTemplate() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTemplateDialog(
          categoryId: _selectedCategoryId,
          onTemplateAdded: () {
            setState(() {});
          },
        );
      },
    );
  }

  void _selectCategory(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _isSearching = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = '';
        _searchController.clear();
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _insertTemplate(Template template) {
    widget.onTemplateInsert(template.content);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已插入模板: ${template.content}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题和搜索按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '快捷短语/模板库',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '保存常用回复、地址信息等为模板，快速插入',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _toggleSearch,
                      icon: Icon(
                        _isSearching ? Icons.close : Icons.search,
                        color: Colors.blue,
                      ),
                      tooltip: _isSearching ? '取消搜索' : '搜索模板',
                    ),
                    IconButton(
                      onPressed: _addTemplate,
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                        size: 28,
                      ),
                      tooltip: '添加模板',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 搜索框
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  labelText: '搜索模板',
                  hintText: '请输入搜索关键词',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                autofocus: true,
              ),
            ),

          // 分类选择
          if (!_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = category.id == _selectedCategoryId;
                    return GestureDetector(
                      onTap: () => _selectCategory(category.id),
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getIconByName(category.icon),
                              size: 16,
                              color: isSelected ? Colors.white : Colors.grey[600],
                            ),
                            SizedBox(width: 8),
                            Text(
                              category.name,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey[800],
                                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

          // 模板列表或搜索结果
          Expanded(
            child: _isSearching
                ? _buildSearchResults()
                : TemplateList(
                    categoryId: _selectedCategoryId,
                    onTemplateSelect: _insertTemplate,
                    onRefresh: () {
                      setState(() {});
                    },
                  ),
          ),

          // 使用说明
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '使用说明',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. 点击分类标签切换不同类型的模板',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '2. 点击模板直接插入到输入框',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '3. 点击右上角添加新模板',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '4. 点击搜索按钮查找特定模板',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = TemplateStorage.searchTemplates(_searchQuery);
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text('没有找到匹配的模板', style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 8),
            Text('请尝试其他关键词', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final template = results[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(
              template.content,
              style: TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (template.description != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      template.description!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    '分类: ${_getCategoryName(template.categoryId)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () => _insertTemplate(template),
              icon: Icon(Icons.insert_comment, color: Colors.blue),
              tooltip: '插入模板',
            ),
            onTap: () => _insertTemplate(template),
          ),
        );
      },
    );
  }

  IconData _getIconByName(String iconName) {
    switch (iconName) {
      case 'chat_bubble':
        return Icons.chat_bubble;
      case 'location_on':
        return Icons.location_on;
      case 'phone':
        return Icons.phone;
      case 'more_horiz':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }

  String _getCategoryName(String categoryId) {
    final category = _categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => TemplateCategory(id: '', name: '未知', icon: ''),
    );
    return category.name;
  }
}
