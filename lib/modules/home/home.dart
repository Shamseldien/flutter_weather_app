import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_weather_app/model.dart';
import 'package:new_weather_app/modules/home/bloc/cubit.dart';
import 'package:new_weather_app/modules/home/bloc/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context)..getCurrentLocation();
    HomeCubit.get(context)..getWeather(city: HomeCubit.get(context).currentLocation);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return state is! HomeStateLoading
        ?Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo.withOpacity(0.50),
                    child: IconButton(
                        icon: Icon(Icons.add_location,color: Colors.white,size: 20,),
                        onPressed: (){
                         cubit.getWeather(city: cubit.currentLocation);
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
                                Text('${DataModel.getTemp().round().toString()} °C',style: TextStyle(
                                    fontSize: 60.0
                                ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${DataModel.getCountry()}'
                                      ,style: TextStyle(
                                        color: Colors.indigo,
                                          fontSize: 30.0),),
                                    SizedBox(width: 10.0,),
                                    Text('${DataModel.getCity()}'
                                      ,style: TextStyle(
                                        fontSize: 20
                                      ),),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Image.network('${DataModel.weatherIcon()}'),
                                    Text('${DataModel.weatherDesc()}'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 130,
                              width: 110,
                              child: Column(
                                children: [
                                  Row(
                                    children: [

                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.green
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            TextFormField(
                              onFieldSubmitted: (value){
                                if(value.isNotEmpty)
                                  cubit.getWeather(city: value);
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Colors.indigo,
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color: Colors.indigo,
                                        width: 1.0
                                    )
                                ),
                                labelText: 'Search another location',

                              ),
                            )
                          ],
                        ),
                ),
              )
            ),
        )
        :Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
