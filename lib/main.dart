import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int temperature = 0;
  String location = "kathmandu";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/clear.png'),
              fit: BoxFit.cover
          ),
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
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
                      style: TextStyle(color: Colors.white,fontSize: 25),
                      decoration: InputDecoration(
                        hintText: 'Search Location', hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        prefixIcon: Icon(Icons.search, color: Colors.white,)
                      ),
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

