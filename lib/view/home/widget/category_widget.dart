// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_your_fashion/models/category_model.dart';
import 'package:get_your_fashion/res/app_url.dart';
import 'package:get_your_fashion/utils/routes/routes_name.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<CategoryModel>>(
            future: fetchCategoryData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                List<CategoryModel> data = snapshot.data!;
                return data.isNotEmpty
                    ? GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.categoryScreen);
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductCategory(
                              //         catId:data[index].id.toString(),name:data[index].name.toString()
                              //     ),
                              //   ),
                              // );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(1.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://butick.wishufashion.com/uploads/${data[index].image}'),
                                      )),
                                ),
                                Positioned(
                                    bottom: 1,
                                    right: 60,
                                    child: Text(
                                      data[index].name.toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                          );
                        })
                    : const Center(
                        child: Text('No data available'),
                      );
              } else if (snapshot.hasError) {
                // Error occurred while loading data
                return Text('Error: ${snapshot.error}');
              } else {
                // Data is still loading
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.grey[600],
                ));
              }
            }));
  }
}

Future<List<CategoryModel>> fetchCategoryData() async {
  try {
    final response = await http.get(
        Uri.parse(AppUrl.categoryUrl));
    final decodedData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (decodedData['error'] == '200') {
        final jsonData = decodedData['data'] as List<dynamic>;
        return jsonData.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        if (kDebugMode) {
          print('Can not get data');
        }
      }
      return [];
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    throw Exception('Failed to load data: $error');
  }
}
