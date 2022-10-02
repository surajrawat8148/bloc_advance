import 'package:bloc_advance/app/presentation/screens/home.dart';
import 'package:bloc_advance/app/presentation/screens/second_screen.dart';
import 'package:bloc_advance/app/presentation/screens/settings_screen.dart';
import 'package:bloc_advance/app/presentation/screens/third_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/counter_cubit.dart';

class AppRoute {
  CounterCubit _counterCubit = CounterCubit();

  MaterialPageRoute? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'Home Page',
                  color: Colors.amber,
                ));
      case '/second':
        return MaterialPageRoute(
            builder: (_) => SecondScreen(
                  title: 'Second Page',
                  color: Colors.amber,
                ));
      case '/third':
        return MaterialPageRoute(
            builder: (_) => ThirdScreen(
                  title: 'Third Page',
                  color: Colors.amber,
                ));
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
