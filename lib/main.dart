import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter app'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              counter++;
              setState(() {});
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('Add'),
              ],
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: () {
              if (counter > 0) {
                counter--;
                setState(() {});
              }
            },
            label: Row(
              children: [
                Icon(Icons.remove),
                Text('Remove'),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counter.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondScreen()));
                },
                child: Text('Go to second screen'))
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  SecondScreen({Key? key}) : super(key: key);

  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Column(
        children: [
          Column(),
          Row(),
          Row(),
          StatefulBuilder(builder: (context, setState) {
            return Row(
              children: [
                Text(counter.toString()),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      counter++;
                      setState(() {});
                    },
                    child: Text('change name'))
              ],
            );
          })
        ],
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController inputTextFieldController = TextEditingController();
  TextEditingController inputTwoTextFieldController = TextEditingController();

  double result = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: inputTextFieldController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '0',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: inputTwoTextFieldController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '0',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Result = $result'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      final double firstValue =
                          double.tryParse(inputTextFieldController.text) ?? 0;
                      final double secondValue =
                          double.tryParse(inputTwoTextFieldController.text) ??
                              0;
                      result = firstValue + secondValue;
                      setState(() {});
                    },
                    icon: Icon(Icons.add)),
                IconButton(
                    onPressed: () {
                      final double firstValue =
                          double.tryParse(inputTextFieldController.text) ?? 0;
                      final double secondValue =
                          double.tryParse(inputTwoTextFieldController.text) ??
                              0;
                      result = firstValue - secondValue;
                      setState(() {});
                    },
                    icon: Icon(Icons.remove)),
                IconButton(
                    onPressed: () {
                      final double firstValue =
                          double.tryParse(inputTextFieldController.text) ?? 0;
                      final double secondValue =
                          double.tryParse(inputTwoTextFieldController.text) ??
                              0;
                      result = firstValue * secondValue;
                      setState(() {});
                    },
                    icon: Icon(Icons.star)),
                IconButton(
                    onPressed: () {
                      final double firstValue =
                          double.tryParse(inputTextFieldController.text) ?? 0;
                      final double secondValue =
                          double.tryParse(inputTwoTextFieldController.text) ??
                              0;
                      result = firstValue / secondValue;
                      setState(() {});
                    },
                    icon: Icon(Icons.safety_divider)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
