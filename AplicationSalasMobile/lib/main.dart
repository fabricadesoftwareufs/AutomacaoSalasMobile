import 'package:flutter/material.dart';
import 'package:salas_mobile/src/datasources/auth_local_datasource.dart';
import 'package:salas_mobile/src/models/auth_response_model.dart';
import 'package:salas_mobile/src/pages/home/navigation_app.dart';
import 'package:salas_mobile/src/providers/reserva_provider.dart';
import 'package:salas_mobile/src/providers/sala_provider.dart';
import 'package:salas_mobile/src/providers/theme_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:salas_mobile/src/pages/auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:salas_mobile/src/providers/auth_provider.dart';
import 'package:dotenv/dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider(dio)),
        ChangeNotifierProvider(create: (_) => SalaProvider(dio)),
        ChangeNotifierProvider(create: (_) => ReservaProvider(dio))
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            color: Colors.red,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'Salas Ufs',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xfff9faf7),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff277ebe),
                foregroundColor: Colors.white,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff277ebe),
                brightness: Brightness.light,
              ),
              cardColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xff121212),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff1e1e1e),
                foregroundColor: Colors.white,
              ),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff277ebe),
                brightness: Brightness.dark,
              ),
              cardColor: const Color(0xff1e1e1e),
            ),
            routes: {
              "/home": (_) => NavigationApp(auth: AuthResponseModel.empty()),
              "/login": (_) => const AuthPage(),
            },
            home: const AuthWrapper(),
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).initializeAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/img/logo_provisoria.png"),
                    width: 300,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "SmartSala",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        if (authProvider.logado && authProvider.currentUser != null) {
          return NavigationApp(auth: authProvider.currentUser!);
        } else {
          return const AuthPage();
        }
      },
    );
  }
}