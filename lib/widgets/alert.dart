import 'package:flutter/material.dart';

void displayError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                message,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

void displayMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                message,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green,
    ),
  );
}
