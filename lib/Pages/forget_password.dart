import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Pages/sign_up.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _mailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Password Reset Email has been sent!",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  Widget _buildTextField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 2.0),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _mailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter Email';
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.white70,
            size: 30.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSendEmailButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          _resetPassword();
        }
      },
      child: Container(
        width: 140,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Send Email",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        SizedBox(width: 5.0),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
          child: Text(
            "Create",
            style: TextStyle(
              color: Color.fromARGB(255, 122, 3, 19),
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 114, 128),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 70.0),
            Center(
              child: Text(
                "Password Recovery",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                "Enter your email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 30.0),
                    _buildTextField(),
                    SizedBox(height: 40.0),
                    _buildSendEmailButton(),
                    SizedBox(height: 50.0),
                    _buildCreateAccountPrompt(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
