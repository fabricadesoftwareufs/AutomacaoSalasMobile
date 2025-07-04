import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/models/reserva_usuario_response_model.dart';
import 'package:salas_mobile/src/pages/Reservas/card_info_reserva.dart';
import 'package:salas_mobile/src/pages/shared/widgets/empty_widget.dart';
import 'package:salas_mobile/src/providers/reserva_provider.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReservasPage extends StatefulWidget {
  final SalaProvider salaProvider;
  final String filtroDia;

  const ReservasPage({super.key, required this.salaProvider, required this.filtroDia});

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
      inicializado = true;
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
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: RefreshIndicator(
        color: Theme.of(context).colorScheme.primary,
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
            shrinkWrap: true,
            children: [
              FutureBuilder(
                  future: getReservasDia(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary
                              )
                          )
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              "Erro ao carregar",
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)
                          )
                      );
                    }

                    List<ReservaUsuarioResponseModel> listaReservasUsuario = snapshot.data as List<ReservaUsuarioResponseModel>;

                    return (listaReservasUsuario.isEmpty)
                        ? Container(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sem reservas',
                              style: TextStyle(
                                fontSize: 21,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Você não possui reservas para este dia!',
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...listaReservasUsuario
                            .map((e) => CardInfoReserva(
                          reservasUsuario: e,
                          salaProvider: widget.salaProvider,
                          reservaProvider: reservaProvider!,
                          token: authResponseModel.token,
                          fToast: fToast,
                          altereEstado: (void value) => setState(() {
                            listaReservasUsuario.remove(e);
                          }),
                        ))
                      ],
                    );
                  }
              ),
            ]
        ),
      ),
    );
  }
}