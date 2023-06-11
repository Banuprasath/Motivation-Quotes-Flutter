import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'quotes.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List? imageList;
  int imgnumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagesFromUnsplash();
  }

  @override
  Widget build(BuildContext context) {
    // print(quotesList.length);

    return Scaffold(
      body: imageList != null
          ? Stack(
              children: [
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: BlurHash(
                    key: ValueKey(
                      imageList?[imgnumber!]['blur_hash'],
                    ),
                    hash: imageList![imgnumber!]['blur_hash'],
                    duration: const Duration(microseconds: 500),
                    image: imageList![imgnumber!]['urls']['regular'],
                    curve: Curves.easeInOut,
                    imageFit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black54.withOpacity(0.6),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
/*        decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(
                        imageList?[imgnumber]['urls']['regular'],
                      ),
                      fit: BoxFit.cover)),*/

                  child: SafeArea(
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
                                style: kQuoteTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "-${quotesList[index1][kAuthor]}-",
                              style: kAuthorTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          pageSnapping: true,
                          initialPage: 1,
                          enlargeCenterPage: true,
                          onPageChanged: (index, value) {
                            HapticFeedback.lightImpact();

                            imgnumber = index;
                            if (imgnumber >= 42) {
                              imgnumber = 15;
                            }
                            print(imgnumber);
                            setState(() {});
                          }),
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    right: 30,
                    child: Row(
                      children: [
                        Text(
                          '${imageList![imgnumber!]['user']['username']}',
                          style: kAuthorTextStyle,
                        ),
                        Text(' On ', style: kAuthorTextStyle),
                        Text('Unsplash', style: kAuthorTextStyle)
                      ],
                    ))
              ],
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Container(
                  width: 100,
                  height: 100,
                  child: SpinKitFadingCircle(color: Colors.white)),
            ),
    );
  }

  void getImagesFromUnsplash() async {
    var url =
        'https://api.unsplash.com/search/photos?per_page=30&query=nature&order_by=relevant&client_id=$accesskey';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    print(response.statusCode);
    var unsplashData = json.decode(response.body);
    imageList = unsplashData['results'];
    setState(() {});
  }
}
