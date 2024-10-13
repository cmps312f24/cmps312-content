import 'package:flutter/material.dart';
import 'package:navigation/widgets/alert_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Alert box'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialogBox();
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Bottom Sheet'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const SizedBox(
                      // Set the desired height
                      height: 200, 
                      child: Center(
                        child: Text('This is a Modal Bottom Sheet'),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Back to Home'),
              onPressed: () {
                // Return to the previous screen
                Navigator.of(context).pop();
                // Or
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
