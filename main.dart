import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  runApp(const AccountingApp());
}

class AccountingApp extends StatelessWidget {
  const AccountingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paf-Iast Account Management System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with the path to your logo image
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Paf-Iast',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement authentication logic here
                // For simplicity, check if both username and password are not empty
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                  );
                } else {
                  // Show error message or handle authentication failure
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid username or password.'),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen or perform registration logic
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RegistrationScreen()),
                // );
              },
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardModule extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardModule({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: const EdgeInsets.all(16.0),
        children: [
          DashboardModule(
            title: 'Accounts',
            icon: Icons.account_balance,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Accounts()),
              );
            },
          ),
          DashboardModule(
            title: 'Students',
            icon: Icons.school,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Students()),
              );
            },
          ),
          DashboardModule(
            title: 'Transactions',
            icon: Icons.swap_horiz,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Transactions()),
              );
            },
          ),
          DashboardModule(
            title: 'Notifications',
            icon: Icons.notifications,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Notifications()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Account {
  final String name;
  final double balance;

  Account({required this.name, required this.balance});
}

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  AccountsState createState() => AccountsState();
}

class AccountsState extends State<Accounts> {
  List<Account> accounts = _generateAccounts();

  // Function to generate a sample list of accounts
  static List<Account> _generateAccounts() {
    return [
      Account(name: 'Savings', balance: 1000.0),
      Account(name: 'Checking', balance: 500.0),
      // Add more accounts as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Accounts:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showAddAccountDialog(context);
                  },
                  child: const Text('Add Account'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display the list of accounts
            Expanded(
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (context, index) {
                  final account = accounts[index];
                  return ListTile(
                    title: Text(account.name),
                    subtitle: Text('Balance: \$${account.balance.toString()}'),
                    onTap: () {
                      _showAccountDetailsDialog(context, account);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteAccount(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController balanceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Account'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Account Name'),
              ),
              TextField(
                controller: balanceController,
                decoration: const InputDecoration(labelText: 'Initial Balance'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                double balance = double.tryParse(balanceController.text) ?? 0.0;

                if (name.isNotEmpty) {
                  _addAccount(Account(name: name, balance: balance));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAccountDetailsDialog(BuildContext context, Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${account.name}'),
              Text('Balance: \$${account.balance.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addAccount(Account account) {
    setState(() {
      accounts.add(account);
    });
  }

  void _deleteAccount(int index) {
    setState(() {
      accounts.removeAt(index);
    });
  }
}

class Students extends StatefulWidget {
  const Students({Key? key}) : super(key: key);

  @override
  StudentsState createState() =>
      StudentsState(); // Removed the underscore prefix
}

class StudentsState extends State<Students> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Student:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Student Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to save student information
                String studentName = nameController.text;
                int studentAge = int.tryParse(ageController.text) ?? 0;

                // You can use the student information as needed
                var logger = Logger();

                logger.d('Student Name: $studentName, Age: $studentAge');

                // Optionally, clear the text fields after submission
                nameController.clear();
                ageController.clear();
              },
              child: const Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});
}

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  TransactionsState createState() => TransactionsState();
}

class TransactionsState extends State<Transactions> {
  List<Transaction> transactions = _generateTransactions();

  // Function to generate a sample list of transactions
  static List<Transaction> _generateTransactions() {
    return [
      Transaction(title: 'Expense 1', amount: -50.0, date: DateTime.now()),
      Transaction(title: 'Income 1', amount: 100.0, date: DateTime.now()),
      // Add more transactions as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddTransactionDialog(context);
              },
              child: const Text('Add Transaction'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction.title),
                  subtitle: Text('Amount: \$${transaction.amount.toString()}'),
                  onTap: () {
                    _showTransactionDetailsDialog(context, transaction);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteTransaction(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Transaction'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration:
                    const InputDecoration(labelText: 'Transaction Title'),
              ),
              TextField(
                controller: amountController,
                decoration:
                    const InputDecoration(labelText: 'Transaction Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text;
                double amount = double.tryParse(amountController.text) ?? 0.0;

                if (title.isNotEmpty) {
                  _addTransaction(Transaction(
                      title: title, amount: amount, date: DateTime.now()));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showTransactionDetailsDialog(
      BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${transaction.title}'),
              Text('Amount: \$${transaction.amount.toString()}'),
              Text('Date: ${transaction.date.toLocal()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      transactions.add(transaction);
    });
  }

  void _deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime date;

  NotificationItem(
      {required this.title, required this.message, required this.date});
}

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  List<NotificationItem> notifications = _generateNotifications();

  // Function to generate a sample list of notifications
  static List<NotificationItem> _generateNotifications() {
    return [
      NotificationItem(
        title: 'Notification 1',
        message: 'This is a sample notification message.',
        date: DateTime.now(),
      ),
      // Add more notifications as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      drawer: const AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddNotificationDialog(context);
              },
              child: const Text('Add Notification'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  title: Text(notification.title),
                  subtitle: Text('Date: ${notification.date.toLocal()}'),
                  onTap: () {
                    _showNotificationDetailsDialog(context, notification);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteNotification(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNotificationDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Notification'),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration:
                    const InputDecoration(labelText: 'Notification Title'),
              ),
              TextField(
                controller: messageController,
                decoration:
                    const InputDecoration(labelText: 'Notification Message'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text;
                String message = messageController.text;

                if (title.isNotEmpty && message.isNotEmpty) {
                  _addNotification(NotificationItem(
                    title: title,
                    message: message,
                    date: DateTime.now(),
                  ));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showNotificationDetailsDialog(
      BuildContext context, NotificationItem notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notification Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${notification.title}'),
              Text('Message: ${notification.message}'),
              Text('Date: ${notification.date.toLocal()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _addNotification(NotificationItem notification) {
    setState(() {
      notifications.add(notification);
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Accounting App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _drawerItem(
            context,
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: const Dashboard(),
          ),
          _drawerItem(
            context,
            title: 'Accounts',
            icon: Icons.account_balance,
            route: const Accounts(),
          ),
          _drawerItem(
            context,
            title: 'Students',
            icon: Icons.school,
            route: const Students(),
          ),
          _drawerItem(
            context,
            title: 'Transactions',
            icon: Icons.swap_horiz,
            route: const Transactions(),
          ),
          _drawerItem(
            context,
            title: 'Notifications',
            icon: Icons.notifications,
            route: const Notifications(),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required String title, required IconData icon, required Widget route}) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
    );
  }
}
