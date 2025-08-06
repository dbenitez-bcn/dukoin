import 'package:flutter/material.dart';

class FormCardItem extends StatelessWidget {
  final String title;
  final Widget child;

  const FormCardItem({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
