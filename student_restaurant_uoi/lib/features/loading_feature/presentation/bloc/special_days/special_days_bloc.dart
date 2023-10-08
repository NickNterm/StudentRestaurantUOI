import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/entities/special_day.dart';
import 'package:student_restaurant_uoi/features/loading_feature/domain/use_case/get_special_days_use_case.dart';
part 'special_days_event.dart';
part 'special_days_state.dart';

class SpecialDaysBloc extends Bloc<SpecialDaysEvent, SpecialDaysState> {
  final GetSpecialDayUseCase getSpecialDays;
  SpecialDaysBloc({
    required this.getSpecialDays,
  }) : super(SpecialDaysInitial()) {
    on<SpecialDaysEvent>((event, emit) async {
      if (event is GetSpecialDays) {
        emit(SpecialDaysLoading());
        final result = await getSpecialDays();
        result.fold(
          (failure) => emit(SpecialDaysError(message: failure.message)),
          (specialDays) => emit(SpecialDaysLoaded(specialDays: specialDays)),
        );
      }
    });
  }
}
