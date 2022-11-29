import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/item_conta_form_page.dart';
import 'models/conta.dart';
import 'utils/constants.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Conta>(create: (_) => Conta(Constants.appName)),
      ],
      child: MaterialApp(
        title: Constants.appName,
        theme: ThemeData(
          colorScheme: const ColorScheme(
              primary: Color.fromARGB(255, 7, 45, 77),
              secondary: Color.fromARGB(255, 8, 129, 243),
              surface: Color.fromARGB(255, 245, 245, 214),
              background: Color.fromARGB(255, 236, 236, 202),
              error: Color.fromARGB(255, 253, 20, 3),
              onPrimary: Colors.white,
              onSecondary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
              onBackground: Color.fromARGB(255, 255, 255, 255),
              onError: Colors.white,
              brightness: Brightness.light),
        ),
        routes: {
          AppRoutes.home: (_) => const HomePage(),
          AppRoutes.itemContaForm: (_) => const ItemContaForm(),
        },
      ),
    );
  }
}
