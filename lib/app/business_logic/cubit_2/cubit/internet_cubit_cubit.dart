import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_advance/constant/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_cubit_state.dart';

class InternetCubit extends Cubit<InternetCubitState> {
  Connectivity connectivity;
  StreamSubscription? connectivityStreamSubcription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorConnection();
  }

  StreamSubscription<ConnectivityResult> monitorConnection() {
    return connectivityStreamSubcription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      // connectivityResult after listen is the value
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetCubitConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetCubitDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubcription!.cancel();
    return super.close();
  }
}
