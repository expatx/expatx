import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/feed/history/domain/entities/history_entity.dart';
import 'package:netigo_front/features/feed/history/presentation/bloc/history_bloc.dart';
import 'package:netigo_front/features/feed/history/presentation/model/history_view_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(GetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job History"),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistorySuccess) {
            return _buildJobCard(state.historyEntity);
          } else if (state is HistoryFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("No Job History!"),
            );
          }
        },
      ),
    );
  }

  Widget _buildJobCard(List<HistoryEntity> historyEntity) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: historyEntity.length,
        itemBuilder: (context, index) {
          return jobDetails(
            historyEntity[index].toViewModel(),
          );
        });
  }

  Widget jobDetails(HistoryViewModel historyViewModel) {
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
          Expanded(child: Text(historyViewModel.title)),
          const Spacer(),
          Expanded(child: Text(historyViewModel.status)),
          const Spacer(),
          Expanded(child: Text(historyViewModel.expireDate)),
        ],
      ),
    );
  }
}
