import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'quotes.dart';
import 'constants.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: CarouselSlider.builder(
          itemCount: quotesList.length,
          itemBuilder: (context, index1, index2) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    quotesList[index1][kQuote],
                    style: kAuthorTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(quotesList[index1][kAuthor]),
              ],
            );
          },
          options: CarouselOptions(
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              initialPage: 0,
              enlargeCenterPage: true),
        ),
      ),
    );
  }
}
