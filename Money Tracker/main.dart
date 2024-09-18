import 'moneyTracker.dart';
import 'dart:io';

void main() {
  MoneyTracker tracker = MoneyTracker();

  while (true) {
    print(
        'Enter command (add, view, edit, delete, search, sort, report, exit): ');
    String command = stdin.readLineSync()!;

    if (command == 'add') {
      tracker.addTransaction();
    } else if (command == 'view') {
      tracker.viewTransactions();
    } else if (command == 'edit') {
      tracker.editTransaction();
    } else if (command == 'delete') {
      tracker.deleteTransaction();
    } else if (command == 'search') {
      print('Enter keyword to search: ');
      String keyword = stdin.readLineSync()!;
      tracker.searchTransactions(keyword);
    } else if (command == 'sort') {
      print('Sort by (date, category, amount): ');
      String sortBy = stdin.readLineSync()!;
      if (sortBy == 'date') {
        tracker.sortTransactionsByDate();
      } else if (sortBy == 'category') {
        tracker.sortTransactionsByCategory();
      } else if (sortBy == 'amount') {
        tracker.sortTransactionsByAmount();
      } else {
        print(
            'Invalid sort option. Please enter "date", "category", or "amount".');
      }
    } else if (command == 'report') {
      print('Enter start date (yyyy-MM-dd): ');
      DateTime startDate = DateTime.parse(stdin.readLineSync()!);

      print('Enter end date (yyyy-MM-dd): ');
      DateTime endDate = DateTime.parse(stdin.readLineSync()!);

      tracker.generateReport(startDate, endDate);
    } else if (command == 'exit') {
      break;
    } else {
      print('Unknown command. Please try again.');
    }
  }
}
