import 'package:flutter/material.dart';
import 'package:mobile/sse/presentation/pages/sse_bloc_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(body: SafeArea(child: SimpleListPage())),
      // home: Scaffold(body: SafeArea(child: BlocListPage())),
      home: Scaffold(body: SafeArea(child: SseBlocListPage())),
    );
  }
}
