import 'dart:developer';

import 'package:flutter/foundation.dart';


class MyProv with ChangeNotifier {
  List<String> imageUrls = [];
  setProducts(List<String> products) {
    this.imageUrls = imageUrls;
    notifyListeners();
  }



}
