import 'package:dukoin/presentation/pages/home_page.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/presentation/widgets/bouncy_bottom_nav_bar.dart';
import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukoin',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: NavigationState(child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [
    HomePage(),
    Center(child: Text('Settings')),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: NavigationState.of(context).currentPageStream,
        initialData: 0,
        builder: (context, asyncSnapshot) {
          return _pages[asyncSnapshot.data!];
        }
      ),
      bottomNavigationBar: BouncyBottomNavBar(),
    );
  }
}