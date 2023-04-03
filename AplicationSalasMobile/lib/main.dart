import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aplicationsalasmobile/src/pages/auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:aplicationsalasmobile/src/pages/home/home_page.dart';
import 'package:aplicationsalasmobile/src/providers/auth_provider.dart';
import 'package:dotenv/dotenv.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    Dio dio = Dio();
    dio.options.baseUrl = env['BASE_URL']??'';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(dio)),
        ChangeNotifierProvider<SalaProvider>(create: (_) => SalaProvider(dio))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salas Ufs',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          "/home": (_) => const HomePage(),
          "/login": (_) => const AuthPage(),
        },
        home: VerifyAuth(),
      ),
    );
  }
}

class VerifyAuth extends StatelessWidget {
  VerifyAuth({Key? key}) : super(key: key);

  Future<AuthResponseModel?> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return await authLocalDatasource.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verify(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return snapshot.data != null ? const HomePage() : const AuthPage();
        }

        //TODO: fazer tela de splash aqui
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
