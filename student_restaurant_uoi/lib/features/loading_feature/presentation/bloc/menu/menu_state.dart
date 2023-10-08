part of 'menu_bloc.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final Menu menu;

  MenuLoaded({
    required this.menu,
  });
}

class MenuError extends MenuState {
  final String message;

  MenuError({
    required this.message,
  });
}
