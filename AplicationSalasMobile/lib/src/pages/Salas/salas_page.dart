import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/Salas/card_info_sala.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/empty_widget.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SalasPage extends StatefulWidget {
  const SalasPage({Key? key}) : super(key: key);

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
    await verify();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 200 ,
      color: Theme.of(context).colorScheme.secondary,
      onRefresh: ()async{
        print("a");
      },
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      strokeWidth: 2,
      child: FutureBuilder(
        future: verify().then((value) => salaProvider!.salasUsuario(value!.id)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return const Center(child: Text("Erro ao carregar"));

          List<SalasUsuarioResponseModel> salasUsuario = snapshot.data as List<SalasUsuarioResponseModel>;

          return (salasUsuario.isEmpty)
            ?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Empty_Widget(titulo: 'Sem salas', descricao: 'Você ainda não tem salas cadastradas!'),
              ],
            )
            :SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    for (int i = 0; i < salasUsuario.length; i++)
                      CardInfoSala(salasUsuario: salasUsuario[i], salaProvider: salaProvider!, token: token),
                  ],
                ),
              ),
            );
        }
      ),
    );
  }
}