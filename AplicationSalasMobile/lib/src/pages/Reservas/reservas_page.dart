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
      // getReservasDia();
      inicializado = true;
      // setState(() {});
    }
  }

  Future<List<ReservaUsuarioResponseModel>> getReservasDia() async {
    await verify().then((value) => authResponseModel = value);
    return await reservaProvider!.reservasUsuario(widget.filtroDia, authResponseModel.id);
  }

  Future<void> refreshReservas() async {
    await getReservasDia();
  }

  @override
  Widget build(BuildContext context) {
    print("restatou");
    return Container(
      // color: Colors.grey.shade200,
      // alignment: Alignment.center,
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Container(alignment: Alignment.center, padding: EdgeInsets.only(top: 20),child: CircularProgressIndicator(color: Color(0xff277ebe))));
                }
                if (snapshot.hasError) return const Center(child: Text("Erro ao carregar"));

                List<ReservaUsuarioResponseModel> listaReservasUsuario = snapshot.data as List<ReservaUsuarioResponseModel>;

                return (listaReservasUsuario.isEmpty)
                    ?Container(padding: EdgeInsets.all(20), child: Empty_Widget(titulo: 'Sem reservas', descricao: 'Você não possui reservas para este dia!'))
                    :Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    ...listaReservasUsuario
                    .map((e) => CardInfoReserva(
                  reservasUsuario: e,
                  salaProvider: widget.salaProvider,
                  reservaProvider: reservaProvider!,
                  token: authResponseModel.token,
                  fToast: fToast, altereEstado: (void value) => setState(() { listaReservasUsuario.remove(e);}),
                  ))
                  .toList()
                  ],
                );
                // return Consumer<ReservaProvider>(
                //   builder: (context, reservaProvider, child) {
                //     if(reservaProvider.listaReservasUsuario.isEmpty) {
                //       return Empty_Widget(titulo: 'Sem reservas', descricao: 'Você ainda não tem reservas para este dia!');
                //     }
                //     return Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         ...reservaProvider.listaReservasUsuario
                //             .map((e) => CardInfoReserva(
                //           reservasUsuario: e,
                //           salaProvider: widget.salaProvider,
                //           reservaProvider: reservaProvider,
                //           token: authResponseModel.token,
                //           fToast: fToast,
                //         ))
                //             .toList()
                //       ],
                //     );
                //   },
                // );
              }
            ),
          ]
        ),
      ),
    );
  }
}
