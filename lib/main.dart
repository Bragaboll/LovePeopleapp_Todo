import 'package:flutter/material.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
          irParaNovaPag(context);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 2),
              height: 50,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1} - ${list[index]}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1.5,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void irParaNovaPag(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => Formulario(),
          ),
        )
        .then((value) => setState(() {
              list.add(value);
            }));
  }
}

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formkey = GlobalKey<FormState>();
  final itemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('formulário'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 40,
                ),
                TextFormField(
                  controller: itemController,
                  onSaved: (item) {
                    itemController.text = item;
                  },
                  validator: (item) {
                    if (item.isEmpty) {
                      return 'Campo Obrigatório!';
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();

                      Navigator.of(context).pop(itemController.text);
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
