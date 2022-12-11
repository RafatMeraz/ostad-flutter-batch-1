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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /// rendering
  /// SKIA - (Impeller)
  /// life cycle of stateful widget
  // createState => banai
  // initState
  // didChangeDependencies
  // build
  // setState to rebuild ui
  // deactive
  // dispose

  bool isChecked = false;
  bool isNotChecked = false;
  bool iAmChecked = false;

  @override
  void initState() {
    super.initState();
    print('Hiiiii!');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did called');
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('widget changed');
  }

  @override
  Widget build(BuildContext context) {
    print('build method');
    return Scaffold(
      appBar: AppBar(
        title: Text('Stateless home'),
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do you agree?'),
                Checkbox(
                    value: isChecked,
                    onChanged: (newValue) {
                      print(newValue);
                      isChecked = newValue!;

                      setState(() {});

                    }),
              ],
            ),
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherScreen()));
          }, child: Text('Go to another screen'))
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('Deactive');
  }

  @override
  void dispose() {
    super.dispose();
    print('Thank you for coming to my screen, bye');
  }
}

class AnotherScreen extends StatefulWidget {
  const AnotherScreen({Key? key}) : super(key: key);

  @override
  State<AnotherScreen> createState() => _AnotherScreenState();
}

class _AnotherScreenState extends State<AnotherScreen> {

  @override
  void initState() {
    super.initState();
    print('Hi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another screen'),
      ),
      body: Center(
        child: Text('Another screen'),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('turn off your work');
  }

  @override
  void dispose() {
    super.dispose();
    print('bye');
  }

}




// class Home extends StatelessWidget {
//   Home({Key? key}) : super(key: key);
//
//   bool isChecked = false;
//
//   // state
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stateless home'),
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Do you agree?'),
//                 Checkbox(
//                     value: isChecked,
//                     onChanged: (newValue) {
//                       isChecked = newValue!;
//                     }),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


