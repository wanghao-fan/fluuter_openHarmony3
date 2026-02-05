class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

List<String> expenseCategories = [
  '餐饮',
  '交通',
  '购物',
  '娱乐',
  '医疗',
  '其他',
];
