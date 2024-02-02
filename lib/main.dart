import 'package:flutter/material.dart';
import 'package:i_flutter/controls/text_field/iTextField.dart';
import 'package:i_flutter/controls/text_field/supports/iKeyboardType.dart';
import 'package:i_flutter/themes/iColors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'iFlutter',
      home: MyHomePage(title: 'iFlutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    IColors.colorTextField = Colors.black;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ITextField(controller: controller, title: 'haha', keyboardType: IKeyboardType.multiline),
            ],
          ),
        ),
      ),
    );
  }
}
