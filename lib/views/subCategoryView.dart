// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/notifiers/getCategoryNotifier.dart';

import 'package:provider/provider.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<CategoryNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 100, right: 70),
              child: Text(
                data.categories[widget.index].title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120.0),
                    ),
                  ),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 10, top: 100, bottom: 10),
                      itemBuilder: ((context, index) {
                        return Row(
                          children: [
                            Image.network(
                              data.categories[widget.index].image,
                              height: 100,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.categories[widget.index].title,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  Text(
                                    "No items",
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      })),
                ),
                Positioned(
                  right: 0,
                  child: Transform.translate(
                      offset: Offset(-5, -100),
                      child:
                          Image.network(data.categories[widget.index].image)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
