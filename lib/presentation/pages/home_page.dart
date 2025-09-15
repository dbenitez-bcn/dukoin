import 'package:dukoin/presentation/widgets/dukoin_fab.dart';
import 'package:dukoin/presentation/widgets/home_app_bar.dart';
import 'package:dukoin/presentation/widgets/home_content.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: [HomeAppBar(), HomeContent()]),
          ),
        ),
      ),
      floatingActionButton: DukoinFab(),
    );
  }
}
