import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingListScreen(),
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  // Xaridlar ro'yxatini saqlash uchun o'zgaruvchi
  List<Map<String, dynamic>> _shoppingList = [];

  // Foydalanuvchi yangi xarid qo'shishi uchun text controller
  final TextEditingController _controller = TextEditingController();

  // Yangi xarid qo'shish funksiyasi
  void _addItem(String item) {
    if (item.isNotEmpty) {
      setState(() {
        _shoppingList.add({
          'name': item,
          'isChecked': false, // Yangi qo'shilgan mahsulotni tekshirilmagan deb belgilaymiz
        });
      });
    }
  }

  // Xaridni ro'yxatdan o'chirish funksiyasi
  void _removeItem(int index) {
    setState(() {
      _shoppingList.removeAt(index);
    });
  }

  // Xaridni tekshirilgan deb belgilash (check/uncheck)
  void _toggleItemCheck(int index) {
    setState(() {
      _shoppingList[index]['isChecked'] = !_shoppingList[index]['isChecked'];
    });
  }

  // Yangi xarid kiritish uchun dialog oynasini ko'rsatish
  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Yangi xarid qo\'shish'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Xarid nomini kiriting'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _controller.clear();
                Navigator.of(context).pop();
              },
              child: Text('Bekor qilish'),
            ),
            TextButton(
              onPressed: () {
                _addItem(_controller.text);
                _controller.clear();
                Navigator.of(context).pop();
              },
              child: Text('Qo\'shish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xaridlar ro\'yxati'), // Bu yerda matnni "Xaridlar ro\'yxati" ga o'zgartirdik
      ),
      body: ListView.builder(
        itemCount: _shoppingList.length,
        itemBuilder: (context, index) {
          final item = _shoppingList[index];
          return ListTile(
            title: Text(
              item['name'],
              style: TextStyle(
                decoration: item['isChecked'] ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                item['isChecked'] ? Icons.check_circle : Icons.check_circle_outline,
                color: item['isChecked'] ? Colors.green : null,
              ),
              onPressed: () => _toggleItemCheck(index), // Check/uncheck tugmasi
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        tooltip: 'Yangi xarid qo\'shish',
        child: Icon(Icons.add),
      ),
    );
  }
}
