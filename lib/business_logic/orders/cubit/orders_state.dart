part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class SelectBranch extends OrdersState {}

final class OrdersActionLoading extends OrdersState {}

final class OrdersActionSuccess extends OrdersState {}

final class OrdersActionError extends OrdersState {}

final class OrdersGetLoading extends OrdersState {}

final class OrdersGetSuccess extends OrdersState {}

final class OrdersGetError extends OrdersState {}

final class OrdersDeleteLoading extends OrdersState {
  final int id;
  OrdersDeleteLoading(this.id);
}

final class OrdersDeleteSuccess extends OrdersState {}

final class OrdersDeleteError extends OrdersState {}
