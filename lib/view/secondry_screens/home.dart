import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/start_api_cubit.dart';
import 'package:project/model/drawer_model.dart';
import 'package:project/view/main_screens/my_profile.dart';
import 'package:project/view/main_screens/main_screen.dart';
import 'package:project/view/main_screens/information_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  static List<String> listimage = [
    'assets/images/mariamm.jpg',
    'assets/images/welcome.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    {
      // Define list of drawer items
      List<DrawerModel> drawerList = [
        DrawerModel(
          title: 'My Profile',
          iconData: Icons.person, // Assign IconData directly
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MyProfile()));
          },
        ),
        DrawerModel(
          title: 'Information',
          iconData: Icons.info, // Assign IconData directly
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Information()));
          },
        ),
      ];

      GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Body Parts',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 65, 83, 182),
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: Drawer(
          width: 200,
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapShot.data == null) {
                    return const Center(
                      child: Text(
                        'No data found',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    Map<String, dynamic> data = snapShot.data!.data()!;
                    print(data['image_url']);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 20),
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            data['image_url'],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              ...drawerList.map((item) => ListTile(
                    leading: Icon(
                      item.iconData,
                      color: const Color.fromARGB(255, 65, 83, 182),
                      size: 26,
                    ),
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.title,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 65, 83, 182)),
                      ),
                    ),
                    onTap: item.onPressed,
                  )),
            ],
          ),
        ),
        body: Center(
            child: TextButton(
          child: Image.asset('assets/images/BodyParts.jpg'),
          onPressed: () async {
            for (int i = 0; i < listimage.length; i++) {
              sendMassage(listimage[i]);
              await Future.delayed(const Duration(milliseconds: 3500));
            }
            BlocProvider.of<StartApiCubit>(context).startApi();
            // sendMassage('assets/images/welcome.jpg');
            // Future.delayed(await Duration(seconds: 800))
            //     .then((value) => sendMassage('assets/images/mariamm.jpg'));
          },
        )),
      );
    }
  }
}

sendMassage(messege) async {
  var headersList = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAsgKSISU:APA91bEZgUc2yzjVO6nxKbvwGXprFxoQT14X0-3cs9i69A8ZI2tH2rJsOF05sYCCg0lVn1Yez749lMn7DEsejip4qLbPR8J-lDdl6kgvZoNV7mw9BlHt2N5XNmEKLXm1VpnRAFDd97Ol'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to":
        "fGr4JUDOR8OgdIShS0BFPr:APA91bGkn960Dfm2qAS2T_aUC_cjGfShnq9mmn2Mw6aoqe4pgK2_jeUT-orqQf6FVebYpuyjZ9DtN3mr_89o-NpSzuHcS4fpbofdxsGbvu-xByK5SWSh0iZrdyKi1J57G8SCIYNKiHqz",
    "notification": {"body": messege}
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}
