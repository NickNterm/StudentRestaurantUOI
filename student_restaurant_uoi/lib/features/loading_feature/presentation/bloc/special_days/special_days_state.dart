part of 'special_days_bloc.dart';

abstract class SpecialDaysState {}

class SpecialDaysInitial extends SpecialDaysState {}

class SpecialDaysLoading extends SpecialDaysState {}

class SpecialDaysLoaded extends SpecialDaysState {
  final List<SpecialDay> specialDays;

  SpecialDaysLoaded({required this.specialDays});
}

class SpecialDaysError extends SpecialDaysState {
  final String message;

  SpecialDaysError({required this.message});
}
