import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/pages/Reservas/menu_semanal.dart';
import 'package:salas_mobile/src/pages/Salas/salas_page.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Color(0xff277ebe),
        appBar: AppBar(
          centerTitle: false,
          title: const Text('SalasUfs', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff277ebe),// Color(0xff3d31dd),
          elevation: 0,
          shadowColor: Colors.red,
        ),
        // backgroundColor: Color(0xff3d31dd),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: Color(0xff277ebe),
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
              child: TabBarView(
                children: <Widget>[
                  SalasPage(auth: widget.auth),
                  MenuSemanal(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          // padding: EdgeInsets.all(10),
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey.shade500,//Color(0xff3d31dd),
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            // padding: EdgeInsets.all(10),
            indicator: const BoxDecoration(
              color: Color(0xff277ebe),//Colors.lightBlue,
              // borderRadius: BorderRadius.all(Radius.circular(10))
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(10),
              //   topRight: Radius.circular(10),
              // ),
            ),
            unselectedLabelColor: Colors.black38,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                child: Container(
                  // decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  // ),
                  child: Center(child: Text('Minhas Salas', style: TextStyle(color: Colors.white))),
                ),
                // icon: Icon(FontAwesomeIcons.house),
              ),
              Tab(
                child: Container(
                  // decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  // ),
                  child: Center(child: Text('Minhas Reservas', style: TextStyle(color: Colors.white))),
                ),
                // icon: Icon(FontAwesomeIcons.ticket),
              ),
            ],
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
