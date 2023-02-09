import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyLiveScoreApp());
}

class MyLiveScoreApp extends StatelessWidget {
  const MyLiveScoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LiveScorePage(),
    );
  }
}

class LiveScorePage extends StatefulWidget {
  const LiveScorePage({Key? key}) : super(key: key);

  @override
  State<LiveScorePage> createState() => _LiveScorePageState();
}

class _LiveScorePageState extends State<LiveScorePage> {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Live Score'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 5,
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: firestore
                      .collection('cricket')
                      .doc('OZ86tpHZcOL0q0SUqG5z')
                      .snapshots(),
                  builder: (context, snapshot) {
                    DocumentSnapshot<Map<String, dynamic>>? doc = snapshot.data;
                    return Column(
                      children: [
                        Text(
                          doc?.get('match') ?? 'Unknown',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doc?.get('score').toString() ?? 'Unknown',
                              style: const TextStyle(fontSize: 36),
                            ),
                            const Text(
                              '/',
                              style: TextStyle(fontSize: 26),
                            ),
                            Text(
                              doc?.get('wickets').toString() ?? 'Unknown',
                              style: const TextStyle(fontSize: 26),
                            ),
                          ],
                        ),
                        Text('Overs: ${doc?.get('overs').toString() ?? 'Unknown'}'),
                        const Text('Batsman on pitch'),
                        Text(doc?.get('active-batsman').toString() ?? 'Unknown')
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
