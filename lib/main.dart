import 'dart:convert';

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:http/http.dart" as http;

void main() => runApp(
  MaterialApp(
    title: "Weather App",
    home:  Home(),
    
  )
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather() async {
    http.Response response = await http.get(api.openweathermap.org/data/2.5/weather?id=2337639&appid=58b3948c38a3f48c823e03bdceb2a3e4);
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results["main"]["temp"];
      this.description = results["weather"][0]['description'];
      this.currently = results["weather"][0]['main'];
      this.humidity = results["main"]['humidity'];
      this.windspeed = results["wind"]["speed"];
    });
  }

  @override
  void initState(){
    super.initState();
    this.getWeather();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                   "Currently in Ilorin",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 14,
                     fontWeight: FontWeight.w400,
                   ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title: Text('Temperature'),
                      trailing: Text(
                          temp != null ? temp.toString() + "\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title: Text('Weather'),
                      trailing: Text(
                          description != null ? description.toString() : "Loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title: Text(
                          'Humidity'),
                      trailing: Text(
                          humidity != null ? humidity.toString() : "Loading"),
                    ),ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title: Text(
                          "Windspeed"),
                      trailing: Text(
                          windspeed != null ? windspeed.toString() : "Loading"),
                    ),

                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
