import 'package:flutter/material.dart';

/// Goal
/// Make a todo list app
/// add a new todo
/// remove a todo
/// show all todos
/// edit a todo

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];
  TextEditingController todoNameEditingController = TextEditingController();
  TextEditingController updateTodoNameEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Todo name'),
                        const SizedBox(height: 16),
                        TextField(
                          controller: todoNameEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Write your todo',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: () {
                              if (todoNameEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                                todos
                                    .add(todoNameEditingController.text.trim());
                                todoNameEditingController.text = '';
                                print(todos);
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Add todo'))
                      ],
                    ),
                  );
                });
          },
          label: const Text('Add')),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final String todo = todos[(todos.length - 1) - index];
            return Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        todo,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            todos.removeAt((todos.length - 1) - index);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            updateTodoNameEditingController.text = todo;
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Update todo name'),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller:
                                              updateTodoNameEditingController,
                                          decoration: const InputDecoration(
                                            hintText: 'Write your todo',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (updateTodoNameEditingController
                                                  .text
                                                  .trim()
                                                  .isNotEmpty) {
                                                todos[(todos.length - 1) -
                                                        index] =
                                                    updateTodoNameEditingController
                                                        .text
                                                        .trim();
                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text('Update todo'))
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.amber,
                          ))
                    ],
                  ),
                ));
          }),
    );
  }
}
