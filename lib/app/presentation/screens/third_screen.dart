import 'package:bloc_advance/app/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/counter_cubit.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
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
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.countervalue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((_) => BlocProvider.value(
                            value: BlocProvider.of<CounterCubit>(context),
                            child: SecondScreen(
                                title: 'SeconScreen', color: Colors.red),
                          )),
                    ),
                  );
                },
                child: Text('Go to Second Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
