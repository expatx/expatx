import 'package:expatx/core/app_colors.dart';
import 'package:expatx/features/tabs/feed/presentation/widgets/feed_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/tabs/feed/domain/entities/feed_post_entity.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FeedBloc>(context).add(GetFeedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Medellin, CO",
          style: TextStyle(
            color: AppColors.expatxBlack,
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          height: 40,
          width: 40,
          child: ClipOval(
            child: Image.asset("assets/images/user_profile.png"),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.filter_alt_outlined,
                color: AppColors.expatxDarkGrey, size: 35),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).goNamed("create_post");
        },
        backgroundColor: AppColors.expatxPurple,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeedSuccess) {
            if (state.feedEntity.isEmpty) {
              return const Center(
                child: Text("No Feed Info!"),
              );
            }
            return _buildFeedPost(state.feedEntity);
          } else if (state is FeedFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("No Feed Info!"),
            );
          }
        },
      ),
    );
  }

  Widget _buildFeedPost(List<FeedPostEntity> feedEntity) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: feedEntity.length,
      itemBuilder: (context, index) {
        return FeedPostWidget(feedPostEntity: feedEntity[index]);
      },
    );
  }
}
