import 'package:flutter/material.dart';

class DigitalAsset {
  final String id;
  final String title;
  final String platform;
  final dynamic value;
  final String unit;
  final String icon;
  final Color color;
  final String description;

  DigitalAsset({
    required this.id,
    required this.title,
    required this.platform,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.description,
  });

  DigitalAsset copyWith({
    String? id,
    String? title,
    String? platform,
    dynamic? value,
    String? unit,
    String? icon,
    Color? color,
    String? description,
  }) {
    return DigitalAsset(
      id: id ?? this.id,
      title: title ?? this.title,
      platform: platform ?? this.platform,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }
}

class AssetCategory {
  final String id;
  final String title;
  final String icon;
  final List<DigitalAsset> assets;

  AssetCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.assets,
  });
}

// 模拟数据
List<AssetCategory> mockAssetCategories = [
  AssetCategory(
    id: 'coding',
    title: '编程资产',
    icon: 'code',
    assets: [
      DigitalAsset(
        id: 'github_stars',
        title: 'GitHub Stars',
        platform: 'GitHub',
        value: 128,
        unit: '个',
        icon: 'star',
        color: Color(0xFF24292E),
        description: 'GitHub仓库获得的Star数',
      ),
      DigitalAsset(
        id: 'github_repos',
        title: '仓库数量',
        platform: 'GitHub',
        value: 24,
        unit: '个',
        icon: 'repo',
        color: Color(0xFF24292E),
        description: 'GitHub仓库数量',
      ),
      DigitalAsset(
        id: 'code_commits',
        title: '代码提交',
        platform: 'Git',
        value: 356,
        unit: '次',
        icon: 'git_commit',
        color: Color(0xFFF05032),
        description: 'Git代码提交次数',
      ),
    ],
  ),
  AssetCategory(
    id: 'content',
    title: '内容创作',
    icon: 'edit',
    assets: [
      DigitalAsset(
        id: 'articles',
        title: '文章数量',
        platform: '博客',
        value: 42,
        unit: '篇',
        icon: 'article',
        color: Color(0xFF3498DB),
        description: '发表的文章总数',
      ),
      DigitalAsset(
        id: 'words_count',
        title: '写作字数',
        platform: '博客',
        value: 125000,
        unit: '字',
        icon: 'text_fields',
        color: Color(0xFF3498DB),
        description: '累计写作字数',
      ),
      DigitalAsset(
        id: 'views',
        title: '阅读量',
        platform: '博客',
        value: 35000,
        unit: '次',
        icon: 'visibility',
        color: Color(0xFF3498DB),
        description: '文章总阅读量',
      ),
    ],
  ),
  AssetCategory(
    id: 'media',
    title: '媒体资产',
    icon: 'library_music',
    assets: [
      DigitalAsset(
        id: 'playlist_duration',
        title: '播放列表时长',
        platform: 'Spotify',
        value: 48.5,
        unit: '小时',
        icon: 'music_note',
        color: Color(0xFF1DB954),
        description: 'Spotify播放列表总时长',
      ),
      DigitalAsset(
        id: 'songs_count',
        title: '歌曲数量',
        platform: 'Spotify',
        value: 320,
        unit: '首',
        icon: 'queue_music',
        color: Color(0xFF1DB954),
        description: 'Spotify播放列表歌曲数量',
      ),
      DigitalAsset(
        id: 'podcasts_count',
        title: '播客订阅',
        platform: 'Spotify',
        value: 12,
        unit: '个',
        icon: 'mic',
        color: Color(0xFF1DB954),
        description: 'Spotify播客订阅数量',
      ),
    ],
  ),
  AssetCategory(
    id: 'learning',
    title: '学习资产',
    icon: 'school',
    assets: [
      DigitalAsset(
        id: 'courses_completed',
        title: '课程完成',
        platform: 'Coursera',
        value: 8,
        unit: '门',
        icon: 'school',
        color: Color(0xFF0056D6),
        description: '完成的在线课程数量',
      ),
      DigitalAsset(
        id: 'certificates',
        title: '证书数量',
        platform: 'Coursera',
        value: 6,
        unit: '个',
        icon: 'card_membership',
        color: Color(0xFF0056D6),
        description: '获得的课程证书数量',
      ),
      DigitalAsset(
        id: 'learning_hours',
        title: '学习时长',
        platform: 'Coursera',
        value: 120,
        unit: '小时',
        icon: 'access_time',
        color: Color(0xFF0056D6),
        description: '累计学习时长',
      ),
    ],
  ),
];
