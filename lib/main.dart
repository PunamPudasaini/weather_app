import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int temperature;
  String location = "London";
  int woeid= 44418;
  String weather = "clear";
  String abbreviation = '';
  String errorMessage = '';

  String searchApiUrl = 'https://www.metaweather.com/api/location/search/?query=';
  String locationApiUrl = 'https://www.metaweather.com/api/location/';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchlocation();
  }

  void fetchSearch(String input) async {
    try {
      var SeachResults = await http.get(searchApiUrl + input);
      var result = json.decode(SeachResults.body)[0];

      setState(() {
        location = result["title"];
        woeid = result["woeid"];
        errorMessage= '';
      });
    }catch (error){
      setState(() {
        errorMessage = 'Sorry! we dont have data';
      });


    }
  }

  void fetchlocation() async{
    var locationResult = await http.get(locationApiUrl + woeid.toString());
    var result = json.decode(locationResult.body);
    var consolatedweather = result["consolidated_weather"];
    var data =consolatedweather[0];

    setState(() {
      temperature = data["the_temp"].round();
      weather = data["weather_state_name"].replaceAll(' ', ' ').toLowerCase();
      abbreviation = data["weather_state_abbr"];

    });

  }

  void onTextFieldSubmitted(String input) async{
   await fetchSearch(input);
   await fetchlocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$weather.png'),
              fit: BoxFit.cover
          ),
        ),

        child: temperature == null? Center(child: CircularProgressIndicator(),)
        :Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Image.network(
                      'https://www.metaweather.com/static/img/weather/png/'+abbreviation+'.png',
                      width: 100,
                    ),
                  ),

                  Center(
                    child: Text(
                      temperature.toString() + 'C',
                      style: TextStyle(color: Colors.white, fontSize: 60),
                    ),
                  ),
                  Center(
                    child: Text(
                      location,
                      style: TextStyle(color: Colors.white, fontSize: 60),
                    ),
                  ),
                ],
              ),

              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: TextField(
                      onSubmitted: (String input){
                        onTextFieldSubmitted(input);
                      },
                      style: TextStyle(color: Colors.white,fontSize: 25),
                      decoration: InputDecoration(
                        hintText: 'Search Location', hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        prefixIcon: Icon(Icons.search, color: Colors.white,)
                      ),
                    ),
                  ),

                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20
                    ),
                  ),
                ],
              )

            ],

          ),
        ),
      ),
    );
  }
}

