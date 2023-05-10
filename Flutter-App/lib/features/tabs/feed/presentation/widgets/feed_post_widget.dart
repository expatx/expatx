import 'package:expatx/core/app_colors.dart';
import 'package:expatx/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_bloc.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_state.dart';
import 'package:expatx/features/tabs/feed/presentation/pages/feed_post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../bloc/feed_post/feed_post_event.dart';

class FeedPostWidget extends StatelessWidget {
  final FeedPostEntity feedPostEntity;
  const FeedPostWidget({
    super.key,
    required this.feedPostEntity,
  });

  @override
  Widget build(BuildContext context) {
    int numberOfLikes = feedPostEntity.likes!.length;
    bool likedByCurrentUser = false;

    for (var like in feedPostEntity.likes!) {
      if (like.user.id == context.read<AuthBloc>().state.user.id) {
        likedByCurrentUser = true;
        break;
      }
    }
    return BlocBuilder<FeedPostBloc, FeedPostState>(
      builder: (context, state) {
        if (state is LikeFeedPostLoading) {
          if (state.feedPostId == feedPostEntity.id) {
            numberOfLikes = numberOfLikes + 1;
          }
        } else if (state is LikeFeedPostFailure) {
          if (state.feedPostId == feedPostEntity.id) {
            numberOfLikes = numberOfLikes - 1;
          }
        } else if (state is UnlikeFeedPostLoading) {
          if (state.feedPostId == feedPostEntity.id) {
            numberOfLikes = numberOfLikes - 1;
          }
        } else if (state is UnlikeFeedPostFailure) {
          if (state.feedPostId == feedPostEntity.id) {
            numberOfLikes = numberOfLikes + 1;
          }
        }
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
            borderRadius: BorderRadius.all(
              Radius.circular(
                5,
              ),
            ),
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
                  children: [
                    InkWell(
                      onTap: () {
                        if (likedByCurrentUser) {
                          context.read<FeedPostBloc>().add(
                                UnlikeFeedPostEvent(
                                  feedPostId: feedPostEntity.id,
                                  userId:
                                      context.read<AuthBloc>().state.user.id,
                                ),
                              );
                        } else {
                          context.read<FeedPostBloc>().add(
                                LikeFeedPostEvent(
                                  feedPostId: feedPostEntity.id,
                                  userId:
                                      context.read<AuthBloc>().state.user.id,
                                ),
                              );
                        }
                        likedByCurrentUser = !likedByCurrentUser;
                      },
                      child: Icon(
                        likedByCurrentUser
                            ? Icons.thumb_up_alt_rounded
                            : Icons.thumb_up_alt_outlined,
                        color: AppColors.expatxPurple,
                        size: 22,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    BlocBuilder<FeedPostBloc, FeedPostState>(
                      builder: (context, state) {
                        if (state is LikeFeedPostSuccess) {
                          if (state.feedEntity.id == feedPostEntity.id) {
                            var newLikesCount = state.feedEntity.likes!.length;
                            numberOfLikes = newLikesCount;
                          }
                        }
                        if (state is UnlikeFeedPostSuccess) {
                          if (state.feedEntity.id == feedPostEntity.id) {
                            var newLikesCount = state.feedEntity.likes!.length;
                            numberOfLikes = newLikesCount;
                          }
                        }
                        return Expanded(
                          child: Text(
                            numberOfLikes.toString() == "0"
                                ? ""
                                : numberOfLikes.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                    // Comment Count and Icon
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: FeedPostDetailScreen(
                              feedPostEntity: feedPostEntity),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
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
        );
      },
    );
  }
}
