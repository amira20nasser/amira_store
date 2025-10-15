part of 'network_cubit.dart';

abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {
  final List<ConnectivityResult> connectionStatus;
  NetworkConnected(this.connectionStatus);
}

class NetworkDisconnected extends NetworkState {}
