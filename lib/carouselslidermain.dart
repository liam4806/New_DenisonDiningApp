import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database_manager.dart';
import 'firestoreApi.dart';

class CarouselSilderMain extends StatefulWidget {
  const CarouselSilderMain({
    super.key,
  });

  @override
  State<CarouselSilderMain> createState() => _CarouselSilderMainState();
}

class _CarouselSilderMainState extends State<CarouselSilderMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbtoDart>(builder: (context0, dbtoDart, child) {
      return FutureBuilder<QuerySnapshot>(
          future: dbtoDart.readconf(),
          builder: (context1, snapshot1) {
            final documents = snapshot1.data?.docs ?? [];
            int image_length;
            if (documents.length != 0) {
              image_length = documents[0].get('item_num');
            } else {
              image_length = 0;
            }

            return FutureBuilder<List<String>>(
                future: FireStoreDataBase().getData(
                    image_length), // Load data from database to snapshot variable
                //error:
                //W/ProviderInstaller( 6882): Failed to load providerinstaller
                //module: No acceptable module com.google.android.gms.providerinstaller.dynamite
                //found. Local version is 0 and remote version is 0.
                //W/StorageUtil( 6882): no auth token for request

                // need to load item number from configuration in firebase
                builder: (context2, snapshot2) {
                  if (snapshot2.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot2.connectionState == ConnectionState.done) {
                    // takes a list of urls which load images from database
                    var value =
                        snapshot2.data ?? []; // if null, then empty list

                    return Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      color: Colors.white,
                      child: CarouselSlider(
                        items: List.generate(value.length, (i) => i).map((i) {
                          // need to change this dynamically
                          return Builder(
                            builder: (BuildContext context3) {
                              return Container(
                                  width: MediaQuery.of(context3).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(207, 202, 2, 52)),
                                  child: Image.network(
                                      value[i].toString())); // get ith image
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 0.9,
                          height: 200,
                          autoPlay: true,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      color: Colors.white,
                      child: CarouselSlider(
                        items: List.generate(0, (i) => i).map((i) {
                          // need to change this dynamically
                          return Builder(
                            builder: (BuildContext context4) {
                              return Container(
                                  width: MediaQuery.of(context4).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                  child: Text(
                                    'No image',
                                    style: TextStyle(fontSize: 16.0),
                                  ));
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 0.9,
                          height: 200,
                          autoPlay: true,
                        ),
                      ),
                    );
                  }
                });
          });
    });
  }
}
