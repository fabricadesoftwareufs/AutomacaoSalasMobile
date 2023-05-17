import 'package:aplicationsalasmobile/src/models/monitoramento_condicionadores_model.dart';
import 'package:aplicationsalasmobile/src/models/monitoramento_luzes_model.dart';
import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SwitchWidget extends StatefulWidget {
  MonitoramentoLuzesModel monitoramentoLuzesModel;
  MonitoramentoCondicionadoresModel monitoramentoCondicionadoresModel;
  final SalaProvider salaProvider;
  final String titulo;
  final String token;
  FToast fToast;

  SwitchWidget(
      {Key? key,
       required this.fToast,
      required this.titulo,
      required this.monitoramentoLuzesModel,
      required this.monitoramentoCondicionadoresModel,
      required this.salaProvider,
      required this.token})
      : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late MonitorarSalaRequestModel monitoraSala;


  monitorarLuzesSala(bool value) {
    monitoraSala = MonitorarSalaRequestModel(
        id: widget.monitoramentoLuzesModel.id,
        equipamentoId: widget.monitoramentoLuzesModel.equipamentoId,
        estado: value,
        salaId: widget.monitoramentoLuzesModel.equipamentoNavigationModel.sala,
        salaParticula: widget.monitoramentoLuzesModel.estado);
    widget.monitoramentoLuzesModel.estado = value;
  }

  monitorarCondicionadoresSala(bool value) {
    monitoraSala = MonitorarSalaRequestModel(
        id: widget.monitoramentoCondicionadoresModel.id,
        equipamentoId: widget.monitoramentoCondicionadoresModel.equipamentoId,
        estado: value,
        salaId: widget.monitoramentoCondicionadoresModel.equipamentoNavigationModel.sala,
        salaParticula: widget.monitoramentoCondicionadoresModel.estado);
    widget.monitoramentoCondicionadoresModel.estado = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
        Switch(
          value: (widget.titulo == "Luzes")
              ? widget.monitoramentoLuzesModel.estado
              : widget.monitoramentoCondicionadoresModel.estado,
          activeColor: Colors.white,
          activeTrackColor: Colors.green,
          onChanged: (value) async {
            (widget.titulo == "Luzes") ? monitorarLuzesSala(value) : monitorarCondicionadoresSala(value);

            await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((value) {
              return (value == "Monitoramento realizado com sucesso!")
                  ? showCustomToast(fToast: widget.fToast, titulo: value, cor: Colors.green.shade400)
                  : showCustomToast(fToast: widget.fToast, titulo: value, cor: Colors.red.shade400);
            });

            setState(() {});
          },
        ),
      ],
    );
  }
}
