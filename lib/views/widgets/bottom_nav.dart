// import 'package:fast/home_pages/profile.dart';
// import 'package:fast/home_pages/target.dart';
// import 'package:fast/home_pages/wallet.dart';
// import 'package:fast/utlis/constant.dart';
// import 'package:fast/views/auth/home_screen.dart';
// import 'package:flutter/material.dart';
//
// class BottomNav extends StatefulWidget {
//   final int pageIndex;
//
//   const BottomNav({Key? key, required this.pageIndex}) : super(key: key);
//
//   @override
//   _BottomNavState createState() => _BottomNavState();
// }
//
// class _BottomNavState extends State<BottomNav> {
//   int _selectedPageIndex = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(15),
//           topLeft: Radius.circular(15),
//           bottomRight: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//
//         ),
//         boxShadow: [
//           BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
//         ],
//       ),
//
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           showUnselectedLabels: true,
//           onTap: (int index) {
//             setState(() => _selectedPageIndex = index);
//             switch (index) {
//               case 0:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Profile()),
//                 );
//                 break;
//               case 1:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Target()),
//                 );
//                 break;
//               case 2:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Wallet()),
//                 );
//                 break;
//               case 3:
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Home1()),
//                 );
//                 break;
//
//               default:
//             }
//           },
//           selectedIconTheme: IconThemeData(color: Color(0xFF4c4f7a)),
//
//
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
//             BottomNavigationBarItem(icon: Icon(Icons.star), label: "الهدف"),
//             BottomNavigationBarItem(icon: Icon(Icons.save), label: "محفظتي "),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
//           ],
//           currentIndex: _selectedPageIndex,
//           backgroundColor: DarkBlue,
//           selectedItemColor: Colors.grey,
//           unselectedItemColor: Colors.white,
//         ),
//       ),
//     );
//   }
// }
