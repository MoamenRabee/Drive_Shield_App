part of 'receipt_cubit.dart';

@immutable
sealed class ReceiptState {}

final class ReceiptInitial extends ReceiptState {}

final class SelectBranch extends ReceiptState {}

final class ReceiptActionLoading extends ReceiptState {}

final class ReceiptActionSuccess extends ReceiptState {}

final class ReceiptActionError extends ReceiptState {}

final class ReceiptGetLoading extends ReceiptState {}

final class ReceiptGetSuccess extends ReceiptState {}

final class ReceiptGetError extends ReceiptState {}

final class ReceiptDeleteLoading extends ReceiptState {
  final int id;
  ReceiptDeleteLoading(this.id);
}

final class ReceiptDeleteSuccess extends ReceiptState {}

final class ReceiptDeleteError extends ReceiptState {}
