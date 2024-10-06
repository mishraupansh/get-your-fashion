import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_your_fashion/models/banner_model.dart';
import 'package:get_your_fashion/res/app_url.dart';
import 'package:http/http.dart'as http;


class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return CarouselSlider(
      options: CarouselOptions(
        height: heights / 3,
        viewportFraction: 1.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: bannerList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: heights / 3,
                      width: widths / 1.5,
                      decoration: BoxDecoration(
                          color: const Color(0xffEC6736),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://butick.wishufashion.com/uploads/${i.banner}'),
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  List<BannerModel> bannerList = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse(AppUrl.homeSlider));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'] as List<dynamic>;
        setState(() {
          bannerList = jsonData.map((item) => BannerModel.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }
}
