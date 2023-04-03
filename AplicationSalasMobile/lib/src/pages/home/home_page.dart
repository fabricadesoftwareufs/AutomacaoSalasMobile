import 'dart:developer';

import 'package:aplicationsalasmobile/src/models/sala_join_bloco_model.dart';
import 'package:aplicationsalasmobile/src/models/sala_response_model.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SalaProvider salaProvider;
  bool inicializado = false;
  bool luzes = false;
  bool arCondicionado = false;
  int tabAtual = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!inicializado) {
      salaProvider = Provider.of<SalaProvider>(context, listen: false);
      inicializado = true;
    }
  }

  void selectMenu(int i) {
    setState(() {
      tabAtual=i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("SalasUfs")),
        body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Color(0xFF29A7D9),
                        selectedFontSize: 10,
                        unselectedFontSize: 12,
                        selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        iconSize: 22,
                        elevation: 0,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        backgroundColor: Colors.white,
                        selectedIconTheme: IconThemeData(size: 30),
                        unselectedItemColor: Colors.grey,
                        currentIndex: tabAtual,
                        onTap: (int i) => selectMenu(i),
                        items: [
                          BottomNavigationBarItem(label: 'Minhas Salas', icon: Icon(Icons.house)),
                          BottomNavigationBarItem(label: 'Minhas Reservas', icon: Icon(Icons.class_)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if(tabAtual == 0)
                FutureBuilder(
                  future: salaProvider.getSalas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    if (snapshot.hasError) return const Center(child: Text("Erro ao carregar"));

                    List<SalaJoinBlocoModel> salaResponseModel = snapshot.data as List<SalaJoinBlocoModel>;
                    return Column(
                      children: [
                        for (int i = 0; i < salaResponseModel.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(salaResponseModel[i].sala.toString(), style: TextStyle(fontWeight: FontWeight.w700)),
                                          SizedBox(height: 8),
                                          Text(salaResponseModel[i].bloco, style: TextStyle(fontWeight: FontWeight.w700))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Luzes"),
                                          SizedBox(height: 8),
                                          Switch(
                                            activeColor: Colors.white,
                                            activeTrackColor: Colors.green,
                                            value: luzes,
                                            onChanged: (value) => setState(() => luzes = value),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("Ar Condicionado"),
                                          SizedBox(height: 8),
                                          Switch(
                                            activeColor: Colors.white,
                                            activeTrackColor: Colors.green,
                                            value: arCondicionado,
                                            onChanged: (value) => setState(() => arCondicionado = value),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                    // return Center(child: Text(salaResponseModel.map((e) => e.toJson()).toList().toString()));
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             alignment: Alignment.topCenter,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: BottomNavigationBar(
//                     type: BottomNavigationBarType.fixed,
//                     selectedItemColor: Color(0xFF29A7D9),
//                     selectedFontSize: 10,
//                     unselectedFontSize: 12,
//                     selectedLabelStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//                     iconSize: 22,
//                     elevation: 0,
//                     showSelectedLabels: true,
//                     showUnselectedLabels: true,
//                     backgroundColor: Colors.white,
//                     selectedIconTheme: IconThemeData(size: 30),
//                     unselectedItemColor:  Colors.grey,
//                     // currentIndex: tabAtual,
//                     onTap: (int i) {},
//                     items: [
//                       BottomNavigationBarItem(
//                         label: 'Minhas Salas',
//                         icon: Icon(Icons.house)
//                       ),
//                       BottomNavigationBarItem(
//                           label: 'Minhas Reservas',
//                           icon: Icon(Icons.class_)
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
