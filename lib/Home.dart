import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _tarefas = [];

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json"); //caminho diretorio
  }

  _salvarTarefa() async{
    var arquivo = await _getFile();
    //criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _tarefas.add(tarefa);

    String dados = jsonEncode(_tarefas); //convercao
    arquivo.writeAsString(dados); //salvar tarefas
  }
  _lerTarefa( ) async {
    try{ //tentar ler uma tarefa
        final arquivo = await _getFile();
        return arquivo.readAsString(); //recuperar arquivo

    }catch(e){
      return null;
    }
  }
  @override
  void initState(){ //realizar altecao antes de carregar metodo build
    super.initState();
    _lerTarefa().then( (dados){ //entao
      setState(() {
        _tarefas = json.decode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //salvarTarefa();
    //print("itens:"+ _tarefas.toString());
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
          itemBuilder: (context, index){
            // Map<String, dynamic> item = _tarefas[indice];
            return ListTile(
              title: Text( _tarefas [index] ['titulo'] ),
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
