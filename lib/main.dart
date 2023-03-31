import 'package:flutter/material.dart';
import 'package:flutter_notes/widgets/bottom_nav_widget.dart';
import 'package:provider/provider.dart';

import '../providers/note_collection.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => NoteCollection(),
        child: MyApp(),
        // builder: (context, _) => NoteCollection(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Futter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.black87),
        // appBarTheme: AppBarTheme(
        //     backgroundColor: Colors.teal, foregroundColor: Colors.white),
      ),
      home: BottomNavBar(),
    );
  }
}
