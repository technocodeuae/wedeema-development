// import 'package:flutter/material.dart';
//
// import '../../ads/pages/select_city_page.dart';
// import '../../chat/pages/chats_page.dart';
// import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
// import '../../profile/pages/my_profile_page.dart';
// import 'home_page.dart';
// import 'my_favourite_page.dart';
// class MainPage extends StatefulWidget {
//   static const routeName = '/MainPage';
//
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin{
//
//   int _selectedIndex = 0;
//
//
//   @override
//   bool get wantKeepAlive => true;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//
//     // Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (context) => getScreen(index),
//     //     )
//     // );
//   }
//
//   // Return the correct screen
//   Widget getScreen(int index) {
//     switch (index) {
//       case 0:
//         return HomePage(
//
//         );
//       case 1:
//         return ChatsPage();
//       case 2:
//         return SelectCityPage();
//       case 3:
//         return MyFavouritePage();
//       default:
//         return MyProfilePage();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getScreen(_selectedIndex), // Show selected screen
//       bottomNavigationBar: bottomNavigationBarWidget(
//         onTap: _onItemTapped,
//         selectedIndex: _selectedIndex,
//       ),
//     );
//   }
// }
