import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/models/monitoramento_condicionadores_model.dart';
import 'package:salas_mobile/src/models/monitoramento_luzes_model.dart';
import 'package:salas_mobile/src/models/monitorar_sala_request_model.dart';
import 'package:salas_mobile/src/pages/auth/auth_page.dart';
import 'package:salas_mobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwitchWidget extends StatefulWidget {
  MonitoramentoLuzesModel monitoramentoLuzesModel;
  MonitoramentoCondicionadoresModel monitoramentoCondicionadoresModel;
  final SalaProvider salaProvider;
  final String titulo;
  final String token;
  FToast fToast;

  SwitchWidget(
      {super.key,
        required this.fToast,
        required this.titulo,
        required this.monitoramentoLuzesModel,
        required this.monitoramentoCondicionadoresModel,
        required this.salaProvider,
        required this.token});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel.empty();
  bool estadoDispositivo = false;
  bool _isButtonEnabled = true; // Controle para toques repetidos

  @override
  void initState() {
    super.initState();
    estadoDispositivo = (widget.titulo == "Luzes")
        ? widget.monitoramentoLuzesModel.estado
        : widget.monitoramentoCondicionadoresModel.estado;
  }

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
        Text(
            widget.titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
        ),
        const SizedBox(height: 8),
        // Substituindo o Switch por um botão personalizado maior
        Container(
          // Tornando o botão maior
          width: 60,  // Aumentado para ser maior
          height: 60, // Aumentado para ser maior
          decoration: BoxDecoration(
            color: estadoDispositivo ? Color(0xff31cdba) : Color(0xff9fbed1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: _isButtonEnabled ? () async {
                if (!_isButtonEnabled) return;

                setState(() {
                  _isButtonEnabled = false; // Desabilita o botão para evitar múltiplos toques
                });

                final novoEstado = !estadoDispositivo;
                final acao = novoEstado ? "Ligando" : "Desligando";
                final equipamento = widget.titulo == "Luzes" ? "luzes" : "ar-condicionado";

                // Mostrar mensagem mais coerente durante a ação
                showCustomToast(
                    fToast: widget.fToast,
                    titulo: "$acao $equipamento...",
                    cor: Color(0xff31cdba)
                );

                (widget.titulo == "Luzes")
                    ? monitorarLuzesSala(novoEstado)
                    : monitorarCondicionadoresSala(novoEstado);

                try {
                  await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
                    if (valueRequest.statusCode == 200) {
                      setState(() {
                        estadoDispositivo = novoEstado;
                      });
                      return showCustomToast(
                          fToast: widget.fToast,
                          titulo: valueRequest.mensagem,
                          cor: Color(0xff31cdba)
                      );
                    } else if (valueRequest.statusCode == 401) {
                      AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                      authLocalDatasource.setCurrentUser(AuthResponseModel.empty());
                      return Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthPage()),
                      );
                    }
                    return showCustomToast(
                        fToast: widget.fToast,
                        titulo: valueRequest.mensagem,
                        cor: Colors.red.shade400
                    );
                  });
                } finally {
                  // Garantir que o botão seja reabilitado mesmo se ocorrer exceções
                  setState(() {
                    _isButtonEnabled = true;
                  });
                }
              } : null,
              child: Center(
                child: Icon(
                  (widget.titulo == "Luzes")
                      ? (estadoDispositivo ? Icons.lightbulb : Icons.lightbulb_outline)
                      : (estadoDispositivo ? Icons.ac_unit : Icons.ac_unit_outlined),
                  color: Colors.white,
                  size: 35, // Ícone maior
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          estadoDispositivo ? "ON" : "OFF",
          style: TextStyle(
            color: estadoDispositivo ? Color(0xff31cdba) : Color(0xff9fbed1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}