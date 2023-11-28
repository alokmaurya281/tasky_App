import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/firebase_options.dart';

class InitializeApp {
  static  intialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // intialize firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return prefs;
  }

}
