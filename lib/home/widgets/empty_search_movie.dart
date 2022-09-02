import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';

class EmptySearchMovie extends StatelessWidget {
  const EmptySearchMovie({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 130.sp,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.black38,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
