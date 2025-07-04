import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/pages/home/navigation_app.dart';
import 'package:salas_mobile/src/pages/shared/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:salas_mobile/src/models/auth_request_model.dart';
import 'package:salas_mobile/src/pages/auth/widgets/textFormField_widget.dart';
import 'package:salas_mobile/src/providers/auth_provider.dart';
import 'package:salas_mobile/src/providers/theme_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool isPasswordVisible = true;
  bool _isButtonEnabled = true;
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('SmartSala', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: 100,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/img/knuth.png',
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
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: _isButtonEnabled ? () async {
                                  if (login.text == "" || senha.text == "") {
                                    showCustomToast(fToast: fToast, titulo: "Preencha os campos!", cor: Colors.red.shade400);
                                  } else {
                                    setState(() {
                                      _isButtonEnabled = false;
                                    });

                                    AuthRequestModel authRequestModel = AuthRequestModel(login: login.text, senha: senha.text);

                                    await Provider.of<AuthProvider>(context, listen: false).login(authRequestModel).then((value) {
                                      if (value == null) {
                                        showCustomToast(fToast: fToast, titulo: "CPF ou senha estam incorretos!", cor: Colors.red.shade400);
                                        setState(() {
                                          _isButtonEnabled = true;
                                        });
                                      } else {
                                        AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                                        authLocalDatasource.setCurrentUser(value);
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(builder: (context) => NavigationApp(auth: value)));
                                      }
                                    }).catchError((error) {
                                      setState(() {
                                        _isButtonEnabled = true;
                                      });
                                    });
                                  }
                                } : null,
                                child: const Text("ENTRAR", style: TextStyle(color: Colors.white))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}