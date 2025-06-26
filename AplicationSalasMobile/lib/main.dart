import 'package:flutter/material.dart';
import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/pages/home/navigation_app.dart';
import 'package:salas_mobile/src/providers/reserva_provider.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:salas_mobile/src/pages/auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:salas_mobile/src/providers/auth_provider.dart';
import 'package:dotenv/dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
    dio.options.baseUrl = env['BASE_URL']??'http://itetech-001-site4.qtempurl.com/api';
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(dio)),
        ChangeNotifierProvider<SalaProvider>(create: (_) => SalaProvider(dio)),
        ChangeNotifierProvider<ReservaProvider>(create: (_) => ReservaProvider(dio))
      ],
      child: MaterialApp(
        color: Colors.red,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Salas Ufs',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        routes: {
          "/home": (_) => NavigationApp(auth: AuthResponseModel.empty()),
          "/login": (_) => const AuthPage(),
        },
        home: VerifyAuth(),
      ),
    );
  }
}

class VerifyAuth extends StatefulWidget {
  const VerifyAuth({super.key});

  @override
  State<VerifyAuth> createState() => _VerifyAuthState();
}

class _VerifyAuthState extends State<VerifyAuth> {
  late AuthResponseModel authResponseModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      verify().then((value) {
        (value.id != 0) ? Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (ctx) => NavigationApp(auth: value))
        ) : Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (ctx) => const AuthPage())
        );
      });
    });
  }


  Future<AuthResponseModel> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    return AuthResponseModel.empty();
    // return authResponseModel = (await authLocalDatasource.getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9faf7),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/img/logo_provisoria.png"),
              width: 300,
            ),
            SizedBox(height: 20),
            Text("SmartSala", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
            // SpinKitDualRing(color: Color(0xfff9faf7), size: 50)
          ],
        ),
      ),
    );
    // return FutureBuilder(
    //   future: verify(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState != ConnectionState.waiting) {
    //       return snapshot.data?.id != 0 ? NavigationApp() : const AuthPage();//HomePage(authResponseModel: authResponseModel) : const AuthPage();
    //     }
    //
    //     //TODO: fazer tela de splash aqui
    //     return const Center(child: CircularProgressIndicator());
    //   },
    // );
  }
}
