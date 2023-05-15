import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/providers/reserva_provider.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aplicationsalasmobile/src/pages/auth/auth_page.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:aplicationsalasmobile/src/pages/home/home_page.dart';
import 'package:aplicationsalasmobile/src/providers/auth_provider.dart';
import 'package:dotenv/dotenv.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
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
        ChangeNotifierProvider<SalaProvider>(create: (_) => SalaProvider(dio)),
        ChangeNotifierProvider<ReservaProvider>(create: (_) => ReservaProvider(dio))
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Salas Ufs',
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
          "/home": (_) => HomePage(authResponseModel: AuthResponseModel.empty()),
          "/login": (_) => const AuthPage(),
        },
        home: VerifyAuth(),
      ),
    );
  }
}

class VerifyAuth extends StatelessWidget {
  VerifyAuth({Key? key}) : super(key: key);
  late AuthResponseModel authResponseModel;

  Future<AuthResponseModel?> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return authResponseModel = (await authLocalDatasource.getCurrentUser())!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verify(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return snapshot.data != null ? HomePage(authResponseModel: authResponseModel) : const AuthPage();
        }

        //TODO: fazer tela de splash aqui
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
