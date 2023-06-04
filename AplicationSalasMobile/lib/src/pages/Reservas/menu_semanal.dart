import 'package:aplicationsalasmobile/src/pages/Reservas/circle_dayweek.dart';
import 'package:aplicationsalasmobile/src/pages/Reservas/reservas_page.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSemanal extends StatefulWidget {
  const MenuSemanal({Key? key}) : super(key: key);

  @override
  State<MenuSemanal> createState() => _MenuSemanalState();
}

class _MenuSemanalState extends State<MenuSemanal> with SingleTickerProviderStateMixin {
  late TabController _nestedTabController;
  late SalaProvider salaProvider;
  late int active = DateTime.now().weekday - 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    salaProvider = Provider.of<SalaProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 7, vsync: this, initialIndex: DateTime.now().weekday - 1);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: CircleDayWeek(day: "S", cor: Colors.lightBlue),
                          onTap: () {
                            active = 0;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "T"),
                          onTap: () {
                            active = 1;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "Q"),
                          onTap: () {
                            active = 2;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "Q"),
                          onTap: () {
                            active = 3;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "S"),
                          onTap: () {
                            active = 4;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "S"),
                          onTap: () {
                            active = 5;
                            setState(() { });
                          },
                        ),
                        InkWell(
                          child: CircleDayWeek(day: "D"),
                          onTap: () {
                            active = 6;
                            setState(() { });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              height: screenHeight,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(5),
              child:
              (active==0)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'seg')
              :(active==1)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'ter')
              :(active==2)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'qua')
              :(active==3)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'qui')
              :(active==4)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'sex')
              :(active==5)
                ?ReservasPage(salaProvider: salaProvider, filtroDia: 'sab')
                :ReservasPage(salaProvider: salaProvider, filtroDia: 'dom')
          ),
        ],
      ),
    );
    // return Scaffold(
    //   // backgroundColor: const Color(0xff3d31dd),
    //   // appBar: TabBar(
    //   //   controller: _nestedTabController,
    //   //   indicatorColor: Colors.white,
    //   //   labelColor: Colors.white,
    //   //   unselectedLabelColor: Colors.white, //Colors.black54,
    //   //   isScrollable: true,
    //   //   // splashBorderRadius: BorderRadius.circular(50),
    //   //   indicator: BoxDecoration( // indivodual
    //   //     color: Colors.lightBlue,
    //   //     borderRadius: BorderRadius.circular(10),
    //   //   ),
    //   //   tabs: <Widget>[
    //   //     Tab(
    //   //       text: "SEG",
    //   //     ),
    //   //     Tab(
    //   //       text: "TER",
    //   //     ),
    //   //     Tab(
    //   //       text: "QUA",
    //   //     ),
    //   //     Tab(
    //   //       text: "QUI",
    //   //     ),
    //   //     Tab(
    //   //       text: "SEX",
    //   //     ),
    //   //     Tab(
    //   //       // text: "SÁB",
    //   //       child: Container(
    //   //         margin: EdgeInsets.all(10),
    //   //         height: 50,
    //   //         decoration: BoxDecoration(
    //   //           // color: Colors.red,
    //   //             borderRadius: BorderRadius.circular(100)
    //   //         ),
    //   //         child: Align(
    //   //           alignment: Alignment.center,
    //   //           child: Text("S"),
    //   //         ),
    //   //       ),
    //   //     ),
    //   //     Tab(
    //   //       text: "DOM",
    //   //     ),
    //   //   ],
    //   // ),
    //   body: Stack(
    //     children: [
    //       Container(
    //         height: 100,
    //         color: Color(0xff3d31dd),
    //       ),
    //       Container(
    //         decoration: const BoxDecoration(
    //             color: Color(0xfff9faf7),
    //             // borderRadius: BorderRadius.all(Radius.circular(25))
    //             borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(20),
    //               topLeft: Radius.circular(20),
    //             )
    //         ),
    //         child: TabBarView(
    //           controller: _nestedTabController,
    //           children: <Widget>[
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'seg',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'ter',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'qua',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'qui',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'sex',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'sab',),
    //             ReservasPage(salaProvider: salaProvider, filtroDia: 'dom',),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // body: Column(
    //   mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       TabBar(
    //         controller: _nestedTabController,
    //         indicatorColor: Colors.blue,
    //         labelColor: Colors.blue,
    //         unselectedLabelColor: Colors.black54,
    //         isScrollable: true,
    //         tabs: const <Widget>[
    //           Tab(
    //             text: "SEG",
    //           ),
    //           Tab(
    //             text: "TER",
    //           ),
    //           Tab(
    //             text: "QUA",
    //           ),
    //           Tab(
    //             text: "QUI",
    //           ),
    //           Tab(
    //             text: "SEX",
    //           ),
    //           Tab(
    //             text: "SÁB",
    //           ),
    //           Tab(
    //             text: "DOM",
    //           ),
    //         ],
    //       ),
    //       SingleChildScrollView(
    //         child: SizedBox(
    //           height: screenHeight,
    //           // margin: EdgeInsets.only(left: 16.0, right: 16.0),
    //           child: TabBarView(
    //             controller: _nestedTabController,
    //             children: <Widget>[
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'seg',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'ter',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'qua',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'qui',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'sex',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'sab',),
    //               ReservasPage(salaProvider: salaProvider, filtroDia: 'dom',),
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    // ),
    //);
  }
}
