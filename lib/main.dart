import 'package:bloc_advance/app/business_logic/cubit_2/cubit/internet_cubit_cubit.dart';
import 'package:bloc_advance/app/presentation/screens/second_screen.dart';
import 'package:bloc_advance/app/presentation/screens/settings_screen.dart';
import 'package:bloc_advance/app/presentation/screens/third_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/presentation/pages/app_router.dart';
import 'app/presentation/screens/home.dart';

import 'cubit/counter_cubit.dart';
import 'cubit/settings_cubit.dart';

// class MyClass extends Equatable {
//   final int value;
//   MyClass({required this.value});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [value];
// }

void main() async {
  // final a = MyClass(value: 1);
  // final b = MyClass(value: 2);
  // print(a == b);

  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(
        appRoute: AppRoute(),
        connectivity: Connectivity(),
      ),
    ),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRoute appRoute;
  final Connectivity connectivity;

  MyApp({
    Key? key,
    required this.appRoute,
    required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRoute.onGenerateRoute,
      ),
    );
  }
}
