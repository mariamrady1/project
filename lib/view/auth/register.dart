import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/view/main_screens/my_profile.dart';
import 'package:project/view/secondry_screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();

  String _password = '';
  String _email = '';
  String _userName = '';
  String _status = '';
  XFile? _image;
  String? _imageUrl;
  final ImagePicker picker = ImagePicker();
  bool hidePassword = true;
  bool hideConfirmedPassword = true;
  bool isloading = false;

  _register(BuildContext context) async {
    setState(() {
      isloading = !isloading;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('please pick your personal image'),
          backgroundColor: Colors.red,
        ));
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        _uploadImage().then((value) {
          _uploadData();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const HomePage();
          }));
        });
        print('step 2');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        } else {
          _register(context);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _uploadImage() async {
    String key = UniqueKey().toString();
    await FirebaseStorage.instance
        .ref()
        .child('users_image/$key')
        .putFile(File(_image!.path));
    _imageUrl = await FirebaseStorage.instance
        .ref()
        .child('users_image/$key')
        .getDownloadURL();
  }

  _uploadData() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(id).set({
      "id": id,
      "email": _email,
      "name": _userName,
      "status": _status,
      "image_url": _imageUrl,
    });
  }

  pickImage(bool isCamera) async {
    _image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Image picked successfully'),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 102,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    //backgroundImage: AssetImage('assets/images/mariamrady-white.png'),
                    child: Image.asset(
                      'assets/images/mariamrady-blue.png',
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  'Welcome !',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'Create your account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must enter your name";
                    } else if (value.length <= 3) {
                      return "You should enter a valid name";
                    }
                  },
                  onSaved: (value) {
                    _userName = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(),
                    // label: Text('Email'),
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "You must enter an email";
                    } else if (!value.contains('@gmail.com')) {
                      return "Email must contain @gmail.com";
                    } else if (value.length <= "@gmail.com".length) {
                      return "You should enter a valid email";
                    }
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      // label: Text('Password'),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Colors.black,
                        icon: hidePassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      hintText: 'Enter your password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    } else if (value.length < 8) {
                      return "Password should be more than 8 character";
                    }
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: hideConfirmedPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hideConfirmedPassword = !hideConfirmedPassword;
                          });
                        },
                        icon: hideConfirmedPassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      // border: OutlineInputBorder(),
                      // label: Text('Password'),
                      hintText: 'Confirm password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can not be empty';
                    } else if (value != _passwordController.text) {
                      return "Password doesn't match";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Status'),
                  maxLines: 2,
                  onSaved: (value) {
                    _status = value ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text(
                          'Pick Image',
                          textAlign: TextAlign.center,
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                pickImage(true);
                              },
                              child: const Text('Camera'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                pickImage(false);
                              },
                              child: const Text('Gallary'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text(
                    'Pick Image',
                  ),
                ),
                !isloading
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: 300,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: GestureDetector(
                                onTap: () {
                                  _register(context);
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
