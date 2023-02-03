class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date = DateTime.now();

  Transaction({required this.id, required this.title, required this.amount});
}
