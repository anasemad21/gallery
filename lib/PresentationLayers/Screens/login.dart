import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galleryapp/Controller/LoginController.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible=true;
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with Text
              Image.asset(
                'assets/images/log in.png',
                fit: BoxFit.fill,
              ),
              // Container with Background Blur
              Positioned(
                bottom: 130.0,
                left: 0,
                right: 0,
                top: 200.0,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    padding: EdgeInsets.all(28.sp),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15.h),
                        Text(
                          "LOG IN",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: 300.w,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: controllerEmail,
                            decoration: InputDecoration(
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                              fillColor: Color(0xffF7F7F7),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 20.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF7F7F7),
                                ),
                                borderRadius: BorderRadius.circular(22.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: 300.w,
                          child: TextField(
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.visiblePassword,
                            controller: controllerPassword,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                              fillColor: Color(0xffF7F7F7),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffF7F7F7),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        Container(
                          width: 300.w,
                          child: ElevatedButton(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff7BB3FF),
                            ),
                            onPressed: () async{
                              await LoginController().login(context, controllerEmail.text, controllerPassword.text);
                              // GoRouter.of(context).push(AppRouter.kHomeView);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 80.0,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'My',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
