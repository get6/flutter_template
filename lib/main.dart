import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/pages/home_page.dart';
import 'package:template/pages/loading_page.dart';
import 'package:template/pages/something_went_wrong.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  // Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
  // runApp(ProviderScope(child: newApp()));
}

class MyApp extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final String title = 'ITTAE template';
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return SomethingWentWrong();
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              // return DoneApp();
              return HomePage();
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return LoadingPage();
          },
        ),
      ),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
