import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/switch_widget.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:aplicationsalasmobile/src/providers/reserva_provider.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardInfoReserva extends StatefulWidget {
  final ReservaUsuarioResponseModel reservasUsuario;
  final ReservaProvider reservaProvider;
  final SalaProvider salaProvider;
  final String token;
  final FToast fToast;

  const CardInfoReserva({Key? key,
    required this.reservasUsuario,
    required this.reservaProvider,
    required this.salaProvider,
    required this.fToast,
    required this.token})
      : super(key: key);

  @override
  State<CardInfoReserva> createState() => _CardInfoReservaState();
}

class _CardInfoReservaState extends State<CardInfoReserva> {
  late MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel.empty();

  monitorarLuzesSala() {
    monitoraSala = MonitorarSalaRequestModel(
      id: widget.reservasUsuario.monitoramentoLuzes.id,
      equipamentoId: widget.reservasUsuario.monitoramentoLuzes.equipamentoId,
      estado: widget.reservasUsuario.monitoramentoLuzes.estado,
      salaId: widget.reservasUsuario.monitoramentoLuzes.equipamentoNavigationModel.sala,
      salaParticula: widget.reservasUsuario.monitoramentoLuzes.salaParticular
    );
  }

  monitorarCondicionadoresSala() {
    monitoraSala = MonitorarSalaRequestModel(
      id: widget.reservasUsuario.monitoramentoCondicionadores.id,
      equipamentoId: widget.reservasUsuario.monitoramentoCondicionadores.equipamentoId,
      estado: widget.reservasUsuario.monitoramentoCondicionadores.estado,
      salaId: widget.reservasUsuario.monitoramentoCondicionadores.equipamentoNavigationModel.sala,
      salaParticula: widget.reservasUsuario.monitoramentoCondicionadores.salaParticular
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.blue.shade100,
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              stops: [0.02, 0.02],
              colors: [Color(0xff277ebe), Colors.white]
          ),
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color(0xffffffff),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${widget.reservasUsuario.sala.titulo}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    Text("${widget.reservasUsuario.bloco.titulo}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    // Text(
                    //     "${widget.reservasUsuario.horarioSala.horario_inicial.substring(0, 5)} às ${widget.reservasUsuario
                    //         .horarioSala.horario_final.substring(0, 5)}",
                    //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    // const SizedBox(height: 2),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.red,
                    //   ),
                    //   onPressed: () async {
                    //     await widget.reservaProvider
                    //         .cancelarReservaUsuario(widget.reservasUsuario.horarioSala.id)
                    //         .then((value) =>
                    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //             content: Text(
                    //               value,
                    //               textAlign: TextAlign.center,
                    //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //             ),
                    //             backgroundColor: Colors.green)));
                    //   },
                    //   child: const Text(
                    //     'Cancelar',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // )
                  ],
                ),
                SwitchWidget(
                  titulo: "Luzes",
                  estadoDispositivo: widget.reservasUsuario.monitoramentoLuzes.estado,
                  selecionadoChanged: (value) async {
                    monitorarLuzesSala();

                    await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
                      if(valueRequest.statusCode == 200) {
                        setState(() => widget.reservasUsuario.monitoramentoLuzes.estado = value);
                        return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: const Color(0xff31cdba));
                      }
                      return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
                    });
                  }
                  // monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
                  // monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
                  // salaProvider: widget.salaProvider,
                  // token: widget.token,
                  // fToast: widget.fToast,
                ),
                SwitchWidget(
                  titulo: "Ar-Condicionado",
                  estadoDispositivo: widget.reservasUsuario.monitoramentoCondicionadores.estado,
                  selecionadoChanged: (value) async {
                    monitorarCondicionadoresSala();

                    await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
                      if(valueRequest.statusCode == 200) {
                        setState(() => widget.reservasUsuario.monitoramentoCondicionadores.estado = value);
                        return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: const Color(0xff31cdba));
                      }
                      return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
                    });
                  }
                  // monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
                  // monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
                  // salaProvider: widget.salaProvider,
                  // token: widget.token,
                  // fToast: widget.fToast,
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${widget.reservasUsuario.horarioSala.horario_inicial.substring(0, 5)} h - ${widget.reservasUsuario
                        .horarioSala.horario_final.substring(0, 5)} h",
                    style: const TextStyle(fontSize: 17)),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
                  ),
                  // style: TextButton.styleFrom(
                  //   backgroundColor: Colors.red.shade400,
                  // ),
                  onPressed: () async {
                    await widget.reservaProvider
                        .cancelarReservaUsuario(widget.reservasUsuario.horarioSala.id)
                        .then((value) {
                          if(value.statusCode == 200) {
                            return showCustomToast(fToast: widget.fToast, titulo: value.mensagem, cor: const Color(0xff31cdba));
                          }
                          return showCustomToast(fToast: widget.fToast, titulo: value.mensagem, cor: Colors.red.shade400);
                        }
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text(
                        //       value,
                        //       textAlign: TextAlign.center,
                        //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        //     ),
                        //     backgroundColor: Colors.green))
                    );
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
