part of 'history_bloc.dart';

class HistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<HistoryEntity> historyEntity;

  HistorySuccess({required this.historyEntity});
}

class HistoryFailure extends HistoryState {
  final String errorMessage;

  HistoryFailure({required this.errorMessage});
}
