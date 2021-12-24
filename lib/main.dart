import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vijaychess/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VCCApp());
}

class VCCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Vijay Chess Club',
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
    );
  }

  final _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    )
  ]);
}
