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
  VCCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: const [
        Locale('en'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Vijay Chess Club',
      builder: (context, widget) => ResponsiveBreakpoints.builder(
          child: BouncingScrollWrapper.builder(context, widget!),
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ]),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingPage(), routes: [
        GoRoute(
          path: 'events',
          builder: (context, state) => const EventsScreen(),
          routes: [
            GoRoute(
                path: 'new', builder: (context, state) => const EventsCreateScreen())
          ],
        ),
        GoRoute(
          path: 'players',
          builder: (context, state) => const PlayersScreen(),
          routes: [
            GoRoute(
                path: 'new', builder: (context, state) => const PlayersCreateScreen())
          ],
        ),
      ]),
    ],
  );
}
