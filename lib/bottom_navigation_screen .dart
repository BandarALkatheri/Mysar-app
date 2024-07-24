import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskyfinaly/ContactPage.dart';
import 'package:taskyfinaly/catogry_screen.dart';
import 'package:taskyfinaly/home.dart';
import 'package:taskyfinaly/LoginScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class bottomNavigationScreen extends StatefulWidget {
  const bottomNavigationScreen({super.key});

  @override
  bottomNavigationScreenState createState() => bottomNavigationScreenState();
}

class bottomNavigationScreenState extends State<bottomNavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    home_screen(),
    CatogryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'home':
        setState(() {
          _selectedIndex = 0;
        });
        Navigator.of(context).pop(); // Close the drawer
        break;
      case 'all_services':
        setState(() {
          _selectedIndex = 1;
        });

        Navigator.of(context).pop(); // Close the drawer
        break;
      case 'logout':
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        break;
      case 'ContactPage':
        setState(() {
          _selectedIndex = 3;
        });
        Navigator.of(context).pop(); // Close the drawer
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 80,
              child: Image.asset('assets/logo/logoapp.png'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Custom DrawerHeader with image background
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'الرئيسية',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onTap: () => _onMenuItemSelected('home'),
            ),
            ListTile(
              leading: const Icon(Icons.grid_view),
              title: const Text(
                'الخدمات',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onTap: () => _onMenuItemSelected('all_services'),
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text(
                'اتصل بناء',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContactPage()), // تأكد من أن HomeScreen صحيح
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.email),
              title: const Text(
                'للشكاوى والإقتراحات',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                _launchURL('https://wa.me/734939353');
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'تسجيل الخروج',
                style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              onTap: () => _onMenuItemSelected('logout'),
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'الخدمات',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
