import 'package:flutter/material.dart';
import 'package:flutter_5_oy_imtixon/database/google_sheets_service.dart';
import 'package:flutter_5_oy_imtixon/features/auth/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SheetService.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginScreen(),
    );
  }
}
