import 'package:appsize/appsize.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_client/movies_client.dart';
import 'package:very_good_movies/l10n/l10n.dart';

class CastingCards extends StatelessWidget {
  const CastingCards(this.credit, {super.key});

  final Credits credit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30.sp, top: 50.sp),
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cast,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.sp),
          SizedBox(
            width: 100.dw,
            height: 180.sp,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: credit.cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final castActor = credit.cast[index];
                return Container(
                  margin: EdgeInsets.only(right: 10.sp),
                  width: 110,
                  height: 100,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/no-image.jpg'),
                          image: NetworkImage(castActor.fullProfilePath),
                          height: 140,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 5.sp),
                      Text(
                        castActor.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
