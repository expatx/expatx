import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:flutter/material.dart';

class FeedPostWidget extends StatelessWidget {
  FeedPostEntity feedPostEntity;
  FeedPostWidget({super.key, required this.feedPostEntity});

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
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(feedPostEntity.content)),
          const Spacer(),
          Expanded(child: Text(feedPostEntity.language)),
          const Spacer(),
          Expanded(child: Text(feedPostEntity.userEntity.firstName)),
        ],
      ),
    );
  }
}
