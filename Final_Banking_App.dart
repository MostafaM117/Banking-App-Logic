import 'dart:io';

class BankAccount {
  String name;
  double balance;
  final Map<String, double> transactions = {};

  BankAccount(this.name, this.balance);

  void deposit(double depositedmoney){
    balance += depositedmoney; 
    print("Done, Your Current Balance is $balance");
    DateTime time = new DateTime.now(); 
    String timeformat = time.toString().substring(0,19);
    transactions["$timeformat Deposited"] = depositedmoney;
  }

  void withdraw(double withdrawnmoney){
    if(withdrawnmoney > balance){
      throw new InsufficientBalance();
    }
    else {
      balance -= withdrawnmoney;
      print("Done, Your Current Balance is $balance");
      DateTime time = new DateTime.now(); 
      String timeformat = time.toString().substring(0,19);
      transactions["$timeformat Withdrew"] = withdrawnmoney;
      }
  }
  void showTransactions() {
    transactions.forEach(
      (key, value){
        print('$key $value');
      }
    );
  }
}
  class InsufficientBalance implements Exception{
    String errmessage(){
      return "Cannot Withdraw, Insufficient Balance.";
  }
}

void main() {
  // List to store all bank accounts
  List<BankAccount> bankAccounts = [];

  // Ask for the account holder's name
  stdout.write('Please Enter Your Name: ');
  String? name = stdin.readLineSync();

  while (name!.isEmpty) {
    print('Name cannot be empty.');
    stdout.write('Please Enter Your Name: ');
    name = stdin.readLineSync();
  }
  print('Hello, ${name}!');

  // Ask for initial deposit amount
  stdout.write('How much would you like to deposit as your initial balance?:');
  String? initialBalanceInput = stdin.readLineSync();

  if (initialBalanceInput != null) {
    double initialBalance = double.parse(initialBalanceInput);

    // Create a new bank account
    BankAccount newAccount = BankAccount(name, initialBalance);

    bankAccounts.add(newAccount);
    print('Account created successfully.');

    bool isRunning = true;
    while (isRunning) {
      stdout.write(
          'Choose an option:\n1. Deposit\n2. Withdraw\n3. Check Balance\n4. Veiw transactions history\n5. Exit\n');
      int option = int.parse(stdin.readLineSync() ?? '');

      switch (option) {
        // Deposit
        case 1:
          stdout.write('Enter the amount to deposit: ');
          double deposit = double.parse(stdin.readLineSync() ?? '');
          if (deposit <= 0) {
            print('Invalid input. Please enter a positive amount.');
          } else {
            newAccount.deposit(deposit);
          }
          break;

        // Withdrawal
        case 2:
          stdout.write('Enter the amount to withdraw: ');
          double withdrawal = double.parse(stdin.readLineSync() ?? '');
          if (withdrawal <= 0) {
            print('Invalid input. Please enter a positive amount.');
          } 
            try{
              newAccount.withdraw(withdrawal);
                } on InsufficientBalance {
                print(InsufficientBalance().errmessage());
                }
          break;
        // Check Balance
        case 3:
          print('Current balance: \$${newAccount.balance}');
          break;
        // Exit the loop
        case 4:
          newAccount.showTransactions();
          case 5:
          isRunning = false;
          print('App Exited\nThank you for using our banking system!');
          exit(0);
        default:
          print('Invalid choice. Please choose a valid option.');
          break;
      }
      // Ask for confirmation before exiting
      stdout.write('Do you want to perform another transaction? (yes/no): ');
      String? confirmation = stdin.readLineSync();
      if (confirmation?.toLowerCase() == 'no') {
        isRunning = false;
        print('App Exited\nThank you for using our banking system!');
      }
    }
  }
}