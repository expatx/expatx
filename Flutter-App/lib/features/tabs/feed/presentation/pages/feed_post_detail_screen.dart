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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(
                right: 10,
                left: 20,
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
                  timeago.format(
                    DateTime.parse(feedPostEntity.createdAt),
                  ),
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
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          children: [
            // Post Content
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                feedPostEntity.content,
                style: const TextStyle(
                  color: AppColors.expatxBlack,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),

            // Row with like and comment icons
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              padding: const EdgeInsets.only(
                top: 11,
                bottom: 11,
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: AppColors.expatxPurple,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Expanded(
                    child: Text(
                      "4",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Comment Count and Icon
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text(
                          "3",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Icon(
                          Icons.mode_comment_rounded,
                          color: AppColors.expatxPurple,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
