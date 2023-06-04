import 'package:aplicationsalasmobile/src/pages/Reservas/menu_semanal.dart';
import 'package:aplicationsalasmobile/src/pages/Salas/salas_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({Key? key}) : super(key: key);

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            title: const Text('SalasUfs', style: TextStyle(color: Colors.white)),
            backgroundColor: Color(0xff3d31dd),
            elevation: 0,
          ),
          // backgroundColor: Color(0xff3d31dd),
          body: Stack(
            children: [
              Container(
                height: 100,
                color: Color(0xff3d31dd),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xfff9faf7),
                    // borderRadius: BorderRadius.all(Radius.circular(25))
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
                ),
                child: const TabBarView(
                  children: <Widget>[
                    SalasPage(),
                    MenuSemanal(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xff3d31dd),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              labelPadding: EdgeInsets.zero,
              // padding: EdgeInsets.all(10),
              indicator: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(10))
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(10),
                //   topRight: Radius.circular(10),
                // ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                    child: Center(child: Text('Minhas Salas', style: TextStyle(color: Colors.white))),
                  ),
                  // icon: Icon(FontAwesomeIcons.house),
                ),
                Tab(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    ),
                    child: Center(child: Text('Minhas Reservas', style: TextStyle(color: Colors.white))),
                  ),
                  // icon: Icon(FontAwesomeIcons.ticket),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return DefaultTabController(
    //   initialIndex: 0,
    //   length: 2,
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('SalasUfs'),
    //         backgroundColor: Color(0xff3d31dd),
    //         bottom: TabBar(
    //           dividerColor: Colors.transparent,
    //           labelPadding: EdgeInsets.zero,
    //           indicator: const BoxDecoration(
    //             color: Colors.lightBlue,
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(10),
    //               topRight: Radius.circular(10),
    //             ),
    //           ),
    //           indicatorSize: TabBarIndicatorSize.tab,
    //           tabs: <Widget>[
    //             Tab(
    //               child: Container(
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //                 ),
    //                 child: Center(child: Text('Minhas Salas')),
    //               ),
    //             ),
    //             Tab(
    //               child: Container(
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //                 ),
    //                 child: Center(child: Text('Minhas Reservas')),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       body: Container(
    //         color: const Color(0xfff9faf7), // Colors.grey.shade200,
    //         child: const TabBarView(
    //           children: <Widget>[
    //             SalasPage(),
    //             MenuSemanal(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
