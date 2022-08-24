import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';

class HomeError extends StatelessWidget {
  const HomeError({
    super.key,
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 64.sp,
        ),
        Text(
          message,
          style: TextStyle(
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }
}
