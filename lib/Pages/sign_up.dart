import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Pages/bottom_nav.dart';
import 'package:project_1/Pages/login.dart';
import 'package:project_1/Widget/widget_support.dart';
import 'package:project_1/service/database.dart';
import 'package:project_1/service/shared_pref.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String get email => _mailController.text.trim();
  String get password => _passwordController.text.trim();
  String get name => _nameController.text.trim();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 207, 138, 138),
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
      String Id = randomAlphaNumeric(10);
      Map<String, dynamic> addUserInfo = {
        "Name": _nameController.text,
        "Email": _mailController.text,
        "Id": Id,
      };
      await DatabaseMethods().addUserDetail(addUserInfo, Id);
      await SharedPref().saveUserName(_nameController.text);
      await SharedPref().saveUserEmail(_mailController.text);
      await SharedPref().saveUserId(Id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    String message;
    if (e.code == 'weak-password') {
      message = "Password Provided is too Weak";
    } else if (e.code == "email-already-in-use") {
      message = "Account Already exists";
    } else {
      message = "An error occurred. Please try again.";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          message,
          style: TextStyle(fontSize: 18.0),
        ),
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
          return 'Please Enter $hintText';
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

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        "images/logo.png",
        width: MediaQuery.of(context).size.width / 1.5,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSignUpForm() {
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
              Text("Sign up", style: AppWidget.headTextFeildStyle()),
              SizedBox(height: 30.0),
              _buildTextField(
                controller: _nameController,
                hintText: 'Name',
                icon: Icons.person_outlined,
              ),
              SizedBox(height: 30.0),
              _buildTextField(
                controller: _mailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 30.0),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.password_outlined,
                isPassword: true,
              ),
              SizedBox(height: 80.0),
              _buildSignUpButton(),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: _register,
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
              "SIGN UP",
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

  Widget _buildLoginPrompt() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      ),
      child: Text(
        "Already have an account? Login",
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
                    _buildSignUpForm(),
                    SizedBox(height: 70.0),
                    _buildLoginPrompt(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
