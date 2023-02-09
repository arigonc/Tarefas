import 'package:app/models/tarefa.dart';
import 'package:app/pages/cadastrar_tarefa_page.dart';
import 'package:app/pages/editar_tarefa_page.dart';
import 'package:app/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class HojeTarefasPage extends StatefulWidget {
  const HojeTarefasPage({super.key});

  @override
  State<HojeTarefasPage> createState() => _HojeTarefasPageState();
}

class _HojeTarefasPageState extends State<HojeTarefasPage> {
  late List<Tarefa> tabela;
  late TarefaRepository tarefas;
  List<Tarefa> selecionadas = [];
  bool loading = false;

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('Tarefas de hoje'),
      );
    } else {
      return AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selecionadas = [];
              });
            },
          ),
          title: Text('${selecionadas.length} selecionadas'),
          backgroundColor: Colors.blueGrey[50],
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ));
    }
  }

  editarTarefa(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditarTarefaPage(tarefa: tarefa),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    tarefas = context.watch<TarefaRepository>();

    return Scaffold(
        appBar: appBarDinamica(),
        body: Container(child: Consumer<TarefaRepository>(
          builder: (context, tarefas, child) {
            return tarefas.today.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Não há nenhuma tarefa para ser feita hoje!",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: tarefas.today.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        leading: (selecionadas.contains(tarefas.today[index]))
                            ? CircleAvatar(
                                child: Icon(Icons.check),
                              )
                            : CircleAvatar(
                                child: Icon(Icons.arrow_right),
                              ),
                        title: Text(
                          tarefas.today[index].titulo +
                              ' - ' +
                              DateFormat('dd/MM/yyyy')
                                  .format(tarefas.today[index].data),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(tarefas.today[index].descricao),
                        ),
                        selected: selecionadas.contains(tarefas.today[index]),
                        selectedTileColor: Colors.indigo[50],
                        onLongPress: () {
                          setState(() {
                            (selecionadas.contains(tarefas.today[index]))
                                ? selecionadas.remove(tarefas.today[index])
                                : selecionadas.add(tarefas.today[index]);
                          });
                        },
                        onTap: () => editarTarefa(tarefas.today[index]),
                      );
                    },
                    padding: const EdgeInsets.all(16),
                  );
          },
        )),
        floatingActionButton: selecionadas.isNotEmpty
            ? FloatingActionButton(
                onPressed: () {
                  setState(() => loading = true);
                  try {
                    tarefas.remove(selecionadas);
                    setState(() => loading = false);
                    setState(() {
                      selecionadas = [];
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Tarefa(s) removida(s) com sucesso!"),
                      backgroundColor: Colors.green,
                    ));
                  } on Exception catch (e) {
                    setState(() => loading = false);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                backgroundColor: Colors.indigo,
                child: const Icon(Icons.delete),
              )
            : null);
  }
}
