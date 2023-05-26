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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    salaProvider = Provider.of<SalaProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 7, vsync: this, initialIndex: DateTime.now().weekday-1);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: TabBar(
        controller: _nestedTabController,
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black54,
        isScrollable: true,
        tabs: const <Widget>[
          Tab(
            text: "SEG",
          ),
          Tab(
            text: "TER",
          ),
          Tab(
            text: "QUA",
          ),
          Tab(
            text: "QUI",
          ),
          Tab(
            text: "SEX",
          ),
          Tab(
            text: "SÁB",
          ),
          Tab(
            text: "DOM",
          ),
        ],
      ),
      body: TabBarView(
        controller: _nestedTabController,
        children: <Widget>[
          ReservasPage(salaProvider: salaProvider, filtroDia: 'seg',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'ter',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'qua',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'qui',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'sex',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'sab',),
          ReservasPage(salaProvider: salaProvider, filtroDia: 'dom',),
        ],
      ),
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
    );
  }
}
