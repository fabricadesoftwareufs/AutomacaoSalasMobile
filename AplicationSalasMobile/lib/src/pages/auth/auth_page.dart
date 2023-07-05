import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/pages/home/navigation_app.dart';
import 'package:aplicationsalasmobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:aplicationsalasmobile/src/models/auth_request_model.dart';
import 'package:aplicationsalasmobile/src/pages/auth/widgets/textFormField_widget.dart';
import 'package:aplicationsalasmobile/src/providers/auth_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool isPasswordVisible = true;
  FToast fToast = FToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 60,
          centerTitle: false,
          title: const Text('SalasUfs', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff277ebe),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: Color(0xff277ebe),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  color: Color(0xfff9faf7),
                  // borderRadius: BorderRadius.all(Radius.circular(25))
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const SizedBox(height: 5),
                      // const Text("SalasUfs",
                      //     textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                      // const SizedBox(height: 20),
                      Image.asset(
                        'assets/img/logo_provisoria.png',
                        fit: BoxFit.fill,
                        height: 180,
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldWidget(name: "CPF", controller: login, selecionado: (value) {}),
                      const SizedBox(height: 20),
                      TextFormFieldWidget(
                          name: "Senha",
                          controller: senha,
                          isPasswordVisible: isPasswordVisible,
                          selecionado: (value) {
                            setState(() {
                              isPasswordVisible = value;
                            });
                          }),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Color(0xff277ebe),
                                  shape: const RoundedRectangleBorder(
                                      // side: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () async {
                                  if (login.text == "" || senha.text == "") {
                                    showCustomToast(fToast: fToast, titulo: "Preencha os campos!", cor: Colors.red.shade400);
                                  } else {
                                    AuthRequestModel authRequestModel = AuthRequestModel(login: login.text, senha: senha.text);

                                    await Provider.of<AuthProvider>(context, listen: false).login(authRequestModel).then((value) {
                                      if (value == null)
                                        showCustomToast(fToast: fToast, titulo: "CPF ou senha estam incorretos!", cor: Colors.red.shade400);

                                      AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                                      authLocalDatasource.setCurrentUser(value!);
                                      // authLocalDatasource.getCurrentUser().then((value) => print(value.token));
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(builder: (context) => NavigationApp(auth: value)));
                                    });
                                  }
                                },
                                child: const Text("ENTRAR", style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      )
                      // buttonWidget(text: 'Entrar')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
