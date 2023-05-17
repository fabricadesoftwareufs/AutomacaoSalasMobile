import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/switch_widget.dart';
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
  FToast fToast = FToast();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fToast.init(context);
  }

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
              children: [
                Text(widget.salasUsuario.salaModel.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Text(widget.salasUsuario.blocoModel.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
              ],
            ),
            SwitchWidget(
              titulo: "Luzes",
              monitoramentoLuzesModel: widget.salasUsuario.monitoramentoLuzesModel,
              monitoramentoCondicionadoresModel: widget.salasUsuario.monitoramentoCondicionadoresModel,
              salaProvider: widget.salaProvider,
              token: widget.token,
              fToast: fToast,
            ),
            SwitchWidget(
              titulo: "Ar Condicionado",
              monitoramentoLuzesModel: widget.salasUsuario.monitoramentoLuzesModel,
              monitoramentoCondicionadoresModel: widget.salasUsuario.monitoramentoCondicionadoresModel,
              salaProvider: widget.salaProvider,
              token: widget.token,
              fToast: fToast,
            ),
          ],
        ),
      ),
    );
  }
}
