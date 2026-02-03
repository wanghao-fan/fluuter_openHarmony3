import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final int totalItems;
  final Function(int) onPageChanged;
  final bool showTotal;
  final bool showSizeChanger;
  final List<int> sizeOptions;
  final Function(int)? onSizeChanged;
  final bool showQuickJumper;
  final Color activeColor;
  final Color inactiveColor;
  final Color disabledColor;
  final double buttonRadius;
  
  const Pagination._({
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalItems,
    required this.onPageChanged,
    required this.showTotal,
    required this.showSizeChanger,
    required this.sizeOptions,
    required this.onSizeChanged,
    required this.showQuickJumper,
    required this.activeColor,
    required this.inactiveColor,
    required this.disabledColor,
    required this.buttonRadius,
    Key? key,
  }) : super(key: key);
  
  factory Pagination({
    Key? key,
    required int currentPage,
    required int totalPages,
    int pageSize = 10,
    int totalItems = 0,
    required Function(int) onPageChanged,
    bool showTotal = true,
    bool showSizeChanger = false,
    List<int> sizeOptions = const [10, 20, 50, 100],
    Function(int)? onSizeChanged,
    bool showQuickJumper = false,
    Color activeColor = Colors.deepPurple,
    Color inactiveColor = Colors.grey,
    Color? disabledColor,
    double buttonRadius = 4.0,
  }) {
    return Pagination._(
      key: key,
      currentPage: currentPage,
      totalPages: totalPages,
      pageSize: pageSize,
      totalItems: totalItems,
      onPageChanged: onPageChanged,
      showTotal: showTotal,
      showSizeChanger: showSizeChanger,
      sizeOptions: sizeOptions,
      onSizeChanged: onSizeChanged,
      showQuickJumper: showQuickJumper,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      disabledColor: disabledColor ?? Colors.grey[300]!,
      buttonRadius: buttonRadius,
    );
  }

  void _handlePageChange(int page) {
    if (page >= 1 && page <= totalPages && page != currentPage) {
      onPageChanged(page);
    }
  }

  void _handleSizeChange(int size) {
    if (onSizeChanged != null && size != pageSize) {
      onSizeChanged!(size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 左侧：总数和每页大小
            Row(
              children: [
                if (showTotal)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      '共 $totalItems 条记录',
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ),
                if (showSizeChanger && onSizeChanged != null)
                  Row(
                    children: [
                      const Text('每页显示：', style: TextStyle(fontSize: 14.0)),
                      DropdownButton<int>(
                        value: pageSize,
                        onChanged: (value) {
                          if (value != null) {
                            _handleSizeChange(value);
                          }
                        },
                        items: sizeOptions.map((size) {
                          return DropdownMenuItem<int>(
                            value: size,
                            child: Text('$size 条'),
                          );
                        }).toList(),
                        style: const TextStyle(fontSize: 14.0),
                        underline: Container(),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(width: 16.0),
            
            // 右侧：页码控制
            Row(
              children: [
                // 首页按钮
                _buildPageButton(
                  '首页',
                  onPressed: currentPage > 1 ? () => _handlePageChange(1) : null,
                ),
                const SizedBox(width: 8.0),
                
                // 上一页按钮
                _buildPageButton(
                  '上一页',
                  onPressed: currentPage > 1 ? () => _handlePageChange(currentPage - 1) : null,
                ),
                const SizedBox(width: 16.0),
                
                // 页码列表
                _buildPageNumbers(),
                const SizedBox(width: 16.0),
                
                // 下一页按钮
                _buildPageButton(
                  '下一页',
                  onPressed: currentPage < totalPages ? () => _handlePageChange(currentPage + 1) : null,
                ),
                const SizedBox(width: 8.0),
                
                // 末页按钮
                _buildPageButton(
                  '末页',
                  onPressed: currentPage < totalPages ? () => _handlePageChange(totalPages) : null,
                ),
                
                // 快速跳转
                if (showQuickJumper)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        const Text('前往', style: TextStyle(fontSize: 14.0)),
                        Container(
                          width: 60.0,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onSubmitted: (value) {
                              final page = int.tryParse(value);
                              if (page != null) {
                                _handlePageChange(page);
                              }
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            ),
                          ),
                        ),
                        Text('页', style: TextStyle(fontSize: 14.0)),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageButton(String text, {VoidCallback? onPressed}) {
    final isDisabled = onPressed == null;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(buttonRadius),
        border: Border.all(
          color: isDisabled ? disabledColor : inactiveColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(buttonRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Text(
              text,
              style: TextStyle(
                color: isDisabled ? disabledColor : inactiveColor,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageNumbers() {
    final List<Widget> pageWidgets = [];
    final int startPage = currentPage > 3 ? currentPage - 2 : 1;
    final int endPage = startPage + 4 > totalPages ? totalPages : startPage + 4;
    
    // 显示省略号
    if (startPage > 1) {
      pageWidgets.add(
        _buildPageButton('1', onPressed: () => _handlePageChange(1)),
      );
      if (startPage > 2) {
        pageWidgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('...', style: TextStyle(fontSize: 14.0)),
          ),
        );
      }
    }
    
    // 显示页码
    for (int i = startPage; i <= endPage; i++) {
      pageWidgets.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(buttonRadius),
            color: i == currentPage ? activeColor : Colors.transparent,
            border: Border.all(
              color: i == currentPage ? activeColor : inactiveColor,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handlePageChange(i),
              borderRadius: BorderRadius.circular(buttonRadius),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: i == currentPage ? Colors.white : inactiveColor,
                    fontSize: 14.0,
                    fontWeight: i == currentPage ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    // 显示省略号
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) {
        pageWidgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('...', style: TextStyle(fontSize: 14.0)),
          ),
        );
      }
      pageWidgets.add(
        _buildPageButton('$totalPages', onPressed: () => _handlePageChange(totalPages)),
      );
    }
    
    return Row(children: pageWidgets);
  }
}
