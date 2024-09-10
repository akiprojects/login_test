import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import 'login/login_widget.dart'; // 로그인 페이지 임포트
import 'home_page/home_page_widget.dart'; // 홈 페이지 임포트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  // 로그인 상태 플래그 (로그인 여부를 추적하기 위한 변수)
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;

    // 로그인 상태에 따른 초기 경로 설정
    _router = GoRouter(
      initialLocation: isLoggedIn ? '/home' : '/login', // 초기 경로 결정
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginWidget(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePageWidget(),
        ),
      ],
    );
  }

  // 로그인 후 상태를 업데이트하고 홈으로 이동하는 함수
  void login() {
    setState(() {
      isLoggedIn = true;
    });
    _router.go('/home'); // 로그인 후 홈으로 이동
  }

  // 로그아웃 시 상태를 업데이트하고 로그인 페이지로 이동하는 함수
  void logout() {
    setState(() {
      isLoggedIn = false;
    });
    _router.go('/login'); // 로그아웃 후 로그인 페이지로 이동
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'test1',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
