import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/app_colors.dart';

class FeedPostDetailScreen extends StatelessWidget {
  final FeedPostEntity feedPostEntity;
  const FeedPostDetailScreen({
    super.key,
    required this.feedPostEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: ClipOval(
                child: Image.asset("assets/images/user_profile.png"),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      feedPostEntity.userEntity.firstName,
                      style: const TextStyle(
                        color: AppColors.expatxBlack,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      feedPostEntity.userEntity.lastName,
                      style: const TextStyle(
                        color: AppColors.expatxBlack,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  timeago.format(DateTime.parse(feedPostEntity.createdAt)),
                  style: const TextStyle(
                    color: AppColors.expatxBlack,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(child: Text(feedPostEntity.content)),
    );
  }
}
