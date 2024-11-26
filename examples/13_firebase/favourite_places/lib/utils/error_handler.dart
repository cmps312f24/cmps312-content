import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static String getErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';

      case 'not-found':
        return 'The requested resource could not be found.';

        

      case 'deadline-exceeded':
        return 'The request timed out. Please try again later.';

      case 'unavailable':
        return 'The service is temporarily unavailable. Please try again later.';

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primaryContainer),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.endToStart,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
