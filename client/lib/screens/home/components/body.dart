import 'package:client/screens/login/login.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home_screen_splash.jpg'),
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              fit: BoxFit.cover
            )
          ),
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text('CHAD Clinic', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),),
              ),
              Container(
                child: Text('Amazing technology. Graceful care.', style: TextStyle(color: Colors.white),),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Let\'s get started!', style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      },
                    ),
                    height: 50,
                    width: double.infinity,
                  )
                ),
              )
            ],
          ),
          padding: EdgeInsets.only(top: 90, bottom: 60, left: 20, right: 20),
        )
      ],
    );
  }
}
