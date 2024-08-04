import 'package:flutter/material.dart';

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the Developer',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.black ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);}),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Card(
              elevation: 13,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('images/dev.jpg'), 
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rahma Taha',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color:const Color.fromARGB(255, 146, 18, 28),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Developer',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 179, 83, 91),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'This application was developed to make food delivery easier and more enjoyable. If you have any questions or feedback, feel free to reach out!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                      
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 146, 18, 28),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('Contact Me'),
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
