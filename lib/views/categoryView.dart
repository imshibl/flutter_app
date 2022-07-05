// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/notifiers/getCategoryNotifier.dart';
import 'package:flutter_app/views/subCategoryView.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CategoryNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Health Care",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        elevation: 0,
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
          Consumer<CategoryNotifier>(builder: (context, data, _) {
            return data.isDataLoaded
                ? Badge(
                    position: BadgePosition(top: 0, start: 10),
                    badgeColor: Colors.grey,
                    badgeContent: Text(
                      data.favCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.favorite))
                : Icon(Icons.favorite);
          }),
          SizedBox(width: 10),
          Consumer<CategoryNotifier>(builder: (context, data, _) {
            return data.isDataLoaded
                ? Badge(
                    position: BadgePosition(top: 0, start: 10),
                    badgeColor: Colors.grey,
                    badgeContent: Text(
                      data.cartCount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.shopping_cart))
                : Icon(Icons.shopping_cart);
          }),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<CategoryNotifier>(
              builder: ((context, data, _) {
                return data.isDataLoaded
                    ? Image.network(data.adImage)
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      );
              }),
            ),
            FutureBuilder(
              future: data.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 240, crossAxisCount: 2),
                    itemCount: data.categories.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return categoryCardWidget(
                          data: data,
                          index: index,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) =>
                                    SubCategoryView(index: index)),
                              ),
                            );
                          });
                    },
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryCardWidget(
      {required CategoryNotifier data,
      required int index,
      required VoidCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Image.network(data.categories[index].image)),
        ),
        Text(
          data.categories[index].title,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
