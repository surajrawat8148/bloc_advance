import 'package:bloc_advance/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CounterCubit',
    () {
      CounterCubit? counterCubit;
      setUp(() {
        counterCubit = CounterCubit();
      });
      tearDown(() {
        counterCubit!.close();
      });

      test(
          'The initial state for the CounterCubit is CounterState(counterValue: 0)',
          () {
        expect(counterCubit!.state,
            CounterState(countervalue: 0, wasiIncremennted: false));
      });

      blocTest<CounterCubit, CounterState>(
        'emits [MyState] when MyEvent is added.',
        build: () => CounterCubit(),
        act: (cubit) => cubit.increment(),
        expect: () => [CounterState(countervalue: 1, wasiIncremennted: true)],
      );

      blocTest<CounterCubit, CounterState>(
        'the cubit should emit a CounterState(couterValue:-1, wasIncremented:false) when cubit.incremented() function is called',
        build: () => counterCubit!,
        act: (cubit) => cubit.decrement(),
        expect: () => [CounterState(countervalue: -1, wasiIncremennted: false)],
      );
    },
  );
}
