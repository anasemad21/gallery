import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../DataLayer/WebServices/ApiHelper.dart';
import '../DataLayer/WebServices/Provider.dart';
import '../Models/Response/GetGalleryResponse.dart';



class ProductController{

  static final ProductController _singleton = ProductController._internal();

  factory ProductController() {
    return _singleton;
  }

  ProductController._internal();

  //////////////////////////////////////////////////////
  ApiHandler api=ApiHandler();
  /////////////////////////////////////////////////////
  // Map<String,dynamic>? products;
//////////////////////////////////////////////,

  //////////////////////// Show
  getGallery(BuildContext context) async{

    try{

  Map<String,dynamic>?  gallery = await api.authorizedGetRequest('my-gallery', context,);
  GalleryResponse galleryResponse=GalleryResponse.fromJson(gallery!);


  if (galleryResponse.status == 'success') {
    List<String> imageUrls = [];
    List<dynamic>? imagesData = galleryResponse.data!.images!;
    if (imagesData != null || imagesData.isEmpty) {
      for (var imageData in imagesData) {
        imageUrls.add(imageData.toString());
      }
    }
    Provider.of<MyProv>(context,listen: false).setProducts(imageUrls);
    return imageUrls;
  }

  else{
    Fluttertoast.showToast(
        msg: galleryResponse.message??"Check Your Inputs",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 16.0
    );
    throw Exception();
  }

  }
    catch (ex){

    }finally {
      context.loaderOverlay.hide();
    }

}

  Future<void> uploadImage(imagePaths, String imageUrl) async {
    var url = 'https://flutter.prominaagency.com/api/'; // Replace {{url}} with your actual URL
    var request = http.MultipartRequest('POST', Uri.parse(url));
    for (var imagePath in imagePaths) {
      var file = File(imagePath);
      request.files.add(await http.MultipartFile.fromPath('img', imagePaths));
    }

    try {
      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        // Image uploaded successfully
        print(await response.stream.bytesToString());
      } else {
        // Handle error
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }
  // Create
//   Future<void> createProduct(BuildContext context, CreateProductRequest product) async {
//     // try {
//
//
//       Map<String, dynamic>? requestData = product.toJson();
//
//       final Map<String, dynamic>? response = await api.authorizedPostRequest(
//         'drivers_app/product',
//         context,
//         requestData:requestData,
//       );
//       log("toast response"+jsonEncode(response));
//       GeneralResponse generalResponse = GeneralResponse.fromJson(response!);
//
//       if (generalResponse.status == true) {
//         // Client updated successfully
//         Fluttertoast.showToast(
//           backgroundColor: Color(0XFF00B9FF),
//           msg: Trans('Product added successfully').tr,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 6,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//
//       } else {
//         Fluttertoast.showToast(
//           msg: generalResponse.message ?? "Failed to add product",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           textColor: Colors.white,
//           backgroundColor: Colors.red,
//           fontSize: 16.0,
//         );
//
//       }
//     }
//     // catch (ex) {
//     //   Handle any errors or exceptions
//       // log("ex: $ex");
//     // }
//   // }
//
//
//
//
//   String token = SharedPreferencesManager.getString('token').toString();
//   // final String baseUrl = 'https://dev.generalhouseservices.com/api/';
//
//   Future<void> sendCreateProductRequest(BuildContext context,CreateProductRequest requestData) async {
//
//     // Create a MultipartRequest
//     var request = http.MultipartRequest('POST', Uri.parse('https://dev.generalhouseservices.com/api/drivers_app/product'));
// log("image in req path:"+requestData.imageUrl.path);
// log("image in req:"+requestData.imageUrl.toString());
// log("name in req:"+requestData.name);
//
//     request.headers['Authorization'] = 'Bearer ${token}'; // Replace with your actual token
//     request.headers['api-token'] = 'gh-general';
//     request.fields['name'] = requestData.name;
//     request.files.add(await http.MultipartFile.fromPath(
//       'img_path',
//       requestData.imageUrl.path,
//     ));
//
//     for (var i = 0; i < requestData.options.length; i++) {
//       request.fields['options[$i][name]'] = requestData.options[i].name;
//       request.fields['options[$i][price]'] = requestData.options[i].price;
//     }
// log("request:"+request.fields['name'].toString());
//     try {
//       // Send the request
//       var response = await http.Response.fromStream(await request.send());
//       // Handle the response
//       var responseBody = json.decode(response.body);
//       if(responseBody['status'] == true){
//         Fluttertoast.showToast(
//             backgroundColor: Color(0XFF00B9FF),
//             msg:Trans('Added Successfully').tr,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 6,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//         Navigator.of(context).pop();
//       }
//       else{
//         Fluttertoast.showToast(
//             backgroundColor: Color(0XFF00B9FF),
//             msg:Trans('Review Your Data').tr,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 6,
//             textColor: Colors.white,
//             fontSize: 16.0
//         );
//       }
//       log('Response status pro: ${response.statusCode}');
//       log('Response body pro : ${response.body}');
//     } catch (e) {
//       log('Error sending request: $e');
//     }
//   }

}