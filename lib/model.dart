import 'dart:ffi';

class DataModel {
 static var response = {};

  DataModel({data}){
  response = data;
  }

static String getCity()=> response['name'];
static String getCountry()=> response['sys']['country'];
static String weatherDesc()=> response['weather'][0]['description'];
static double getTemp(){
 return kelvinToCelsius(k: response['main']['temp']);
}
static String weatherIcon()=>'http://openweathermap.org/img/wn/'+response['weather'][0]['icon']+'.png';

}
kelvinToCelsius({k}){
 const unit = 273.15;
 var temp = k-unit;
 return temp;
}



