import 'package:flutter/material.dart';
import 'package:widgets_layouts/widget_demos/dialog_box.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});
  @override
  _TextFieldScreenState createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  String password = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextField Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ensure the image is in the assets folder and declared in pubspec.yaml
            Center(
              child: Image.asset(
                'assets/images/ic_login.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: ((value) {
                setState(() {
                  phone = value;
                });
              }),
              decoration: const InputDecoration(
                labelText: 'Mobile number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: ((value) {
                setState(() {
                  password = value;
                });
              }),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 8),
            Text('Phone: $phone - Password: $password'),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  displayDialog(
                    context: context,
                    message: 'Phone: $phone - Password: $password',
                  );
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
