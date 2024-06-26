import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/login_page/auth_gath.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/brick_breaker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final game = BrickBreaker();                                  // Modify this line
  runApp(GameWidget(game: game));
  // runApp(const MyApp());
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home:const AuthGate(),
//     );
//   }
// }
