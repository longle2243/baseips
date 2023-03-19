import 'package:firebase_core/firebase_core.dart';

import 'package:floorplans/widget/drawer.dart';
import 'package:floorplans/screen/floorplan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late Future<String?> _future;

  @override
  void initState() {
    _future = rootBundle.loadString('assets/floorplan.json');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.blueGrey.shade50),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            // elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white)
        ),
        drawer: DrawerMenu(),
        body: FutureBuilder<String?>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHomePage(json: snapshot.data!);
            } return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  final String json;
  const MyHomePage({required this.json, Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: FloorPlan(jsonFloorplan: widget.json))]);
  }
}
