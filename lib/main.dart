import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spotmies/controllers/login_controller/splash_screen_controller.dart';
import 'package:spotmies/providers/chat_provider.dart';
import 'package:spotmies/providers/getOrdersProvider.dart';
import 'package:spotmies/providers/getResponseProvider.dart';
import 'package:spotmies/providers/localization_provider.dart';
import 'package:spotmies/providers/mapsProvider.dart';
import 'package:spotmies/providers/orderOverviewProvider.dart';
import 'package:spotmies/providers/responses_provider.dart';
import 'package:spotmies/providers/theme_provider.dart';
import 'package:spotmies/providers/timer_provider.dart';
import 'package:spotmies/providers/universal_provider.dart';
import 'package:spotmies/providers/userDetailsProvider.dart';
import 'package:spotmies/utilities/notifications.dart';

// recieve messages when app is in background
Future<void> backGroundHandler(RemoteMessage message) async {
  displayAwesomeNotificationBackground(message); 
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  awesomeInitilize();
  await EasyLocalization.ensureInitialized();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onBackgroundMessage(backGroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeProvider>(
            create: (context) => TimeProvider(),
          ),
          ChangeNotifierProvider<UserDetailsProvider>(
            create: (context) => UserDetailsProvider(),
          ),
          ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider(),
          ),
          ChangeNotifierProvider<UniversalProvider>(
            create: (context) => UniversalProvider(),
          ),
          ChangeNotifierProvider<ResponsesProvider>(
            create: (context) => ResponsesProvider(),
          ),
          ChangeNotifierProvider<GetOrdersProvider>(
            create: (context) => GetOrdersProvider(),
          ),
          ChangeNotifierProvider<OrderOverViewProvider>(
            create: (context) => OrderOverViewProvider(),
          ),
          ChangeNotifierProvider<MapsProvider>(
            create: (context) => MapsProvider(),
          ),
          ChangeNotifierProvider<GetResponseProvider>(
            create: (context) => GetResponseProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LocalizationProvider>(
            create: (context) => LocalizationProvider(),
          ),
        ],
        child: EasyLocalization(
          child: MyApp(),
          supportedLocales: [
            Locale("en", "US"),
            Locale("hi", "IN"),
            Locale("te", "IN")
          ],
          path: 'assets/translations',
          fallbackLocale: Locale("en", "US"),
        ),
      ),
    );
  });
}

Future<void> setPrefThemeMode(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var system_themeMode =
      WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;
  var pref_themeMode =
      (sharedPreferences.getBool("theme_mode") ?? system_themeMode);
  var themeMode = system_themeMode ? ThemeMode.dark : ThemeMode.light;
  if (system_themeMode == false && pref_themeMode == true) {
    themeMode = ThemeMode.dark;
  }
  Provider.of<ThemeProvider>(context, listen: false).setThemeMode(themeMode);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late IO.Socket socket;
  @override
  void initState() {
    // connect();
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setPrefThemeMode(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    print("ThemeModeChanged");
    setPrefThemeMode(context);
  }

  @override
  Widget build(BuildContext context) {
    SpotmiesTheme().init(context);
    Provider.of<LocalizationProvider>(context, listen: true).addListener(() {
      var locale =
          Provider.of<LocalizationProvider>(context, listen: false).language;
      var localeVar = locale == 0
          ? Locale("en", "US")
          : locale == 1
              ? Locale("te", "IN")
              : Locale("hi", "IN");
      setState(() {
        EasyLocalization.of(context)?.setLocale(localeVar);
      });
      print(localeVar);
    });

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.fallback().copyWith(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: SpotmiesTheme.themeMode
                  ? SpotmiesTheme.surface
                  : SpotmiesTheme.primaryVariant)),
      home: SplashScreen(),
    );
  }

  // void connect() {
  //   // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
  //   socket = IO.io("https://spotmies.herokuapp.com", <String, dynamic>{
  //     "transports": ["websocket", "polling", "flashsocket"],
  //     "autoConnect": false,
  //   });

  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("message", (msg) {
  //       print(msg);
  //     });
  //   });
  //   socket.connect();
  //   //  socket.emit('join-room', FirebaseAuth.instance.currentUser.uid);
  // }
}






// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

// class LocationService {
//   Future<LocationData> getLocation() async {
//     Location location = new Location();
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         throw Exception();
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         throw Exception();
//       }
//     }

//     _locationData = await location.getLocation();
//     return _locationData;
//   }
// }
