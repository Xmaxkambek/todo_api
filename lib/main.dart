import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todo_api/services/todoAPI.dart';
import 'package:todo_api/models/todo.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: TodoAPP()));
}

class TodoAPP extends StatefulWidget {
  const TodoAPP({Key? key}) : super(key: key);

  @override
  State<TodoAPP> createState() => _TodoAPPState();
}

class _TodoAPPState extends State<TodoAPP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const  Color(0xff181818),
        title: const Text('Todo App'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getTodo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
               itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey<int>(snapshot.data[index]),
                    onDismissed: (DismissDirection direction) {
                      setState() {
                        snapshot.data.removeAtgit ([index]);
                      }
                    },
                    child: ListTile(
                      // onLongPress: () {
                      //   setState() {}
                      //   remove(snapshot.data[index].id);
                      // },
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].description),
                      trailing:
                          Text(snapshot.data![index].completed.toString()),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            addTask(
              Todo(
                title: 'Test',
                description: 'Test',
                completed: true,
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
