import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_1/service/auth.dart';
import 'package:project_1/service/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _getImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        await _uploadImage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking image: $e")),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null) {
      try {
        String imageId = randomAlphaNumeric(10);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child("profileImages").child(imageId);

        final UploadTask task = firebaseStorageRef.putFile(_selectedImage!);
        final TaskSnapshot snapshot = await task;

        final String downloadUrl = await snapshot.ref.getDownloadURL();
        await SharedPref().saveUserProfile(downloadUrl);
        setState(() {
          profile = downloadUrl;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading image: $e")),
        );
      }
    }
  }

  Future<void> _getUserInfo() async {
    try {
      profile = await SharedPref().getUserProfile();
      name = await SharedPref().getUserName();
      email = await SharedPref().getUserEmail();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error retrieving user info: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 150, 15, 44), Color.fromARGB(255, 172, 105, 122)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80),
            ),
          ),
        ),
        Positioned(
          top: 70,
          left: MediaQuery.of(context).size.width / 2 - 60,
          child: GestureDetector(
            onTap: _getImage,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                      )
                    : profile != null
                        ? Image.network(
                            profile!,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          )
                        : Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: MediaQuery.of(context).size.width / 2 -40,
          child: Text(
            name ?? 'Loading...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Column(
      children: [
        _buildInfoCard(Icons.person, 'Name', name ?? 'Loading...'),
        _buildInfoCard(Icons.email, 'Email', email ?? 'Loading...'),
        _buildTermCard(Icons.description, 'Terms and Conditions', 'Read and accept the terms.'),
        _buildActionButton(
          Icons.delete, 
          'Delete Account',
          _showDeleteConfirmation,
        ),
        _buildActionButton(
          Icons.logout,
          'Log Out',
          () async {
            await AuthMethods().SignOut();
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, color: Color.fromARGB(255, 119, 20, 33), size: 30),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 161, 80, 80),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color:Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermCard(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, color:  Color.fromARGB(255, 119, 20, 33), size: 30),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 161, 80, 80),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.all(
              20
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(icon, color: Color.fromARGB(255, 119, 20, 33), size: 30),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color:Color.fromARGB(255, 119, 20, 33),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        await AuthMethods().deleteUser();

        await AuthMethods().SignOut();

        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 20.0),
            _buildProfileInfo(),
          ],
        ),
      ),
    );
  }
}
