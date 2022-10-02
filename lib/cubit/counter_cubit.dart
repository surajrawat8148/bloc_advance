import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_cubit_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(DecrementedCounter(countervalue: 0));

  void increment() => emit(IncrementedCounter(
      countervalue: (state as IncrementedCounter).countervalue + 1));

  void decrement() => emit(DecrementedCounter(
      countervalue: (state as DecrementedCounter).countervalue));

  // @override
  // CounterState? fromJson(Map<String, dynamic> json) {
  //   return CounterState.fromMap(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(CounterState state) {
  //   // addError(Exception("Couldn't write to storage!"), StackTrace.current);
  //   return state.toMap();
  // }
}
