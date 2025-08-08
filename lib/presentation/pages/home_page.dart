import 'package:dukoin/presentation/pages/add_expense_page.dart';
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
          child: ListView(children: [HomeAppBar(), HomeContent()]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddExpensePage()));
        },
      ),
    );
  }
}
