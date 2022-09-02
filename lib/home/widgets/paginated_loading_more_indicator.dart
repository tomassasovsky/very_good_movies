import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';

class PaginateLoadingMoreIndicator extends StatelessWidget {
  const PaginateLoadingMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.sp, bottom: 30.sp),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
