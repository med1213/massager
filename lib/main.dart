import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_routes.dart';
import 'services/services.dart';
import 'theme/messenger_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app lifecycle service
  await AppLifecycleService().initialize();

  runApp(const ProviderScope(child: MessengerApp()));
}

class MessengerApp extends StatefulWidget {
  const MessengerApp({super.key});

  @override
  State<MessengerApp> createState() => _MessengerAppState();
}

class _MessengerAppState extends State<MessengerApp> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    _loadInitialRoute();
  }

  @override
  void dispose() {
    AppLifecycleService().dispose();
    super.dispose();
  }

  Future<void> _loadInitialRoute() async {
    final lastRoute = await AppLifecycleService().getInitialRoute();
    setState(() {
      _initialRoute = lastRoute ?? AppRoutes.conversationList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(MessengerTheme.statusBarStyle);

    // Show loading screen while determining initial route
    if (_initialRoute == null) {
      return MaterialApp(
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
        theme: MessengerTheme.lightTheme,
      );
    }

    return MaterialApp(
      title: 'Messenger Clone',
      theme: MessengerTheme.lightTheme,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: _initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
