import 'package:flutter/material.dart';
import 'simple_list.dart';
import 'infinity_list.dart';
import 'infinity_math_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Списки',
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          unselectedLabelColor: Color.fromARGB(179, 255, 255, 255),
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Типы списков'),
            backgroundColor: const Color.fromARGB(255, 176, 140, 238),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.all_inclusive)),
                Tab(icon: Icon(Icons.calculate)),
              ],
            ),
          ),
          body: Container(
            child: const TabBarView(
              children: [
                SimpleList(),
                InfinityList(),
                InfinityMathList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}