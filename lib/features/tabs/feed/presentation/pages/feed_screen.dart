import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/tabs/feed/domain/entities/feed_entity.dart';
import 'package:netigo_front/features/tabs/feed/presentation/bloc/feed_bloc.dart';
import 'package:netigo_front/features/tabs/feed/presentation/model/feed_view_model.dart';

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
        title: const Text("Feed"),
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FeedSuccess) {
            return _buildJobCard(state.feedEntity);
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

  Widget _buildJobCard(List<FeedEntity> feedEntity) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: feedEntity.length,
        itemBuilder: (context, index) {
          return jobDetails(
            feedEntity[index].toViewModel(),
          );
        });
  }

  Widget jobDetails(FeedViewModel feedViewModel) {
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
          Expanded(child: Text(feedViewModel.title)),
          const Spacer(),
          Expanded(child: Text(feedViewModel.status)),
          const Spacer(),
          Expanded(child: Text(feedViewModel.expireDate)),
        ],
      ),
    );
  }
}
