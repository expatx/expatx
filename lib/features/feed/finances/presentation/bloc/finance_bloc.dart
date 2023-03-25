import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/feed/finances/domain/entity/finance_entity.dart';
import 'package:netigo_front/features/feed/finances/domain/usecase/get_finance_history.dart';

import '../../../../shared/domain/usecases/usecases.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc({required this.getFinanceHistory}) : super(FinanceInitial()) {
    on<GetFinanceHistoryEvent>(_onGetFinanceHistoryEvent);
  }

  late GetFinanceHistory getFinanceHistory;

  Future<void> _onGetFinanceHistoryEvent(
    GetFinanceHistoryEvent event,
    Emitter<FinanceState> emit,
  ) async {
    emit(FinanceLoading());

    // Mock await
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await getFinanceHistory.call(NoParams());

      response.fold(
        (l) => emit(
          FinanceFailure(
            errorMessage: l.toString(),
          ),
        ),
        (r) => emit(FinanceSuccess(financeEntity: r)),
      );
    } catch (_) {
      emit(
        FinanceFailure(
          errorMessage: "Failed to load finance history!",
        ),
      );
    }
  }
}
