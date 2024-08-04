import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Pages/bottom_nav.dart';
import 'package:project_1/Pages/forget_password.dart';
import 'package:project_1/Pages/sign_up.dart';
import 'package:project_1/Widget/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _userLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } on FirebaseAuthException catch (e) {
        _handleAuthException(e);
      }
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    String message;
    if (e.code == 'user-not-found') {
      message = "No User Found for that Email";
    } else if (e.code == 'wrong-password') {
      message = "Wrong Password Provided by User";
    } else {
      message = "An error occurred. Please try again.";
    }
    _showSnackBar(message);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      ),
    ));
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        "images/logo.png",
        width: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required IconData icon,
      bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppWidget.semiBoldTextFeildStyle(),
        prefixIcon: Icon(icon),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text("Login", style: AppWidget.headTextFeildStyle()),
              SizedBox(height: 30.0),
              _buildTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email_outlined),
              SizedBox(height: 30.0),
              _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Icons.password_outlined,
                  isPassword: true),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword())),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Forgot Password?",
                    style: AppWidget.lightgreyTextFeildStyle(),
                  ),
                ),
              ),
              SizedBox(height: 80.0),
              _buildLoginButton(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _userLogin,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          width: 200,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 146, 18, 28),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Poppins1',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp())),
      child: Text(
        "Don't have an account? Sign up",
        style: AppWidget.semiBoldTextFeildStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 58, 6, 13),
                  Color.fromARGB(255, 31, 4, 6),
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Column(
                children: [
                  _buildLogo(),
                  SizedBox(height: 50.0),
                  _buildLoginForm(),
                  SizedBox(height: 70.0),
                  _buildSignUpPrompt(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
