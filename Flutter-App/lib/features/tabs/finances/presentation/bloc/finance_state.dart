part of 'finance_bloc.dart';

class FinanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FinanceInitial extends FinanceState {}

class FinanceLoading extends FinanceState {}

class FinanceSuccess extends FinanceState {
  final List<FinanceEntity> financeEntity;

  FinanceSuccess({required this.financeEntity});
}

class FinanceFailure extends FinanceState {
  final String errorMessage;

  FinanceFailure({required this.errorMessage});
}
