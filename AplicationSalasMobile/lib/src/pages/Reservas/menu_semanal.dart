import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/Reservas/reservas_page.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';

class MenuSemanal extends StatefulWidget {
  int idUsuario;
  SalaProvider salaProvider;
  AuthResponseModel authResponseModel;
  MenuSemanal({Key? key, required this.idUsuario, required this.salaProvider, required this.authResponseModel}) : super(key: key);

  @override
  State<MenuSemanal> createState() => _MenuSemanalState();
}

class _MenuSemanalState extends State<MenuSemanal> with SingleTickerProviderStateMixin {
  late TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
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
          Container(
            height: screenHeight * 0.70,
            // margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'seg',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'ter',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'qua',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'qui',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'sex',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'sab',),
                ReservasPage(idUsuario: widget.idUsuario, salaProvider: widget.salaProvider, authResponseModel: widget.authResponseModel, filtroDia: 'dom',),
              ],
            ),
          )
        ],
    );
  }
}
