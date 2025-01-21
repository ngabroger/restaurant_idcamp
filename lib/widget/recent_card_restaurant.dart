import 'package:find_restaurant/data/api/api_service.dart';
import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class RecentCard extends StatelessWidget {
  final Restaurant recents;
  final Function() onTap;

  const RecentCard({
    super.key,
    required this.onTap,
    required this.recents,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 120,
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              softWrap: true,
                              recents.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "1 day Left",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(),
                        Row(
                          children: List.generate(
                            4,
                            (index) => Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 4.0),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picsum.photos/200?random=$index"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 25,
            right: -30,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  ApiService.images + recents.pictureId,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    );
  }
}
