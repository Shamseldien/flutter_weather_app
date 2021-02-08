import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_weather_app/models/model.dart';
import 'package:new_weather_app/modules/home/bloc/cubit.dart';
import 'package:new_weather_app/modules/home/bloc/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return  Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: state is HomeStateGetWeather
                      ? AssetImage('images/${DataModel.weatherDesc()}.png')
                      :AssetImage('images/clear.png'))),
          child: state is HomeStateGetWeather || state is HomeStateError
              ?Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo.withOpacity(0.50),
                    child: IconButton(
                        icon: Icon(
                          Icons.add_location,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          cubit.getWeather(
                              city: cubit.currentLocation);
                        }),
                  ),
                )
              ],
            ),
            body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${DataModel.getTemp().round().toString()} °C',
                              style: TextStyle(fontSize: 60.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${DataModel.getCountry()}',
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 30.0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  '${DataModel.getCity()}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    '${DataModel.weatherIcon()}'),
                                Text('${DataModel.weatherDesc()}'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          onFieldSubmitted: (value) {
                            cubit.getWeather(city: value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.indigo,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color: Colors.indigo, width: 1.0)),
                            labelText: 'Search another location',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        if(state is HomeStateError)
                          Text('No data for this city try another one .',style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                          ),
                            textAlign: TextAlign.center,
                          )
                      ],
                    ),
                  ),
                )),
          )
              :Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
