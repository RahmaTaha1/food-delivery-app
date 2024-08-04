import 'package:flutter/material.dart';
import 'package:project_1/Pages/developer.dart'; 
class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About the App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor:Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to our Food Delivery App!',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 146, 18, 28), 
                        fontFamily: "Poppins",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Order your favorite meals from a variety of restaurants and get them delivered to your doorstep. Enjoy your time with us!',
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeveloperPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black26,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('About the Developer'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
