import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  String _storedValue = '';

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
  }

  // 加载存储的值
  _loadStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('myValue') ?? '';
    });
  }

  // 保存值
  _saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('myValue', _controller.text);
    _loadStoredValue(); // 保存后重新加载以更新 UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter a value'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveValue,
              child: Text('Save Value'),
            ),
            SizedBox(height: 16),
            Text('Stored Value: $_storedValue'),
          ],
        ),
      ),
    );
  }
}
