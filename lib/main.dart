import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:vijaychess/events_create_screen.dart';
import 'package:vijaychess/firebase_options.dart';
import 'package:vijaychess/landing_page.dart';
import 'package:vijaychess/players_create_screen.dart';
import 'package:vijaychess/players_screen.dart';
import 'package:vijaychess/events_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Note: This conditional is needed https://stackoverflow.com/a/70296143/31252
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  initializeDateFormatting();
  runApp(VCCApp());
}

class VCCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
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

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => LandingPage(), routes: [
        GoRoute(
          path: 'events',
          builder: (context, state) => EventsScreen(),
          routes: [
            GoRoute(
                path: 'new', builder: (context, state) => EventsCreateScreen())
          ],
        ),
        GoRoute(
          path: 'players',
          builder: (context, state) => PlayersScreen(),
          routes: [
            GoRoute(
                path: 'new', builder: (context, state) => PlayersCreateScreen())
          ],
        ),
      ]),
    ],
  );
}
