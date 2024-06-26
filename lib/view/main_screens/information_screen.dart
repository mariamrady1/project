import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Information',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.asset('assets/images/mariam.jpg'),
              const SizedBox(height: 10),
              const Text(
                "The project involves the development of a robot designed to assist in the treatment of speech disorders in children. The robot will be controlled through a mobile application , providing a user-friendly and interactive experience for both the child and the speech therapist.",
                style: TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Features and Functionality :",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Speech Assessment-Personalized Treatment Plans-Robot Interaction-Real_time Monitoring",
                style: TextStyle(color: Colors.blueGrey, fontSize: 18),
              ),
            ],
          ),
        ));
    ;
  }
}


// import 'package:flutter/material.dart';

// class Setting extends StatelessWidget {
//   const Setting({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Setting'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => DevAndUs(isDeveloper: false)));
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: Container(
//                 width: 200,
//                 alignment: Alignment.center,
//                 height: 50,
//                 child: const Text(
//                   'About Us',
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => DevAndUs(isDeveloper: true)));
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orange),
//               ),
//               child: Container(
//                 width: 200,
//                 alignment: Alignment.center,
//                 height: 50,
//                 child: const Text(
//                   'Developers',
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DevAndUs {
// }
