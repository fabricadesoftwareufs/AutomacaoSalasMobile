import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/models/salas_usuario_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/empty_widget.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final AuthResponseModel authResponseModel;
  const HomePage({Key? key, required this.authResponseModel}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SalaProvider salaProvider;
  late List<AuthResponseModel> listaSalasUsuario = [];
  late String token = '';
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
      tabAtual = i;
    });
  }

  Future<AuthResponseModel?> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return await authLocalDatasource.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("SalasUfs")),
        body: Container(
          color: Colors.grey.shade200,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: const Color(0xFF29A7D9),
                        selectedFontSize: 10,
                        unselectedFontSize: 12,
                        selectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        iconSize: 22,
                        elevation: 0,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        backgroundColor: Colors.white,
                        selectedIconTheme: const IconThemeData(size: 30),
                        unselectedItemColor: Colors.grey,
                        currentIndex: tabAtual,
                        onTap: (int i) => selectMenu(i),
                        items: const [
                          BottomNavigationBarItem(label: 'Minhas Salas', icon: Icon(Icons.house)),
                          BottomNavigationBarItem(label: 'Minhas Reservas', icon: Icon(Icons.class_)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (tabAtual == 0)
                Expanded(
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future: verify().then((value) {
                        token = value!.token;
                        return salaProvider.salasUsuario(value.id);
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) return const Center(child: Text("Erro ao carregar"));

                        List<SalasUsuarioResponseModel> salasUsuario = snapshot.data as List<SalasUsuarioResponseModel>;
                        return (salasUsuario.isEmpty)
                        ?Container(
                          padding: const EdgeInsets.all(8),
                          child: Empty_Widget(titulo: 'Sem salas', descricao: 'Você ainda não tem salas cadastradas!')
                        )
                        :Column(
                          children: [
                            for (int i = 0; i < salasUsuario.length; i++)
                              Card(
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
                                          Text(salasUsuario[i].salaModel.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                                          Text(salasUsuario[i].blocoModel.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
                                        ],
                                      ),
                                      // SwitchWidget(titulo: "Luzes", salasUsuario: salasUsuario[i], salaProvider: salaProvider, token: token),
                                      // SwitchWidget(titulo: "Ar Condicionado", salasUsuario: salasUsuario[i], salaProvider: salaProvider, token: token),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              // if (tabAtual == 1)
              //   Container(child: MenuSemanal(idUsuario: 17, salaProvider: salaProvider, authResponseModel: widget.authResponseModel))
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
