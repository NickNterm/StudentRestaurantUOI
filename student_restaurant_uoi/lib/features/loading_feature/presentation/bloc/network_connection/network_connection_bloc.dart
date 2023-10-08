import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_restaurant_uoi/core/network_info/network_info.dart';
part 'network_connection_event.dart';

class NetworkConnectionBloc extends Bloc<NetworkConnectionEvent, bool> {
  final NetworkInfo networkInfo;
  NetworkConnectionBloc({
    required this.networkInfo,
  }) : super(false) {
    on<NetworkConnectionEvent>((event, emit) async {
      if (event is CheckNetworkConnection) {
        final result = await networkInfo.isConnected;
        emit(result);
      }
    });
  }
}
