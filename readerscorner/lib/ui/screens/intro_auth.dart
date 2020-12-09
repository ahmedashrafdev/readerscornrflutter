import 'package:flutter/material.dart';

class IntroAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage('images/4.png'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 40.0,
                  left: 40.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('SIGN UP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        fontSize: 15.0)),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              OutlineButton(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  right: 47.0,
                  left: 47.0,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        fontSize: 15.0)),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
