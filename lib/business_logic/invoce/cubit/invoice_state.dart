part of 'invoice_cubit.dart';

@immutable
sealed class InVoiceState {}

final class InVoiceInitial extends InVoiceState {}

final class SelectBranch extends InVoiceState {}

final class InVoiceActionLoading extends InVoiceState {}

final class InVoiceActionSuccess extends InVoiceState {}

final class InVoiceActionError extends InVoiceState {}

final class InVoiceGetLoading extends InVoiceState {}

final class InVoiceGetSuccess extends InVoiceState {}

final class InVoiceGetError extends InVoiceState {}

final class InVoiceDeleteLoading extends InVoiceState {
  final int id;
  InVoiceDeleteLoading(this.id);
}

final class InVoiceDeleteSuccess extends InVoiceState {}

final class InVoiceDeleteError extends InVoiceState {}
