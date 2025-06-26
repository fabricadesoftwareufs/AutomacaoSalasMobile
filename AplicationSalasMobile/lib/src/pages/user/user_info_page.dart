import 'package:flutter/material.dart';
import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/pages/auth/auth_page.dart';

class UserInfoPage extends StatelessWidget {
  final AuthResponseModel auth;

  const UserInfoPage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff277ebe),
        actions: [
          IconButton(
            icon: const Icon(Icons.nights_stay , color: Colors.white),
            onPressed: () {
              // Aqui você vai implementar a mudança de tema depois
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Espaço flexível no topo
            const Spacer(),

            // Informações do usuário centralizadas
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    auth.nome,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tipo de Usuário: vou descobrir!',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  //Text('Tipo de Usuário: ${auth.tipoUsuario}', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),

            // Espaço flexível no meio
            const Spacer(),

            // Botão de logout na parte inferior
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onPressed: () async {
                AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
                await authLocalDatasource.setCurrentUser(AuthResponseModel.empty());
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                      (route) => false,
                );
              },
              child: const Text('Deslogar', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}