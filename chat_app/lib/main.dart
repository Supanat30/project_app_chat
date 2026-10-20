import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/user_list_screen.dart';

final supabase = Supabase.instance.client;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      await Supabase.initialize(
        url: 'https://lrjhdamxqpetkyldrnjg.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyamhkYW14cXBldGt5bGRybmpnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTIxMjQzMDAsImV4cCI6MjEwNzcwMDMwMH0.Cq3uZ6y5rLU3TQ2x0ik5CSbF4HVGVXypGSs-Bmlq2oM',
      );
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          primary: const Color(0xFF4F46E5),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E293B),
          elevation: 0,
          scrolledUnderElevation: 1,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      home: !_isInitialized
          ? Scaffold(
              body: Center(
                child: _errorMessage != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'เกิดข้อผิดพลาดในการเชื่อมต่อ:\n$_errorMessage',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            )
          : (Supabase.instance.client.auth.currentUser == null
              ? const LoginScreen()
              : const UserListScreen()),
    );
  }
}