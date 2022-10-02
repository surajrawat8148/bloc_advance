import 'package:bloc_advance/app/business_logic/cubit_2/cubit/internet_cubit_cubit.dart';
import 'package:bloc_advance/app/presentation/screens/second_screen.dart';
import 'package:bloc_advance/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/counter_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetCubitState>(
      listener: (context, state) {
        if (state is InternetCubitConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetCubitConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Navigator.pushNamed(context, '/settings')),
          ],
        ),
        body: BlocListener<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.wasiIncremennted) {
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text('Incremented!'),
                duration: Duration(milliseconds: 300),
              ));
            } else {
              Scaffold.of(context).showSnackBar(const SnackBar(
                content: Text('Decremented!'),
                duration: Duration(milliseconds: 300),
              ));
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<InternetCubit, InternetCubitState>(
                  builder: (context, state) {
                    if (state is InternetCubitConnected &&
                        state.connectionType == ConnectionType.Wifi) {
                      return Text(
                        'Wifi',
                        style: TextStyle(fontSize: 24),
                      );
                    } else if (state is InternetCubitConnected &&
                        state.connectionType == ConnectionType.Mobile) {
                      return Text(
                        'Mobile',
                        style: TextStyle(fontSize: 24),
                      );
                    } else if (state is InternetCubitDisconnected) {
                      return Text(
                        'Disconnectd',
                        style: TextStyle(fontSize: 24),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                const Text(
                  'You have pushed the button this many times:',
                ),
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    if (state is IncrementedCounter) {
                      return Text(
                        state.countervalue.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      );
                    } else if (state is DecrementedCounter)
                      return Text(
                        state.countervalue.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      );
                    else {
                      return Text(
                        '',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }
                  },
                ),
                SizedBox(height: 24),
                Builder(
                  builder: (BuildContext context) {
                    final counterstate = context.watch<CounterCubit>().state;
                    final internetstate = context.watch<InternetCubit>().state;

                    if (internetstate is InternetCubitConnected &&
                        internetstate.connectionType == ConnectionType.Mobile) {
                      return Text('Counter.when : ' +
                          counterstate.countervalue.toString() +
                          'Internet: Mobile');
                    } else if (internetstate is InternetCubitConnected &&
                        internetstate.connectionType == ConnectionType.Wifi) {
                      return Text('Counter.when: ' +
                          counterstate.countervalue.toString() +
                          ' Internet: Wifi');
                    } else {
                      return Text('Counter.when : ' +
                          counterstate.countervalue.toString() +
                          'Internet: Disconnected ');
                    }
                  },
                ),
                SizedBox(height: 24),
                Builder(builder: (context) {
                  final countervalue = context
                      .select((CounterCubit cubit) => cubit.state.countervalue);
                  return Text('Counter.select: ' + countervalue.toString());
                }),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () =>
                          BlocProvider.of<CounterCubit>(context).decrement(),
                      tooltip: 'Decrement',
                      child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      onPressed: () =>
                          BlocProvider.of<CounterCubit>(context).increment(),
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: Text('Go to Second Screen'),
                ),
                SizedBox(height: 24),
                MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((_) => BlocProvider.value(
                              value: BlocProvider.of<CounterCubit>(context),
                              child: SecondScreen(
                                  title: 'Third Screen', color: Colors.red),
                            )),
                      ),
                    );
                  },
                  child: Text('Go to Third Screen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
