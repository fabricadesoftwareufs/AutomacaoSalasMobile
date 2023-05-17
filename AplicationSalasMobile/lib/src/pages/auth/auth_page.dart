import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplicationsalasmobile/src/models/auth_request_model.dart';
import 'package:aplicationsalasmobile/src/pages/auth/widgets/textFormField_widget.dart';
import 'package:aplicationsalasmobile/src/providers/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController login = TextEditingController();
    TextEditingController senha = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: const Text("SalasUfs")),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text("SalasUfs",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/img/logo_provisoria.png',
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                  TextFormFieldWidget(name: "Email", controller: login),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(name: "Senha", controller: senha),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                            ),
                            onPressed: () async {
                              AuthRequestModel authRequestModel =
                                  AuthRequestModel(login: login.text, senha: senha.text);

                              await Provider.of<AuthProvider>(context, listen: false)
                                  .login(authRequestModel)
                                  .then((value) {
                                if (value != null) {
                                  AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                                  authLocalDatasource.setCurrentUser(value);
                                  Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
                                }
                              });
                            },
                            child: const Text("ENTRAR", style: TextStyle(color: Colors.black))),
                      ),
                    ],
                  )
                  // buttonWidget(text: 'Entrar')
                ],
              ),
            ),
          ),
        ));
  }
}
