import 'package:flutter/material.dart';
import 'package:project/view/auth/login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => LogIn()));
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 65, 83, 182),
        body: Center(
          child: GestureDetector(
            // onTap: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (_) => LogIn()));
            // },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 102,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Color.fromARGB(255, 65, 83, 182),
                //backgroundImage: AssetImage('assets/images/mariamrady-white.png'),
                child: Image.asset(
                  'assets/images/mariamrady-white.png',
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
