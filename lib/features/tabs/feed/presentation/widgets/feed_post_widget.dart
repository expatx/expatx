import 'package:expatx/core/app_colors.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPostWidget extends StatelessWidget {
  final FeedPostEntity feedPostEntity;
  const FeedPostWidget({
    super.key,
    required this.feedPostEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
              Expanded(
                child: Text(
                  feedPostEntity.userEntity.lastName,
                  style: const TextStyle(
                    color: AppColors.expatxBlack,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
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
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                feedPostEntity.content,
                style: const TextStyle(
                  color: AppColors.expatxBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
            ),
            padding: const EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.thumb_up,
                  color: AppColors.expatxPurple,
                  size: 22,
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Text(
                    "6",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
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
    );
  }
}
