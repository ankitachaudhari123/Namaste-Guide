import 'package:flutter/material.dart';
import 'EditSingnUpInfo.dart';  // Ensure correct import

void showAlreadyHaveAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Account Exists"),
        content: const Text("You already have an account. Please log in."),
        actions: [
          // Edit Button: Navigate to Edit Profile page
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushNamed(context, 'editProfile');
            },
            child: const Text("Edit"),
          ),
          // OK Button: Navigate to Login page
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushNamed(context, 'HomePage'); // Navigate to Login Page
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
