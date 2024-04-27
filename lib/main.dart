import 'package:flutter/material.dart';
import 'package:passman/pages/_home_page.dart';
import 'package:passman/providers/password_gen_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PasswordProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
