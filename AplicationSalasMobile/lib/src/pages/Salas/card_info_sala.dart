import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/switch_widget.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardInfoSala extends StatefulWidget {
  final SalasUsuarioResponseModel salasUsuario;
  final SalaProvider salaProvider;
  final String token;

  const CardInfoSala(
      {Key? key, required this.salasUsuario, required this.token, required this.salaProvider})
      : super(key: key);

  @override
  State<CardInfoSala> createState() => _CardInfoSalaState();
}

class _CardInfoSalaState extends State<CardInfoSala> {
  late MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel.empty();
  FToast fToast = FToast();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fToast.init(context);
  }

  monitorarLuzesSala() {
    monitoraSala = MonitorarSalaRequestModel(
      id: widget.salasUsuario.monitoramentoLuzesModel.id,
      equipamentoId: widget.salasUsuario.monitoramentoLuzesModel.equipamentoId,
      estado: widget.salasUsuario.monitoramentoCondicionadoresModel.estado,
      salaId: widget.salasUsuario.monitoramentoLuzesModel.equipamentoNavigationModel.sala,
      salaParticula: widget.salasUsuario.monitoramentoLuzesModel.salaParticular
    );
  }

  monitorarCondicionadoresSala() {
    monitoraSala = MonitorarSalaRequestModel(
      id: widget.salasUsuario.monitoramentoCondicionadoresModel.id,
      equipamentoId: widget.salasUsuario.monitoramentoCondicionadoresModel.equipamentoId,
      estado: widget.salasUsuario.monitoramentoCondicionadoresModel.estado,
      salaId: widget.salasUsuario.monitoramentoCondicionadoresModel.equipamentoNavigationModel.sala,
      salaParticula: widget.salasUsuario.monitoramentoCondicionadoresModel.salaParticular
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.salasUsuario.salaModel.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(widget.salasUsuario.blocoModel.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
              ],
            ),
            SwitchWidget(
              titulo: "Luzes",
              estadoDispositivo: widget.salasUsuario.monitoramentoLuzesModel.estado,
              selecionadoChanged: (value) async {
                monitorarLuzesSala();

                await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
                  if(valueRequest.statusCode == 200) { // if(valueRequest == "Monitoramento realizado com sucesso!") {
                    setState(() => widget.salasUsuario.monitoramentoLuzesModel.estado = value);
                    return showCustomToast(fToast: fToast, titulo: valueRequest.mensagem, cor: const Color(0xff31cdba));
                  }
                  return showCustomToast(fToast: fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
                });
              }
            ),
            SwitchWidget(
              titulo: "Ar-Condicionado",
              estadoDispositivo: widget.salasUsuario.monitoramentoCondicionadoresModel.estado,
              selecionadoChanged: (value) async {
                monitorarCondicionadoresSala();

                await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
                  if(valueRequest.statusCode == 200) {
                    setState(() => widget.salasUsuario.monitoramentoLuzesModel.estado = value);
                    return showCustomToast(fToast: fToast, titulo: valueRequest.mensagem, cor: const Color(0xff31cdba));
                  }
                  return showCustomToast(fToast: fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
                });
              }
            ),
          ],
        ),
      ),
    );
  }
}

