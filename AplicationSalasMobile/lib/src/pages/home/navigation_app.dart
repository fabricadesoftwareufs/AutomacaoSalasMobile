import 'package:aplicationsalasmobile/src/pages/Reservas/menu_semanal.dart';
import 'package:aplicationsalasmobile/src/pages/Salas/salas_page.dart';
import 'package:flutter/material.dart';

class NavigationApp extends StatelessWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('SalasUfs'),
            bottom: TabBar(
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                    child: Center(child: Text('Minhas Salas')),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                    child: Center(child: Text('Minhas Reservas')),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.grey.shade200,
            child: const TabBarView(
              children: <Widget>[
                SalasPage(),
                MenuSemanal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
