import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttest/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:fluttest/services/users_service.dart';
import 'package:fluttest/theme.dart';
import 'package:jiffy/jiffy.dart';

const firebaseConfig = {};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyD-I25kvPykg4_UMPGukZd7mSGQDlkjQVM",
              authDomain: "fludbb.firebaseapp.com",
              projectId: "fludbb",
              storageBucket: "fludbb.appspot.com",
              messagingSenderId: "721999817244",
              appId: "1:721999817244:web:6babcd8cbb239242924dd9")
          : null);
  await Jiffy.setLocale('fr');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Messagerie Simplon',
        theme: myTheme,
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
        routes: {
          '/sign-in': (_) {
            return SignInScreen(
              providers: [EmailAuthProvider()],
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  //Ajoute ou met à jour l'utilisateur dans la base
                  UsersServices.set(
                    state.user!.uid,
                    state.user!.email!,
                  );
                  //Redirige vers la Home Page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }),
              ],
            );
          },
          HomePage.name: (_) {
            return const HomePage();
          },
        });
  }
}
