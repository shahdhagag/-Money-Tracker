import 'dart:io';
import 'transaction.dart';

class MoneyTracker {
  List<Transaction> transactions = [];

  /// 1)
  void addTransaction() {
    print('Enter amount: ');
    String? amountInput = stdin.readLineSync();
    double? amount;

    if (amountInput != null) {
      amount = double.tryParse(amountInput);
    }

    if (amount == null) {
      print('Invalid amount. Please enter a numeric value.');
      return;
    }

    print('Enter type (Income/Expense): ');
    String? type = stdin.readLineSync();
    if (type == null || (type != 'Income' && type != 'Expense')) {
      print('Invalid type. Please enter either "Income" or "Expense".');
      return;
    }

    print('Enter category: ');
    String? category = stdin.readLineSync();
    if (category == null || category.isEmpty) {
      print('Category cannot be empty.');
      return;
    }

    print('Enter date (yyyy-MM-dd): ');
    String? dateInput = stdin.readLineSync();
    DateTime? date;

    if (dateInput != null) {
      date = DateTime.tryParse(dateInput);
    }

    if (date == null) {
      print('Invalid date format. Please use yyyy-MM-dd.');
      return;
    }

    print('Enter description (optional): ');
    String? description = stdin.readLineSync();

    transactions
        .add(Transaction(amount, type, category, date, description ?? ''));
    print('Transaction added successfully.');
  }

  // 2) view all transactions
  void viewTransactions() {
    if (transactions.isEmpty) {
      print('No transactions available.');
    } else {
      for (var transaction in transactions) {
        transaction.display();
      }
    }
  }

  // 3) Method to edit a transaction
  void editTransaction() {
    print('Enter the index of the transaction to edit: ');
    int index = int.parse(stdin.readLineSync()!);

    if (index < 0 || index >= transactions.length) {
      print('Invalid index.');
      return;
    }

    print('Enter new amount: ');
    transactions[index].amount = double.parse(stdin.readLineSync()!);

    print('Enter new type (Income/Expense): ');
    String type = stdin.readLineSync()!.trim();
    if (type != 'Income' && type != 'Expense') {
      print('Invalid type. Enter either "Income" or "Expense".');
    }
    transactions[index].type = type;

    print('Enter new category: ');
    transactions[index].category = stdin.readLineSync()!;

    print('Enter new date (yyyy-mm-dd): ');
    transactions[index].date = DateTime.parse(stdin.readLineSync()!);

    print('Enter new description (optional): ');
    transactions[index].description = stdin.readLineSync()!;

    print('Transaction updated successfully.');
  }

  // 4) Method to delete a transaction
  void deleteTransaction() {
    print('Enter the index of the transaction to delete: ');
    int index = int.parse(stdin.readLineSync()!);

    if (index < 0 || index >= transactions.length) {
      print('Invalid index.');
      return;
    } else
      transactions.removeAt(index);
    print('Transaction deleted successfully.');
  }

  /////////////////////////

  ////  to sort transactions by date, category, or amount.
  //by date
  void sortTransactionsByDate() {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    print('Transactions sorted by date.');
  }

//  by category
  void sortTransactionsByCategory() {
    transactions.sort((a, b) => a.category.compareTo(b.category));
    print('Transactions sorted by category.');
  }

// by amount
  void sortTransactionsByAmount() {
    transactions.sort((a, b) => a.amount.compareTo(b.amount));
    print('Transactions sorted by amount.');
  }

  ////////////////////////////
  void searchTransactions(String keyword) {
    // Create a list to hold the search results
    List<Transaction> results = [];

    for (var transaction in transactions) {
      if (transaction.description.contains(keyword)) {
        results.add(transaction);
      }
    }

    if (results.isEmpty) {
      print('No transactions found with keyword "$keyword".');
    } else {
      // Print each transaction in the results list
      for (var transaction in results) {
        transaction.display();
      }
    }
  }

  //////////// Generate basic financial reports/////////////////
  void generateReport(DateTime startDate, DateTime endDate) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (var transaction in transactions) {
      if (transaction.date.isAfter(startDate) &&
          transaction.date.isBefore(endDate)) {
        // Add to total income if the transaction type is 'Income'
        if (transaction.type == 'Income') {
          totalIncome += transaction.amount;
        }

        // Add to total expense if the transaction type is 'Expense'
        else if (transaction.type == 'Expense') {
          totalExpense += transaction.amount;
        }
      }
    }

    // Calculate net balance (total income - total expense)
    double netBalance = totalIncome - totalExpense;

    print('Financial Report ::');
    print('Total Income: \$${totalIncome}');
    print('Total Expenses: \$${totalExpense}');
    print('Net Balance: \$${netBalance}');
  }
}
