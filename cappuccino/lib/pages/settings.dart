// import 'package:cappuccino/models/coffee_school.dart';
// import 'package:cappuccino/models/recepie.dart';
// import 'package:cappuccino/pages/browse.dart';
// import 'package:cappuccino/pages/home.dart';
// import 'package:cappuccino/pages/log_in.dart';
// import 'package:cappuccino/pages/profile_favorites.dart';
// import 'package:flutter/material.dart';
// // import 'home.dart';

// class Settings extends StatelessWidget {
//   const Settings(
//       {super.key, required this.recepies, required this.coffeeSchools});

//   final List<Recepie> recepies;
//   final List<CoffeeSchool> coffeeSchools;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 75,
//         backgroundColor: const Color.fromARGB(250, 168, 93, 48),
//         title: const Text(
//           'CAppuccino',
//           style: TextStyle(
//             color: Color.fromARGB(250, 66, 25, 8),
//             fontSize: 40,
//           ),
//         ),
//         actions: [
//           PopupMenuButton(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//             ),
//             color: const Color.fromARGB(250, 236, 204, 180),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(100),
//                 child: Image.asset('assets/images/Logo.png', width: 70),
//               ),
//             ),
//             onSelected: (value) => {
//               if (value == "settings")
//                 {
//                   Navigator.pop(context),
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Settings(
//                                 recepies: recepies,
//                                 coffeeSchools: coffeeSchools,
//                               )))
//                 }
//               else if (value == "log out")
//                 {
//                   Navigator.pop(context),
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const LogIn()))
//                 }
//             },
//             itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//               const PopupMenuItem(
//                 value: "settings",
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(right: 8.0),
//                       child: Icon(
//                         Icons.settings,
//                         color: Color.fromARGB(250, 66, 25, 8),
//                       ),
//                     ),
//                     Text(
//                       'Settings',
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: "log out",
//                 child: Row(
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(right: 8.0),
//                         child: Icon(
//                           Icons.logout,
//                           color: Color.fromARGB(250, 66, 25, 8),
//                         )),
//                     Text(
//                       'Log Out',
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Settings',
//               style: TextStyle(
//                   fontSize: 28, color: Color.fromARGB(250, 66, 25, 8)),
//             ),
//             SizedBox(
//               width: 325,
//               height: 200,
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   ),
//                   color: Color.fromARGB(255, 206, 140, 92),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'language',
//                             style: TextStyle(
//                               color: Color.fromARGB(250, 66, 25, 8),
//                               fontFamily: 'Sitka',
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           MaterialButton(
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(25),
//                                 bottomRight: Radius.circular(25),
//                               ),
//                             ),
//                             onPressed: () {},
//                             color: const Color.fromARGB(250, 168, 93, 48),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'English',
//                                   style: TextStyle(
//                                     color: Color.fromARGB(250, 236, 204, 180),
//                                   ),
//                                 ),
//                                 Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Color.fromARGB(250, 236, 204, 180),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'night mode',
//                             style: TextStyle(
//                               color: Color.fromARGB(250, 66, 25, 8),
//                               fontFamily: 'Sitka',
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Switch(
//                             value: false,
//                             onChanged: null,
//                             inactiveTrackColor: Color.fromARGB(250, 66, 25, 8),
//                             inactiveThumbColor:
//                                 Color.fromARGB(250, 236, 204, 180),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'notifications',
//                             style: TextStyle(
//                               color: Color.fromARGB(250, 66, 25, 8),
//                               fontFamily: 'Sitka',
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           Switch(
//                             value: true,
//                             onChanged: null,
//                             activeTrackColor:
//                                 Color.fromARGB(250, 236, 204, 180),
//                             thumbColor: WidgetStatePropertyAll(
//                                 Color.fromARGB(250, 66, 25, 8)),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       persistentFooterButtons: [
//         Container(
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(250, 168, 93, 48),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(25),
//               topRight: Radius.circular(25),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const Home()));
//                 },
//                 icon: const Icon(
//                   Icons.home_filled,
//                   color: Color.fromARGB(250, 66, 25, 8),
//                   size: 40,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Browse(
//                                 recepies: recepies,
//                                 coffeeSchools: coffeeSchools,
//                               )));
//                 },
//                 icon: Image.asset(
//                   'assets/images/Search.png',
//                   height: 35,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ProfileFavorites(
//                                 recepies: recepies,
//                                 coffeeSchools: coffeeSchools,
//                               )));
//                 },
//                 icon: const Icon(
//                   Icons.account_circle,
//                   color: Color.fromARGB(250, 66, 25, 8),
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
