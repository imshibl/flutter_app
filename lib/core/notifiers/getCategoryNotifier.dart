import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/model.dart';

import '../api/fetch_data.dart';

class CategoryNotifier extends ChangeNotifier {
  FetchData fetchData = FetchData();

  List<CateModel> categories = [];
  List<ProductsModel> productsList = [];
  late String adImage;
  late int cartCount;
  late int favCount;

  bool isDataLoaded = false;

  Future getCategories() async {
    categories.clear();
    productsList.clear();
    try {
      isDataLoaded = false;

      var response = await fetchData.getCategories();

      var parsedData = await json.decode(response.body);

      var cate = parsedData['data']['category'];
      var products = parsedData['data']['products'];
      adImage = parsedData['data']['image'];
      favCount = parsedData['data']['favouriteCount'];
      cartCount = parsedData['data']['cartCount'];

      for (var i in cate) {
        CateModel category =
            CateModel(id: i["_id"], title: i["title"], image: i["image"]);
        categories.add(category);
      }

      for (var i in products) {
        ProductsModel product = ProductsModel(
          id: i["_id"],
          title: i["title"],
          image: i["image"],
          brand: i["brand"],
          discount: i["discount"],
          price: i["price"],
          size: i["uom"],
          splPrice: i["spl_price"],
          stock: i["stockStatus"],
        );
        productsList.add(product);
      }

      isDataLoaded = true;

      notifyListeners();
      return categories;
    } catch (e) {
      return e;
    }
  }
}
