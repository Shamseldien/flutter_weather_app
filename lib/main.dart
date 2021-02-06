import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_weather_app/modules/home/bloc/cubit.dart';
import 'package:new_weather_app/modules/home/home.dart';
import 'package:new_weather_app/shared/network/remote/helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>HomeCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        //theme: ThemeData.dark(),
        home: HomeScreen()
    ));
  }
}
