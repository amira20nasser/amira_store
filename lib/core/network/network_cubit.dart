import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import '../../features/cart/domain/repos/cart_repo.dart';
import '../di/di_imports.dart';
import '../utils/logging/logger_helper.dart';
part 'network_states.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  NetworkCubit(this._connectivity) : super(NetworkInitial()) {
    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      emit(NetworkDisconnected());
    } else {
      final cartRepo = ServiceLocator.get<CartRepo>();
      LoggerHelper.debug("Sync Cart.......");
      await cartRepo.syncLocalCartToFirebase();
      emit(NetworkConnected(result));
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } on PlatformException {
      return false;
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
