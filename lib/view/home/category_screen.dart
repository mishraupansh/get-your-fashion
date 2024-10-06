// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_your_fashion/res/app_url.dart';
import 'package:http/http.dart' as http;

import '../../models/sub_category_model.dart';

class CategoryScreen extends StatefulWidget {
  final String? catId;
  final String? name;
  const CategoryScreen({
    super.key,
    this.catId,
    this.name,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedSubcategoryIndex = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.name.toString()),
        ),
        body: FutureBuilder<List<SubCategoryModel>>(
          future: fetchSubcategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final subcategories = snapshot.data;
              return Column(
                children: [
                  SizedBox(
                    height: 100, // Set the desired height
                    child: ListView.builder(
                      itemCount: subcategories!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final subcategory = subcategories[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedSubcategoryIndex = index;
                            });
                          },
                          child: SizedBox(
                            width: 75,
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          index == 0 ? 15 : 50),
                                      border: Border.all(
                                        color: selectedSubcategoryIndex == index
                                            ? Colors.blue
                                            : Colors.black,
                                        width: 2,
                                      )),
                                  child: Image.network(
                                      'https://butick.wishufashion.com/uploads/${subcategory.image}'),
                                ),
                                Text(
                                  subcategory.name ?? '',
                                  style: TextStyle(
                                    color: selectedSubcategoryIndex == index
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0, // Spacing between rows
                        crossAxisSpacing: 8.0,
                      ),
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: subcategories[selectedSubcategoryIndex]
                          .subCategoriesItem
                          .length,
                      itemBuilder: (context, itemIndex) {
                        final item = subcategories[selectedSubcategoryIndex]
                            .subCategoriesItem[itemIndex];
                        return InkWell(
                          onTap: () {
                            // if (itemIndex == 0) {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               UploadDesignScreen()));
                            // } else {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               ProductDetails(
                            //                 productItem: subcategories[selectedSubcategoryIndex]
                            //                     .subCategoriesItem[itemIndex],
                            //               )));
                            // }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.orange,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://butick.wishufashion.com/uploads/${item.image}',
                                  width: 100,
                                ),
                                Text(
                                  item.name ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text:
                                      itemIndex == 0 ? "" : "Starting at "),
                                  TextSpan(
                                      text: itemIndex == 0 ? "" : "₹",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: item.starting_price ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ])),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future<List<SubCategoryModel>> fetchSubcategories() async {
    final categoryId = widget.catId;
    final response = await http.get(Uri.parse(
        '${AppUrl.subCategoryUrl}category_id=$categoryId'));
    if (response.statusCode == 200) {
      final List<dynamic> subcategoryList = json.decode(response.body)['data'];
      return subcategoryList
          .map((json) => SubCategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}
