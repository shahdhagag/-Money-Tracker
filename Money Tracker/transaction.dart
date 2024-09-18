class Transaction {
  double amount;
  String type;
  String category;
  DateTime date;
  String description;

  Transaction(this.amount, this.type, this.category, this.date,
      [this.description = ""]);

  void display() {
    print('Amount: \$${amount}');
    print('Type: $type');
    print('Category: $category');
    print('Date: ${date.toLocal()}');
    if (description.isNotEmpty) {
      print('Description: $description');
    }
    print('---');
  }
}
