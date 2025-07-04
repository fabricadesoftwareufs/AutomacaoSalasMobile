import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/models/salas_usuario_response_model.dart';
import 'package:salas_mobile/src/pages/Salas/card_info_sala.dart';
import 'package:salas_mobile/src/pages/shared/widgets/empty_widget.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SalasPage extends StatefulWidget {
  final AuthResponseModel auth;
  const SalasPage({super.key, required this.auth});

  @override
  State<SalasPage> createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  SalaProvider? salaProvider;
  late List<AuthResponseModel> listaSalasUsuario = [];
  late String token = '';

  FToast fToast = FToast();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fToast.init(context);
    salaProvider ??= Provider.of<SalaProvider>(context, listen: false);
  }

  Future<AuthResponseModel?> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return await authLocalDatasource.getCurrentUser();
  }

  Future<void> refreshSalas() async {
    await verify().then((value) => salaProvider!.salasUsuario(value!.id));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.primary,
      onRefresh: ()async{
        setState(() {});
      },
      child: ListView(
          children: [
            FutureBuilder(
                future: verify().then((value) {
                  return salaProvider!.salasUsuario(value!.id);
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(
                      "Erro ao carregar",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ));
                  }

                  List<SalasUsuarioResponseModel> salasUsuario = snapshot.data as List<SalasUsuarioResponseModel>;

                  return (salasUsuario.isEmpty)
                      ? Empty_Widget(titulo: 'Sem salas', descricao: 'Você ainda não tem salas cadastradas!')
                      : SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          for (int i = 0; i < salasUsuario.length; i++)
                            ...[
                              CardInfoSala(salasUsuario: salasUsuario[i], salaProvider: salaProvider!, token: widget.auth.token),
                            ]
                        ],
                      ),
                    ),
                  );
                }
            ),
          ]
      ),
    );
  }
}