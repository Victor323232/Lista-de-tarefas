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
    _carregarTarefas(); //retorna tarefas
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: <Widget>[
        Expanded(
        child: ListView.builder(
          itemCount: _tarefas.length,
          itemBuilder: (context, indice){
            Map<String, dynamic> item = _tarefas[indice];
            return ListTile(
              title: Text(_tarefas[indice]["titulo"]),
              subtitle: Text(_tarefas[indice]["descricao"]),
            );
          },

        ),
      ),
      ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
                      decoration: InputDecoration(
                        labelText: "Digite sua tarefa"
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: ()=> Navigator.pop(context),
                          child: Text("Cancelar")),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Salvar"))
                    ],
                  );
                }
                );
          },
          label: Text("Adicionar"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 30,
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),

      ),
    );
  }
}
