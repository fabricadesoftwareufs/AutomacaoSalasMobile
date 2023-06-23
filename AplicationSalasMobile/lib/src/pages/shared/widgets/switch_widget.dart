import 'package:aplicationsalasmobile/src/models/monitoramento_condicionadores_model.dart';
import 'package:aplicationsalasmobile/src/models/monitoramento_luzes_model.dart';
import 'package:aplicationsalasmobile/src/models/monitorar_sala_request_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget SwitchWidget({required String titulo, required bool estadoDispositivo, required ValueChanged<bool> selecionadoChanged}){
  late MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Icon((titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff31cdba));
      }
      return Icon((titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: const Color(0xff9fbed1));
    },
  );
  return Column(
    children: [
      Text(titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
      Switch(
        value: estadoDispositivo,
        activeColor: Colors.white,
        activeTrackColor: const Color(0xff31cdba),
        inactiveTrackColor: const Color(0xff9fbed1),
        thumbIcon: thumbIcon,
        onChanged: (value) async {
          selecionadoChanged(value);
        },
      ),
    ],
  );
}

// class SwitchWidget extends StatefulWidget {
//   MonitoramentoLuzesModel monitoramentoLuzesModel;
//   MonitoramentoCondicionadoresModel monitoramentoCondicionadoresModel;
//   final SalaProvider salaProvider;
//   final String titulo;
//   final String token;
//   FToast fToast;
//
//   SwitchWidget(
//       {Key? key,
//        required this.fToast,
//       required this.titulo,
//       required this.monitoramentoLuzesModel,
//       required this.monitoramentoCondicionadoresModel,
//       required this.salaProvider,
//       required this.token})
//       : super(key: key);
//
//   @override
//   State<SwitchWidget> createState() => _SwitchWidgetState();
// }
//
// class _SwitchWidgetState extends State<SwitchWidget> {
//   late MonitorarSalaRequestModel monitoraSala = MonitorarSalaRequestModel.empty();
//   bool estadoDispositivo = false;
//
//   initState() {
//     estadoDispositivo = (widget.titulo == "Luzes")
//       ?widget.monitoramentoLuzesModel.estado
//       :widget.monitoramentoCondicionadoresModel.estado;
//   }
//
//   monitorarLuzesSala(bool value) {
//     monitoraSala = MonitorarSalaRequestModel(
//         id: widget.monitoramentoLuzesModel.id,
//         equipamentoId: widget.monitoramentoLuzesModel.equipamentoId,
//         estado: value,
//         salaId: widget.monitoramentoLuzesModel.equipamentoNavigationModel.sala,
//         salaParticula: widget.monitoramentoLuzesModel.estado);
//     widget.monitoramentoLuzesModel.estado = value;
//   }
//
//   monitorarCondicionadoresSala(bool value) {
//     monitoraSala = MonitorarSalaRequestModel(
//         id: widget.monitoramentoCondicionadoresModel.id,
//         equipamentoId: widget.monitoramentoCondicionadoresModel.equipamentoId,
//         estado: value,
//         salaId: widget.monitoramentoCondicionadoresModel.equipamentoNavigationModel.sala,
//         salaParticula: widget.monitoramentoCondicionadoresModel.estado);
//     widget.monitoramentoCondicionadoresModel.estado = value;
//   }
//
//   late MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
//       (Set<MaterialState> states) {
//         if (states.contains(MaterialState.selected)) {
//           return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: Color(0xff31cdba));
//         }
//         return Icon((widget.titulo == "Luzes")?Icons.lightbulb:Icons.thermostat, color: Color(0xff9fbed1));
//     },
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(widget.titulo, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black)),
//         Switch(
//           value: estadoDispositivo,
//           activeColor: Colors.white,
//           activeTrackColor: Color(0xff31cdba),
//           inactiveTrackColor: Color(0xff9fbed1),
//           thumbIcon: thumbIcon,
//           onChanged: (value) async {
//             (widget.titulo == "Luzes") ? monitorarLuzesSala(value) : monitorarCondicionadoresSala(value);
//
//             await widget.salaProvider.putMonitorarSala(monitoraSala, widget.token).then((valueRequest) {
//               if(valueRequest == "Monitoramento realizado com sucesso!") {
//                 estadoDispositivo = true;
//                 return showCustomToast(fToast: widget.fToast, titulo: valueRequest, cor: Color(0xff31cdba));
//               }
//               estadoDispositivo = false;
//               return showCustomToast(fToast: widget.fToast, titulo: valueRequest, cor: Colors.red.shade400);
//             });
//
//             setState(() {});
//           },
//         ),
//       ],
//     );
//   }
// }
