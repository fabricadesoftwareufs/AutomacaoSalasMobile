import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/providers/reserva_provider.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservasPage extends StatefulWidget {
  int idUsuario;
  SalaProvider salaProvider;
  AuthResponseModel authResponseModel;
  String filtroDia;
  ReservasPage({Key? key, required this.idUsuario, required this.salaProvider, required this.authResponseModel, required this.filtroDia}) : super(key: key);

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  late ReservaProvider reservaProvider;
  late List<ReservaUsuarioResponseModel> listaReservasUsuario = [];
  bool inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!inicializado) {
      reservaProvider = Provider.of<ReservaProvider>(context, listen: false);

      inicializado = true;
    }
  }

  Future<List<ReservaUsuarioResponseModel>?> verify(String diaSemana, int idUsuario) async {
    return await reservaProvider.reservasUsuario(diaSemana, idUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: verify(widget.filtroDia, widget.idUsuario),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if(snapshot.data == null){
            return Container(
              child: Text("Lista Vazia"),
            );
          }
          if (snapshot.hasError) return const Center(child: Text("Erro ao carregar"));

          listaReservasUsuario = snapshot.data as List<ReservaUsuarioResponseModel>;
          return Column(
            children: [
              for (int i = 0; i < listaReservasUsuario.length; i++)
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${listaReservasUsuario[i].sala.titulo} / ${listaReservasUsuario[i].bloco.titulo}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            Text("${listaReservasUsuario[i].horarioSala.horario_inicial.substring(0,5)} às ${listaReservasUsuario[i].horarioSala.horario_final.substring(0,5)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            SizedBox(height: 2),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await reservaProvider.cancelarReservaUsuario(listaReservasUsuario[i].horarioSala.id).then((value) =>
                                    ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), backgroundColor: Colors.green))
                                );
                              },
                              child: Text('Cancelar', style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Luzes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                            Switch(
                              value: listaReservasUsuario[i].monitoramentoLuzes.estado,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              onChanged: (value) async {
                                MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel(id: listaReservasUsuario[i].monitoramentoLuzes.id, equipamentoId: listaReservasUsuario[i].monitoramentoLuzes.equipamentoId, estado: value, salaId: listaReservasUsuario[i].monitoramentoLuzes.equipamentoNavigationModel.sala, salaParticula: listaReservasUsuario[i].monitoramentoLuzes.estado);
                                await widget.salaProvider.putMonitorarSala(monitoraSala, widget.authResponseModel.token).then((value) {
                                  return ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), backgroundColor: (value == "Monitoramento realizado com sucesso!")?Colors.green:Colors.red));
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Ar Condicionado", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),),
                            Switch(
                              value: listaReservasUsuario[i].monitoramentoCondicionadores.estado,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              splashRadius: 50.0,
                              onChanged: (value) async {
                                MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel(id: listaReservasUsuario[i].monitoramentoLuzes.id, equipamentoId: listaReservasUsuario[i].monitoramentoLuzes.equipamentoId, estado: value, salaId: listaReservasUsuario[i].monitoramentoLuzes.equipamentoNavigationModel.sala, salaParticula: listaReservasUsuario[i].monitoramentoLuzes.estado);
                                await widget.salaProvider.putMonitorarSala(monitoraSala, widget.authResponseModel.token).then((value) {
                                  return ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              value, textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                          ),
                                          backgroundColor: (value == "Monitoramento realizado com sucesso!")?Colors.green:Colors.red));
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
            ],
          );
        }
      ),
    );
  }
}
