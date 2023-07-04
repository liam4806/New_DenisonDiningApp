import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSilderMain extends StatelessWidget {
  const CarouselSilderMain({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: CarouselSlider(
        items: [
          //*********************** */
          //NEED IMAGES FROM FIREBASE
          //*********************** */
          //DELETE BELOW CENTER() AFTER SETTING FIREBASE IMAGES
          Center(
            child: Text(
              "HELLO",
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            'assets/images/campus.jpg',
            fit: BoxFit.cover,
          ),
        ],
        options: CarouselOptions(
          viewportFraction: 0.9,
          height: 200,
          autoPlay: true,
        ),
      ),
    );
  }
}
