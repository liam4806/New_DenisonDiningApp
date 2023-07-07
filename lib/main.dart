import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/carouselslidermain.dart';
import 'package:helloworld/homebutton.dart';
import 'package:helloworld/subtitlehome.dart';
import 'package:helloworld/bottomdenisonlogo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //The root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Denison Dining App',
      //App theme control by device system
      //if user's device is in dark mode, it will be dark mode
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      // A widget which will be started on application startup
      home: const MyHomePage(title: 'DENISON DINING'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Color.fromRGBO(240, 245, 249, 100),
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        centerTitle: false,
        // The title text which will be shown on the action bar
        title: Text(
          title,
          //textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'merri',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ), /*Image.asset(
              'assets/images/denison.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),*/
        ),

        /*Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'merri',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),*/
        //Appbar rightmost button
        actions: const [
          Icon(
            CupertinoIcons.person_solid,
            //**********************************/
            //NEED AUTHENTIFICATION NEAR FUTURE
            //*********************************/
            color: Colors.black,
          )
        ],
        backgroundColor: Colors.grey[50],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CarouselSilderMain(),
              const SubTitleHome(
                stitle: 'Today\'s Menu',
              ),
              const HomeButton(
                buttontitle: 'Curtis Dining Hall',
                buttonsubtitle: 'Healthy, Seasonal Comfort',
                buttonimage: 'assets/images/Curtis.jpg',
                dininghall:
                    'https://denison.cafebonappetit.com/cafe/curtis-cafe/',
              ),
              const HomeButton(
                buttontitle: 'Huffman Dining Hall',
                buttonsubtitle: 'Fresh, Sustainable, Variety',
                buttonimage: 'assets/images/Huffman.jpg',
                dininghall:
                    'https://denison.cafebonappetit.com/cafe/huffman-cafe/',
              ),
              const HomeButton(
                buttontitle: 'Slayters Market',
                buttonsubtitle: 'Convenient, House made,\nBarista made Coffee',
                buttonimage: 'assets/images/slayter.jpg',
                dininghall:
                    'https://denison.cafebonappetit.com/cafe/slayter-market/',
              ),
              const SubTitleHome(
                stitle: 'Specials',
              ),
              const HomeButton(
                buttontitle: 'Silverstein',
                buttonsubtitle: 'Pizza, Sandwich,\nFresh ingredients',
                buttonimage: 'assets/images/silverstein.jpg',
                dininghall:
                    'https://denison.cafebonappetit.com/cafe/silverstein/',
              ),
              const HomeButton(
                buttontitle: 'The Nest at the Roost',
                buttonsubtitle:
                    'Student-driven, Flatbreads, \nSandwich, Desserts',
                buttonimage: 'assets/images/nest.jpg',
                dininghall:
                    'https://denison.cafebonappetit.com/cafe/the-roost/',
              ),
              const DenisonLogo()
            ],
          ),
        ),
      ),
    );
  }
}
