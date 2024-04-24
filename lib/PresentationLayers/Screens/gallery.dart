import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'dart:io';

import '../../Controller/GalleryController.dart';
class GalleryScreen extends StatefulWidget {
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePicker picker = ImagePicker();
  String? fileName;
  File? img;
  List<String> imageUrls = [];
  // void initState() {
  //   super.initState();
  //
  //   ProductController().getGallery(context).then((value) {
  //     setState(() {
  //       imageUrls = value ?? []; // Assign an empty list if value is null
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/gellary.png',
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Column containing text and circular image
          Positioned(
            top: 25,
            left: 30,
            right: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Anas',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/6830 1.png'),
                ),
              ],
            ),
          ),

          // Bottom row with buttons
          Positioned(
            bottom: 500,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  icon: 'assets/images/Group 18.png',
                  text: 'Log Out',
                  onPressed: () {
                    // Add your onPressed action here
                  },
                ),
                _buildButton(
                  icon: 'assets/images/Group 17.png',
                  text: 'Upload',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Material(
                          color: Colors.transparent, // Set the background color of the dialog
                          child: Center(
                            child: Container(
                              width: 300.w,
                              height: 300.h,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white12.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: AlertDialog(
                                backgroundColor: Colors.transparent, // Set the background color of the AlertDialog to transparent
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                content:

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () async{
                                        XFile? imge = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        img = File(imge!.path);
                                        fileName = imge.path.split("/").last;
                                        log("image path: " + img.toString());
                                        log("file name: " + fileName!);
                                        log("img" + imge.toString());
                                        String imageUrl = fileName!.trim();
                                        await ProductController().uploadImage(context, imageUrl);

                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Color(0xffF7F7F7),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                        ),
                                        backgroundColor: Color(
                                            0xffEFD8F9), // Set the background color here
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            'assets/images/gallery.png',
                                            width: 15.w,
                                            height: 25.h,
                                          ),
                                          Text(
                                            'Gallery',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    OutlinedButton(
                                      onPressed: ()async {
                                        XFile? imge = await picker.pickImage(
                                            source: ImageSource.camera);
                                        img = File(imge!.path);
                                        fileName = imge.path.split("/").last;
                                        log("image path: " + img.toString());
                                        log("file name: " + fileName!);
                                        log("img" + imge.toString());
                                        String imageUrl = fileName!.trim();
                                        await ProductController().uploadImage(context, imageUrl);

                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Color(0xffF7F7F7),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                        ),
                                        backgroundColor: Color(0xffEBF6FF),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            'assets/images/gallery.png',
                                            width: 15.w,
                                            height: 25.h,
                                          ),
                                          Text(
                                            'Camera',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ),
                          ),
                        );
                      },
                    );

                  },
                ),
              ],
            ),
          ),

          // GridView of images
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: imageUrls.isEmpty ? 15 : imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  // imageUrls[index] != null ?
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(20.0),
                  //   child:
                  //   Image.network(
                  //     'http://localhost:8000/media/3/IMG_1460.JPG${imageUrls[index]}',
                  //     height: 90.h,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ):
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:Image.asset(
                    'assets/images/6830 1.png',
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
                );

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Color(0xffF7F7F7),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}
