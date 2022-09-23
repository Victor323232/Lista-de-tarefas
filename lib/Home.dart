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
  Map<String, dynamic> _ultimoTarefaRemovida =Map();
   TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json"); //caminho diretorio
  }

  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;//recuperar texto digitado pelo usuario
    //criar dados
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _tarefas.add(tarefa);
    });
    _salvarArquivo();
    _controllerTarefa.text= ""; //livre de texto inicial
  }

  _salvarArquivo() async{
    var arquivo = await _getFile();

    String dados = json.encode(_tarefas); //convercao
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

  Widget criarItemLista(context,index) {
    final item = _tarefas[index]["titulo"];
    return Dismissible(
      key: Key(item),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){

        //remover item da lista
        _tarefas.removeAt(index);
        _salvarArquivo();

        //snackbar
        final snackbar = SnackBar(
          content: Text("Tarefa Removida!!"),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: (){

            },
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },

      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
                Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),
      child: CheckboxListTile(
        title: Text( _tarefas [index] ['titulo'] ),
        value: _tarefas [index] ['realizada'],
        onChanged: (valorAlterado){
          setState(() {
            _tarefas [index] ['realizada'] = valorAlterado;
          });
           _salvarArquivo();
        },
      ),
    );
    // return ListTile(
    //   title: Text( _tarefas [index] ['titulo'] ),
    // );
  }
  @override
  Widget build(BuildContext context) {
    _salvarArquivo();
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
          itemBuilder: criarItemLista

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
                      controller:_controllerTarefa,
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
                            _salvarTarefa();
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
