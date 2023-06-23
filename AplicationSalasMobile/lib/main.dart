import 'package:aplicationsalasmobile/src/datasources/auth_local_datasource.dart';
import 'package:aplicationsalasmobile/src/models/auth_response_model.dart';
import 'package:aplicationsalasmobile/src/pages/home/navigation_app.dart';
import 'package:aplicationsalasmobile/src/providers/reserva_provider.dart';
import 'package:aplicationsalasmobile/src/providers/sala_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aplicationsalasmobile/src/pages/auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:aplicationsalasmobile/src/pages/home/home_page.dart';
import 'package:aplicationsalasmobile/src/providers/auth_provider.dart';
import 'package:dotenv/dotenv.dart';


void main() async {
  // runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

// Future initialization(BuildContext? context) async {
//   print("Entrou");
//   await Future.delayed(Duration(seconds: 5));
//   print("SAIUUUUUUUUUUUUUU");
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    Dio dio = Dio();
    dio.options.baseUrl = env['BASE_URL']??'http://marcosdosea-002-site2.itempurl.com/api';

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
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        routes: {
          "/home": (_) => NavigationApp(),// HomePage(authResponseModel: AuthResponseModel.empty()),
          "/login": (_) => const AuthPage(),
        },
        home: VerifyAuth(),
      ),
    );
  }
}

class VerifyAuth extends StatefulWidget {
  VerifyAuth({Key? key}) : super(key: key);

  @override
  State<VerifyAuth> createState() => _VerifyAuthState();
}

class _VerifyAuthState extends State<VerifyAuth> {
  late AuthResponseModel authResponseModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const AuthPage())
      );
    });
  }


  Future<AuthResponseModel?> verify() async {
    AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();
    // return AuthResponseModel.empty();
    return authResponseModel = (await authLocalDatasource.getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff277ebe),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Image(
            //   image: AssetImage("assets/img/logo_provisoria.png"),
            //   width: 300,
            // ),
            SpinKitDualRing(color: Color(0xfff9faf7), size: 50)
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
