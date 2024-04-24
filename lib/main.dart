import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'DataLayer/WebServices/Provider.dart';
import 'DataLayer/WebServices/SharedPrefManager.dart';
import 'core/utils/app_router.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  runApp( ChangeNotifierProvider(
      create: (_) => MyProv(),
      child:  Gallery(),),);
}

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key); // Fixed the constructor here
  @override
  Widget build(BuildContext context) {
    return
      ScreenUtilInit(
      designSize: const Size(450  , 900),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xff100B20),
          textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
        builder: (context, router) {
          return GlobalLoaderOverlay(
            child: router!,
          );
        },
      ),
    );
  }
}
