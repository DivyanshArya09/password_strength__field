import 'package:flutter/material.dart';
import 'package:password_strength__field/custom_text_field.dart';
import 'package:password_strength__field/input_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: CustomTextFieldTheme.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _passwordTC;

  @override
  void initState() {
    _passwordTC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password strength field'),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            CustomTextField(
              hint: 'Enter your password',
              onPasswordChanged: (p0) {},
              title: 'Enter password',
              controller: _passwordTC,
              isPasswordField: true,
            ),
          ],
        ),
      ),
    );
  }
}
