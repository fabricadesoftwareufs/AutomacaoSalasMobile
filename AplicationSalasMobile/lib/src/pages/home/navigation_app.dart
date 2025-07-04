import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/pages/Reservas/menu_semanal.dart';
import 'package:salas_mobile/src/pages/Salas/salas_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salas_mobile/src/providers/theme_provider.dart';
import '../user/user_info_page.dart';

class NavigationApp extends StatefulWidget {
  final AuthResponseModel auth;
  const NavigationApp({super.key, required this.auth});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          title: const Text('SmartSala', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage(auth: widget.auth),
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
              ),
              child: TabBarView(
                children: <Widget>[
                  SalasPage(auth: widget.auth),
                  const MenuSemanal(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 65,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xff2d2d2d)
                : Colors.grey.shade500,
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white54
                : Colors.black38,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const <Widget>[
              Tab(
                child: Center(child: Text('Minhas Salas', style: TextStyle(color: Colors.white))),
              ),
              Tab(
                child: Center(child: Text('Minhas Reservas', style: TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}