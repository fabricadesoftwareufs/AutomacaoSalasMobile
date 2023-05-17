import 'package:aplicationsalasmobile/src/models/reserva_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/switch_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.reservasUsuario.sala.titulo} / ${widget.reservasUsuario.bloco.titulo}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(
                    "${widget.reservasUsuario.horarioSala.horario_inicial.substring(0, 5)} às ${widget.reservasUsuario
                        .horarioSala.horario_final.substring(0, 5)}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 2),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    await widget.reservaProvider
                        .cancelarReservaUsuario(widget.reservasUsuario.horarioSala.id)
                        .then((value) =>
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Colors.green)));
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            SwitchWidget(
              titulo: "Luzes",
              monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
              monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
              salaProvider: widget.salaProvider,
              token: widget.token,
              fToast: widget.fToast,
            ),
            SwitchWidget(
              titulo: "Ar Condicionado",
              monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
              monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
              salaProvider: widget.salaProvider,
              token: widget.token,
              fToast: widget.fToast,
            ),
          ],
        ),
      ),
    );
  }
}
