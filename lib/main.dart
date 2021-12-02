import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'translate_provider.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TranslateProvider>.value(
          value: TranslateProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Translator',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: Colors.orange[200],
        ),
        home: HomePage(title: 'Translator'),
      ),
    );
  }
}
