import 'package:flutter/material.dart';
import 'package:get_your_fashion/view/home/widget/banner_widget.dart';
import 'package:get_your_fashion/view/home/widget/category_widget.dart';
import '../../res/assets_images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          const BannerWidget(),
          Container(
            height: heights / 15,
            color: const Color(0xffe5dec2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(AssetsImages.assetsHappyCustomer),
                const Text(
                  "50,000+happy\nCustomers",
                  style: TextStyle(fontSize: 10),
                ),
                const VerticalDivider(
                  color: Colors.brown,
                  thickness: 1,
                  width: 5,
                  endIndent: 8,
                  indent: 8,
                ),
                Image.asset(AssetsImages.assetsPickup),
                const Text(
                  "Pickup&Delivery",
                  style: TextStyle(fontSize: 10),
                ),
                const VerticalDivider(
                  color: Colors.brown,
                  thickness: 1,
                  width: 5,
                  endIndent: 8,
                  indent: 8,
                ),
                Image.asset(AssetsImages.assetsFashion),
                const Text(
                  "Fashion designer\nconsultation",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
          const Center(
              child: Column(
            children: [
              Text(
                " Categories",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              Text(
                "Your choice, we'll design & stitch,just for you!",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )),
          const SizedBox(
            height: 420,
            child: CategoriesWidget(),
          )
        ],
      ),
    );
  }
}
