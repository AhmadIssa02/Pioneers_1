import 'package:flutter/material.dart';
import 'package:new_app/login/widgets/views/account_view.dart';
import 'package:new_app/login/widgets/views/capital_mart_view.dart';
import 'package:new_app/login/widgets/main_app_bar.dart';
import 'package:new_app/login/widgets/views/support_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff444444),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const MainAppBar(),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
              tabs: [
                Tab(
                  text: "ACCOUNT",
                  icon: Icon(Icons.account_circle),
                ),
                Tab(
                  text: "CAPITALMART",
                  icon: Icon(Icons.shopify),
                ),
                Tab(
                  text: "SUPPORT",
                  icon: Icon(Icons.phone_callback),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(children: [
              AccountView(),
              //column
              //container, bg gradient
              //scrollable icon circle
              //button icon
              //
              CapitalMartView(),
              SupportView(),
            ]))
          ],
        ),
      ),
    );
  }
}
