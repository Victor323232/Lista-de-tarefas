import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _tarefas = [];
  void _carregarTarefas(){
    _tarefas = [];
    for( int i = 0; i < 10;i++ ){
      Map<String, dynamic> tarefa = Map();
      tarefa["titulo"] = "Titulo ${i} Lorem";
      tarefa["descricao"] = "Descricao ${i} Lorem";
      _tarefas.add(tarefa);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemBuilder: (context, indice){

          },
          itemCount: _tarefas.length,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          label: Text("Adicionar"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 30,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),

      ),
      bottomNavigationBar: BottomAppBar(
      ),
    );
  }
}
