import 'dart:convert';
import 'dart:io';

class TemplateCategory {
  final String id;
  final String name;
  final String icon;

  TemplateCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }

  factory TemplateCategory.fromJson(Map<String, dynamic> json) {
    return TemplateCategory(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}

class Template {
  final String id;
  final String content;
  final String categoryId;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Template({
    required this.id,
    required this.content,
    required this.categoryId,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'categoryId': categoryId,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      id: json['id'],
      content: json['content'],
      categoryId: json['categoryId'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// 内存缓存
class TemplateStorage {
  static final Map<String, List<Template>> _templatesByCategory = {};
  static final List<TemplateCategory> _categories = [
    TemplateCategory(id: '1', name: '常用回复', icon: 'chat_bubble'),
    TemplateCategory(id: '2', name: '地址信息', icon: 'location_on'),
    TemplateCategory(id: '3', name: '联系方式', icon: 'phone'),
    TemplateCategory(id: '4', name: '其他', icon: 'more_horiz'),
  ];

  // 获取所有分类
  static List<TemplateCategory> getCategories() {
    return _categories;
  }

  // 获取指定分类的模板
  static List<Template> getTemplatesByCategory(String categoryId) {
    return _templatesByCategory[categoryId] ?? [];
  }

  // 获取所有模板
  static List<Template> getAllTemplates() {
    final allTemplates = <Template>[];
    _templatesByCategory.values.forEach(allTemplates.addAll);
    return allTemplates;
  }

  // 添加模板
  static void addTemplate(Template template) {
    if (!_templatesByCategory.containsKey(template.categoryId)) {
      _templatesByCategory[template.categoryId] = [];
    }
    _templatesByCategory[template.categoryId]!.add(template);
  }

  // 更新模板
  static void updateTemplate(Template template) {
    final templates = _templatesByCategory[template.categoryId];
    if (templates != null) {
      final index = templates.indexWhere((t) => t.id == template.id);
      if (index != -1) {
        templates[index] = template;
      }
    }
  }

  // 删除模板
  static void deleteTemplate(String templateId) {
    for (var categoryId in _templatesByCategory.keys) {
      final templates = _templatesByCategory[categoryId];
      if (templates != null) {
        templates.removeWhere((t) => t.id == templateId);
      }
    }
  }

  // 搜索模板
  static List<Template> searchTemplates(String query) {
    final allTemplates = getAllTemplates();
    return allTemplates.where((template) {
      return template.content.toLowerCase().contains(query.toLowerCase()) ||
             (template.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();
  }

  // 初始化默认模板
  static void initializeDefaultTemplates() {
    // 检查是否已有模板
    if (getAllTemplates().isNotEmpty) {
      return;
    }

    // 添加默认模板
    final defaultTemplates = [
      Template(
        id: '1',
        content: '您好，请问有什么可以帮助您的？',
        categoryId: '1',
        description: '常用问候语',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Template(
        id: '2',
        content: '好的，我明白了，马上为您处理。',
        categoryId: '1',
        description: '确认收到',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Template(
        id: '3',
        content: '感谢您的耐心等待。',
        categoryId: '1',
        description: '感谢语',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Template(
        id: '4',
        content: '中国北京市海淀区中关村大街1号',
        categoryId: '2',
        description: '公司地址',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Template(
        id: '5',
        content: '13800138000',
        categoryId: '3',
        description: '联系电话',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    for (var template in defaultTemplates) {
      addTemplate(template);
    }
  }
}
