import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:movies_client/movies_client.dart';

class Overview extends StatelessWidget {
  const Overview(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.sp,
        vertical: 10.sp,
      ),
      child: Text(
        movie.overview ?? '',
        textAlign: TextAlign.justify,
      ),
    );
  }
}
