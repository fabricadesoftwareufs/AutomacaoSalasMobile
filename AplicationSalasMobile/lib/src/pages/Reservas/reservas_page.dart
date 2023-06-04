import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/Reservas/card_info_reserva.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/empty_widget.dart';
import 'package:aplicationsalasmobile/src/providers/reserva_provider.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReservasPage extends StatefulWidget {
  final SalaProvider salaProvider;
  final String filtroDia;

  const ReservasPage({Key? key, required this.salaProvider, required this.filtroDia}) : super(key: key);

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  late AuthResponseModel authResponseModel = AuthResponseModel.empty();
  ReservaProvider? reservaProvider;
  late List<ReservaUsuarioResponseModel> listaReservasUsuario = [];
  bool inicializado = false;
  FToast fToast = FToast();


  late final Future getReservas;

  Future<AuthResponseModel> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return await authLocalDatasource.getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reservaProvider ??= Provider.of<ReservaProvider>(context, listen: false);
    if (inicializado == false) {
      fToast.init(context);
      inicializado = true;
    }
  }

  Future<void> getReservasDia() async {
    await verify().then((value) => authResponseModel = value);
    await reservaProvider!.reservasUsuario(widget.filtroDia, authResponseModel.id);
  }

  Future<void> refreshReservas() async {
    // await getReservas(widget.filtroDia, authResponseModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: RefreshIndicator(
        color: Theme.of(context).colorScheme.secondary,
        onRefresh: ()async{
          setState(() {});
          // refreshReservas();
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            FutureBuilder(
              future: getReservasDia(),
              builder: (context, snapshot) {
                return Consumer<ReservaProvider>(
                  builder: (context, reservaProvider, child) {
                    if(reservaProvider.listaReservasUsuario.isEmpty) {
                      return Container(padding: const EdgeInsets.only(bottom: 50), child: Empty_Widget(titulo: 'Sem reservas', descricao: 'Você ainda não tem reservas para este dia!'));
                    }
                    return Column(
                      children: [
                        ...reservaProvider.listaReservasUsuario
                            .map((e) => CardInfoReserva(
                          reservasUsuario: e,
                          salaProvider: widget.salaProvider,
                          reservaProvider: reservaProvider,
                          token: authResponseModel.token,
                          fToast: fToast,
                        ))
                            .toList()
                      ],
                    );
                  },
                );
              }
            ),
          ]
        ),
      ),
    );
  }
}
