
import 'package:go_router/go_router.dart';

import '../../PresentationLayers/Screens/gallery.dart';
import '../../PresentationLayers/Screens/login.dart';
abstract class AppRouter {
  static const kHomeView = '/GalleryScreen';


  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) =>  GalleryScreen(),
      ),

    ],
  );
}