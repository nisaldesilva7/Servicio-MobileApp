import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:servicio/shared/SliderImages.dart' as assets;


class Notifications extends StatelessWidget{
  final List<String> images = [assets.images[0],assets.images[2],assets.images[1], assets.images[3]];

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Notifications"),
      ),
      body: new Center(
        child: _slider(),
      ),
    );
  }

  Widget _slider(){
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        autoPlayCurve: Curves.easeInOutCubic,
        enlargeCenterPage: true,
//        onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,

    ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                      color: Colors.amber
                  ),
                  child: Image.network(
                    i,
                    fit: BoxFit.cover,
                  ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}