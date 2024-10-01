import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luit_dealer/core/controllers/init_controllers.dart';
import 'package:luit_dealer/core/local/init_local_storage.dart';
import 'package:luit_dealer/core/theme/app_theme.dart';
import 'package:luit_dealer/features/auth/view/screens/login_screen.dart';
import 'package:luit_dealer/features/auth/viewModel/login_view_model.dart';
import 'package:luit_dealer/features/auth/viewModel/user_view_model.dart';
import 'package:luit_dealer/features/bottom_navigation_screen.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initControllers();
  final userViewModel = Get.find<UserViewModel>();

  await LocalStorage().initLocalStorage();
  await userViewModel.fetchUserModel(null);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getFcmToken();
  }

  final loginViewModel = Get.find<LoginViewModel>();
  final userViewModel = Get.find<UserViewModel>();

  void getFcmToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    loginViewModel.updateFCM(token!);
    Logger().i('FCM Token: $token');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!);
      },
      themeMode: ThemeMode.dark,
      defaultTransition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 300),
      title: 'Luit',
      theme: customLightTheme(),
      getPages: [
        GetPage(name: '/home', page: () => BottomNavigationScreen()),
        GetPage(name: '/', page: () => LoginScreen())
      ],
      initialRoute: userViewModel.user != null ? '/home' : '/',
    );
  }
}
