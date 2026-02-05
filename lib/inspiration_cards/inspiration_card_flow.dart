import 'package:flutter/material.dart';
import 'inspiration_model.dart';
import 'card_widget.dart';
import 'add_card_form.dart';
import 'tag_filter.dart';

class InspirationCardFlow extends StatefulWidget {
  const InspirationCardFlow({Key? key}) : super(key: key);

  @override
  _InspirationCardFlowState createState() => _InspirationCardFlowState();
}

class _InspirationCardFlowState extends State<InspirationCardFlow> {
  List<InspirationCard> _cards = [];
  String? _selectedTag;
  InspirationCard? _randomCard;

  @override
  void initState() {
    super.initState();
    // Add some sample cards for demo
    _addSampleCards();
  }

  void _addSampleCards() {
    final samples = [
      InspirationCard(
        id: '1',
        content: '使用Flutter的动画控制器可以创建流畅的卡片交互动画',
        tags: ['工作', '创意'],
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      InspirationCard(
        id: '2',
        content: '早晨冥想10分钟可以提高一天的专注力',
        tags: ['生活', '健康'],
        createdAt: DateTime.now().subtract(Duration(hours: 3)),
      ),
      InspirationCard(
        id: '3',
        content: '学习一门新语言可以锻炼大脑的灵活性',
        tags: ['学习'],
        createdAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      InspirationCard(
        id: '4',
        content: '尝试使用不同的角度思考问题，会有新的发现',
        tags: ['创意'],
        createdAt: DateTime.now().subtract(Duration(days: 2)),
      ),
      InspirationCard(
        id: '5',
        content: '保持充足的水分摄入对皮肤和身体都很重要',
        tags: ['生活', '健康'],
        createdAt: DateTime.now().subtract(Duration(days: 3)),
      ),
    ];
    setState(() {
      _cards = samples;
    });
  }

  void _addCard(InspirationCard card) {
    setState(() {
      _cards.insert(0, card);
    });
  }

  void _onCardTap(InspirationCard card) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('灵感详情'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(card.content),
              SizedBox(height: 12),
              if (card.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: card.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.blue[100],
                    );
                  }).toList(),
                ),
              SizedBox(height: 8),
              Text(
                '创建于: ${_formatDate(card.createdAt)}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
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

  void _filterByTag(String? tag) {
    setState(() {
      _selectedTag = tag;
    });
  }

  void _randomReview() {
    if (_cards.isEmpty) return;
    
    final randomIndex = DateTime.now().millisecondsSinceEpoch % _cards.length;
    setState(() {
      _randomCard = _cards[randomIndex];
    });
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('随机回顾'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _randomCard!.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              if (_randomCard!.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: _randomCard!.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.blue[100],
                    );
                  }).toList(),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('关闭'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _randomReview();
              },
              child: Text('再随机一条'),
            ),
          ],
        );
      },
    );
  }

  List<InspirationCard> get _filteredCards {
    if (_selectedTag == null) {
      return _cards;
    }
    return _cards.where((card) => card.tags.contains(_selectedTag!)).toList();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          // Header with random review button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '灵感速记',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _randomReview,
                  icon: Icon(Icons.shuffle),
                  label: Text('随机回顾'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tag filter
          TagFilter(
            onFilterChanged: _filterByTag,
            selectedTag: _selectedTag,
          ),

          // Add card form
          AddCardForm(onAddCard: _addCard),

          // Card count
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '共 ${_filteredCards.length} 条灵感',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          // Card flow
          Expanded(
            child: _filteredCards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb_outline, size: 64, color: Colors.grey[400]),
                        SizedBox(height: 16),
                        Text('暂无灵感', style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 8),
                        Text('添加你的第一条灵感吧！', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredCards.length,
                    itemBuilder: (context, index) {
                      final card = _filteredCards[index];
                      // Calculate scale and elevation for stacked effect
                      final scale = 1.0 - (index * 0.02).clamp(0.0, 0.1);
                      final elevation = 2.0 + (index * 0.5).clamp(0.0, 2.0);
                      
                      return CardWidget(
                        card: card,
                        onTap: _onCardTap,
                        scale: scale,
                        elevation: elevation,
                        index: index,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
