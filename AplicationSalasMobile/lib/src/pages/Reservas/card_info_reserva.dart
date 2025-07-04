import 'package:salas_mobile/src/models/monitorar_sala_request_model.dart';
import 'package:salas_mobile/src/models/reserva_usuario_response_model.dart';
import 'package:salas_mobile/src/pages/shared/widgets/switch_widget.dart';
import 'package:salas_mobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:salas_mobile/src/providers/reserva_provider.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardInfoReserva extends StatefulWidget {
  late ReservaUsuarioResponseModel reservasUsuario;
  final ReservaProvider reservaProvider;
  final SalaProvider salaProvider;
  final String token;
  final FToast fToast;
  final ValueChanged<ReservaUsuarioResponseModel> altereEstado;

  CardInfoReserva({super.key,
    required this.reservasUsuario,
    required this.reservaProvider,
    required this.salaProvider,
    required this.fToast,
    required this.token,
    required this.altereEstado});

  @override
  State<CardInfoReserva> createState() => _CardInfoReservaState();
}

class _CardInfoReservaState extends State<CardInfoReserva> {
  late MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel.empty();

  // Getter para verificar se a reserva está cancelada baseado no status real
  bool get isReservaCancelada => widget.reservasUsuario.horarioSala.status == "CANCELADA";

  monitorarLuzesSala() {
    monitoraSala = MonitorarSalaRequestModel(
        id: widget.reservasUsuario.monitoramentoLuzes.id,
        equipamentoId: widget.reservasUsuario.monitoramentoLuzes.idEquipamento,
        estado: widget.reservasUsuario.monitoramentoLuzes.estado,
        salaId: widget.reservasUsuario.monitoramentoLuzes.equipamentoNavigationModel.sala,
        salaParticula: widget.reservasUsuario.monitoramentoLuzes.salaParticular
    );
  }

  monitorarCondicionadoresSala() {
    monitoraSala = MonitorarSalaRequestModel(
        id: widget.reservasUsuario.monitoramentoCondicionadores.id,
        equipamentoId: widget.reservasUsuario.monitoramentoCondicionadores.idEquipamento,
        estado: widget.reservasUsuario.monitoramentoCondicionadores.estado,
        salaId: widget.reservasUsuario.monitoramentoCondicionadores.equipamentoNavigationModel.sala,
        salaParticula: widget.reservasUsuario.monitoramentoCondicionadores.salaParticular
    );
  }

  Future<void> alternarReserva() async {
    if (isReservaCancelada) {
      final response = await widget.reservaProvider.aprovarReservaUsuario(widget.reservasUsuario.horarioSala.id);
      if (response.statusCode == 200) {
        widget.altereEstado(widget.reservasUsuario);
        showCustomToast(fToast: widget.fToast, titulo: response.mensagem, cor: const Color(0xff277ebe));
      } else {
        showCustomToast(fToast: widget.fToast, titulo: response.mensagem, cor: Colors.red.shade400);
      }
    } else {
      final response = await widget.reservaProvider.cancelarReservaUsuario(widget.reservasUsuario.horarioSala.id);
      if (response.statusCode == 200) {
        widget.altereEstado(widget.reservasUsuario);
        showCustomToast(fToast: widget.fToast, titulo: response.mensagem, cor: const Color(0xff31cdba));
      } else {
        showCustomToast(fToast: widget.fToast, titulo: response.mensagem, cor: Colors.red.shade400);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.shade800
          : Colors.blue.shade100,
      margin: const EdgeInsets.all(8),
      color: Theme.of(context).cardColor,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).cardColor
              ]
          ),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).cardColor,
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
                    Text(widget.reservasUsuario.sala.titulo,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onSurface
                        )),
                    Text(widget.reservasUsuario.bloco.titulo,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onSurface
                        )),
                  ],
                ),
                // Condicionalmente exibe os switches apenas quando a reserva não está cancelada
                if (!isReservaCancelada) ...[
                  SwitchWidget(
                    titulo: "Luzes",
                    monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
                    monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
                    salaProvider: widget.salaProvider,
                    token: widget.token,
                    fToast: widget.fToast,
                  ),
                  SwitchWidget(
                    titulo: "Ar-Condicionado",
                    monitoramentoLuzesModel: widget.reservasUsuario.monitoramentoLuzes,
                    monitoramentoCondicionadoresModel: widget.reservasUsuario.monitoramentoCondicionadores,
                    salaProvider: widget.salaProvider,
                    token: widget.token,
                    fToast: widget.fToast,
                  ),
                ],
              ],
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${widget.reservasUsuario.horarioSala.horario_inicial.substring(0, 5)} h - ${widget.reservasUsuario
                        .horarioSala.horario_final.substring(0, 5)} h",
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onSurface
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: isReservaCancelada ? Colors.blue.shade400 : Colors.red.shade400,
                  ),
                  onPressed: alternarReserva,
                  child: Text(
                    isReservaCancelada ? 'Ativar' : 'Cancelar',
                    style: const TextStyle(color: Colors.white),
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