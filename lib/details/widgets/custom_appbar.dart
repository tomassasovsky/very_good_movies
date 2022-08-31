import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';
import 'package:movies_client/movies_client.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
    this.movie, {
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300.sp,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(
            bottom: 10.sp,
            left: 10.sp,
            right: 10.sp,
          ),
          color: Colors.black12,
          child: Text(
            movie.title ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.posterFullPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
