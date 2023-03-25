import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/tabs/finances/domain/entity/finance_entity.dart';
import 'package:netigo_front/features/tabs/finances/presentation/bloc/finance_bloc.dart';
import 'package:netigo_front/features/tabs/finances/presentation/model/finance_view_model.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FinanceBloc>(context).add(GetFinanceHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finances"),
      ),
      body: BlocBuilder<FinanceBloc, FinanceState>(
        builder: (context, state) {
          if (state is FinanceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FinanceSuccess) {
            return _buildJobCard(state.financeEntity);
          } else if (state is FinanceFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("No Financial History!"),
            );
          }
        },
      ),
    );
  }

  Widget _buildJobCard(List<FinanceEntity> financeEntity) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: financeEntity.length,
        itemBuilder: (context, index) {
          return jobDetails(
            financeEntity[index].toViewModel(),
          );
        });
  }

  Widget jobDetails(FinanceViewModel financeViewModel) {
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
          Expanded(child: Text(financeViewModel.title)),
          const Spacer(),
          Expanded(child: Text(financeViewModel.status)),
          const Spacer(),
          Expanded(child: Text("\$${financeViewModel.totalRate.toString()}")),
        ],
      ),
    );
  }
}
