import 'package:app/models/tarefa.dart';
import 'package:app/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditarTarefaPage extends StatefulWidget {
  Tarefa tarefa;
  EditarTarefaPage({super.key, required this.tarefa});

  @override
  State<EditarTarefaPage> createState() => _EditarTarefaPageState();
}

class _EditarTarefaPageState extends State<EditarTarefaPage> {
  late TarefaRepository tarefas;
  final formKey = GlobalKey<FormState>();
  final titulo = TextEditingController();
  final descricao = TextEditingController();
  final data = TextEditingController();
  final data_true = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    tarefas = context.watch<TarefaRepository>();
    titulo.text = widget.tarefa.titulo;
    descricao.text = widget.tarefa.descricao;
    data.text = DateFormat('dd/MM/yyyy').format(widget.tarefa.data);
    data_true.text = DateFormat('yyyy-MM-dd').format(widget.tarefa.data);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa.titulo),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: TextFormField(
                  controller: titulo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Título',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe um título';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: TextFormField(
                  controller: descricao,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe uma descrição';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: TextFormField(
                  controller: data,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      String formattedDate_true =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        data.text = formattedDate;
                        data_true.text = formattedDate_true;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe uma data';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      try {
                        tarefas.update(Tarefa(
                          id: widget.tarefa.id,
                          titulo: titulo.text,
                          descricao: descricao.text,
                          data: DateTime.parse(data_true.text),
                        ));
                        setState(() => loading = false);
                        setState(() {
                          widget.tarefa.titulo = titulo.text;
                          widget.tarefa.descricao = descricao.text;
                          widget.tarefa.data = DateTime.parse(data_true.text);
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Tarefa editada com sucesso!"),
                          backgroundColor: Colors.green,
                        ));
                      } on Exception catch (e) {
                        setState(() => loading = false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (loading)
                        ? [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]
                        : [
                            Icon(Icons.check),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Editar',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
