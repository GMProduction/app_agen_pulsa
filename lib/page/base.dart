import 'package:agen_pulsa/page/history.dart';
import 'package:agen_pulsa/page/penjualanPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../genosLib/component/page/genPage.dart';
import '../genosLib/genColor.dart';
import 'AkunSaya.dart';
import 'homePage.dart';
import 'menuNavbar.dart';

class Base extends StatefulWidget {
  const Base({Key? key}) : super(key: key);

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  int _currentIndex = 0;

  final _widgetOptions = [
    HomePage(),
    HistoryPage(),
    Penjualan(),
    AkunSaya()
  ];

  @override
  Widget build(BuildContext context) {
    return GenPage(
      body: _widgetOptions.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pushNamed(context, "keranjang");
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        selectedItemColor: GenColor.primaryColor,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((MenuNavbar menuNavbar) {
          return BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                  Center(child: Icon(menuNavbar.icon)),
                ],
              ),
              label: menuNavbar.title);
        }).toList(),
      ),
    );
  }
}
