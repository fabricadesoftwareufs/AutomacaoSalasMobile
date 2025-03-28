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

// class SwitchWidgetTeste extends StatefulWidget {
//   final String titulo;
//   late bool estadoDispositivo;
//   final String token;
//   final FToast fToast;
//   final SalaProvider salaProvider;
//   final MonitorarSalaRequestModel monitoraSala;
//   SwitchWidgetTeste({Key? key, required this.titulo, required this.estadoDispositivo, required this.monitoraSala, required this.token, required this.fToast, required this.salaProvider}) : super(key: key);
//
//   @override
//   State<SwitchWidgetTeste> createState() => _SwitchWidgetState();
// }
//
// class _SwitchWidgetState extends State<SwitchWidgetTeste> {
//
//   late MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
//         (Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff31cdba));
//       }
//       return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff9fbed1));
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
//         Switch(
//           value: widget.estadoDispositivo,
//           activeColor: Colors.white,
//           activeTrackColor: const Color(0xff31cdba),
//           inactiveTrackColor: const Color(0xff9fbed1),
//           thumbIcon: thumbIcon,
//           onChanged: (value) async {
//             await widget.salaProvider.putMonitorarSala(widget.monitoraSala, widget.token).then((valueRequest) {
//               if(valueRequest.statusCode == 200) { // if(valueRequest == "Monitoramento realizado com sucesso!") {
//                 setState(() => widget.estadoDispositivo = value);
//                 return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: const Color(0xff31cdba));
//               }
//               return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
//             });
//             // selecionadoChanged(value);
//           },
//         ),
//       ],
//     );
//   }
// }


// Widget SwitchWidget({required String titulo, required bool estadoDispositivo, required ValueChanged<bool> selecionadoChanged}){
//   late MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
//         (Set<MaterialState> states) {
//       if (states.contains(MaterialState.selected)) {
//         return Icon((titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff31cdba));
//       }
//       return Icon((titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff9fbed1));
//     },
//   );
//   return Column(
//     children: [
//       Text(titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
//       Switch(
//         value: estadoDispositivo,
//         activeColor: Colors.white,
//         activeTrackColor: const Color(0xff31cdba),
//         inactiveTrackColor: const Color(0xff9fbed1),
//         thumbIcon: thumbIcon,
//         onChanged: (value) async {
//           selecionadoChanged(value);
//         },
//       ),
//     ],
//   );
// }

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

  @override
  initState() {
    estadoDispositivo = (widget.titulo == "Luzes")
      ?widget.monitoramentoLuzesModel.estado
      :widget.monitoramentoCondicionadoresModel.estado;
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

  late WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: Color(0xff31cdba));
        }
        return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: Color(0xff9fbed1));
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
        Switch(
          value: estadoDispositivo,
          activeColor: Colors.white,
          activeTrackColor: Color(0xff31cdba),
          inactiveTrackColor: Color(0xff9fbed1),
          thumbIcon: thumbIcon,
          onChanged: (value) async {
            (widget.titulo == "Luzes") ? monitorarLuzesSala(value) : monitorarCondicionadoresSala(value);

            await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
              if(valueRequest.statusCode == 200) {
                estadoDispositivo = value;
                return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: Color(0xff31cdba));
              } else if(valueRequest.statusCode == 401) {
                AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                authLocalDatasource.setCurrentUser(AuthResponseModel.empty());
                return Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              }
              // estadoDispositivo = value;
              return showCustomToast(fToast: widget.fToast, titulo: valueRequest.mensagem, cor: Colors.red.shade400);
            });
            setState(() {});
          },
        ),
      ],
    );
  }
}
