// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_cubit_cubit.dart';

abstract class InternetCubitState extends Equatable {
  const InternetCubitState();

  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetCubitState {}

class InternetCubitConnected extends InternetCubitState {
  late final ConnectionType connectionType;

  InternetCubitConnected({required this.connectionType});

  @override
  String toString() =>
      'InternetCubitConnected(connectionType: $connectionType)';
}

class InternetCubitDisconnected extends InternetCubitState {}
