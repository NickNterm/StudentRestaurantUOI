import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_restaurant_uoi/features/loading_feature/data/model/menu_model.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/menu.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_menu_use_case.dart';
part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetMenuUseCase getMenuUseCase;
  MenuBloc({
    required this.getMenuUseCase,
  }) : super(MenuInitial()) {
    on<MenuEvent>((event, emit) async {
      if (event is GetMenuEvent) {
        emit(MenuLoading());
        final result = await getMenuUseCase();
        result.fold(
          (failure) => emit(
            MenuError(message: failure.message),
          ),
          (menu) => emit(MenuLoaded(menu: menu)),
        );
      }
    });
  }
}
