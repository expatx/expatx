import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/tabs/history/domain/entities/history_entity.dart';
import 'package:expatx/features/tabs/history/domain/usecases/get_job_history.dart';

import '../../../../shared/domain/usecases/usecases.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required this.getJobHistory}) : super(HistoryInitial()) {
    on<GetHistoryEvent>(_onGetHistoryEvent);
  }

  late GetJobHistory getJobHistory;

  Future<void> _onGetHistoryEvent(
    GetHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());

    // Mock await
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await getJobHistory.call(NoParams());

      response.fold(
        (l) => emit(
          HistoryFailure(
            errorMessage: l.toString(),
          ),
        ),
        (r) => emit(HistorySuccess(historyEntity: r)),
      );
    } catch (_) {
      emit(
        HistoryFailure(
          errorMessage: "Failed to load history",
        ),
      );
    }
  }
}
