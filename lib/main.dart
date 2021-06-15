import 'package:flutter/material.dart';

//! lovepeople_todo_(app_2)

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Lista(),
    );
  }
}

// Lista de Tarefas

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final List<String> tarefa = []; //* para almacenar todas las tareas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Lista de Tarefas'),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: (tarefa.length), //* elementos comforme extensión de elementos de la lista
            itemBuilder: (context, index) { //* index de elementos de la lista
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1} - ${tarefa[index]}', //* index + 1. muestra a partir del nro 1
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2.0, //* el grosor de la línea
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          irParaFromulario(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void irParaFromulario(context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => Formulario(),
      ),
    )
    .then((value) {
      if (value != null) { //* si blanco no actualiza la pantalla
        setState(() {
          tarefa.add(value);
        });
      }
    });
  }
}

// Formulário

class Formulario extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final tarefaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Formulário'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Digite uma tarefa.', 
                    errorText: 'Não deixe o campo em branco, por favor.',
                    border: OutlineInputBorder(),
                  ),
                  controller: tarefaController,
                  onSaved: (value) {
                    tarefaController.text = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Digite uma tarefa, por favor!';
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    irParaLista(context);
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void irParaLista(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //! Estudar mais
      Navigator.of(context).pop(tarefaController.text);
    }
  }
}
