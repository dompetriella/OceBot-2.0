import 'package:flutter/material.dart';
import 'package:ocebot2_0/firebase_options.dart';
import 'package:ocebot2_0/pages/login_page.dart';
import 'package:ocebot2_0/providers/auth_provider.dart';
import 'themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authenticationProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ocebot',
      theme: OcebotTheme.lightTheme,
      home: const LoginScreen()
    );
  }
}

