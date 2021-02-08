
class DataModel {
 static var response = {};

  DataModel({data}){
  response = data;
  }

static String getCity()=> response['name'];
static String getCountry()=> response['sys']['country'];
static String weatherDesc()=> response['weather'][0]['main'].toLowerCase();
static dynamic getTemp()=>response['main']['temp'];
static String weatherIcon()=>'http://openweathermap.org/img/wn/'+response['weather'][0]['icon']+'.png';
}




