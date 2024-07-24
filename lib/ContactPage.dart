import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'صفحة الاتصال',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 20,
            color: Colors.orange,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/logo/tcnaical.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'يسعدنا تواصلكم معنا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Helvetica',
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _launchURL('tel:734939353'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.orange, size: 24),
                      SizedBox(width: 10),
                      Text(
                        '734939353',
                        style: TextStyle(fontSize: 24, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.orange,
                ),
                title: Text(
                  'www.Mysar.com',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.orange,
                ),
                title: Text(
                  'Mysar6856@gmail.com',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                onTap: () => _launchURL('mailto:Mysar6856@gmail.com'),
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Colors.orange,
                ),
                title: Text(
                  'Mysar6856',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                onTap: () => _launchURL('https://www.instagram.com/Mysar6856'),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.whatshot, color: Colors.white),
                label: Text(
                  'للشكاوى والاقتراحات',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => _launchURL('https://wa.me/734939353'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
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
