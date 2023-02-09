import 'dart:collection';
import 'package:app/database/db_firestore.dart';
import 'package:app/models/tarefa.dart';
import 'package:app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class TarefaRepository extends ChangeNotifier {
  final List<Tarefa> _all = [];
  final List<Tarefa> _today = [];
  late FirebaseFirestore db;
  late AuthService auth;

  TarefaRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await listAll();
    await listToday();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  void add(Tarefa tarefa) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String data = DateFormat('yyyy-MM-dd').format(tarefa.data);
    await db
        .collection('usuarios/${auth.usuario!.uid}/tarefas')
        .doc(timestamp.toString())
        .set({
      'id': timestamp,
      'titulo': tarefa.titulo,
      'descricao': tarefa.descricao,
      'data': tarefa.data,
    });
    await listAll();
    await listToday();
    notifyListeners();
  }

  void update(Tarefa tarefa) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/tarefas')
        .doc(tarefa.id.toString())
        .update({
      'titulo': tarefa.titulo,
      'descricao': tarefa.descricao,
      'data': tarefa.data,
    });
    await listAll();
    await listToday();
    notifyListeners();
  }

  void remove(List<Tarefa> selecionadas) async {
    selecionadas.forEach((tarefa) async {
      await db
          .collection('usuarios/${auth.usuario!.uid}/tarefas')
          .doc(tarefa.id.toString())
          .delete();
    });
    await listAll();
    await listToday();
    notifyListeners();
  }

  listAll() async {
    if (auth.usuario != null) {
      _all.clear();
      try {
        final snapshot =
            await db.collection("usuarios/${auth.usuario!.uid}/tarefas").get();

        for (var doc in snapshot.docs) {
          Tarefa tarefa = Tarefa(
            id: doc.data()['id'],
            titulo: doc.data()['titulo'],
            descricao: doc.data()['descricao'],
            data: (doc.data()['data'] as Timestamp).toDate(),
          );
          _all.add(tarefa);
          notifyListeners();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  listToday() async {
    if (auth.usuario != null) {
      _today.clear();
      try {
        final snapshot =
            await db.collection("usuarios/${auth.usuario!.uid}/tarefas").get();

        for (var doc in snapshot.docs) {
          Tarefa tarefa = Tarefa(
            id: doc.data()['id'],
            titulo: doc.data()['titulo'],
            descricao: doc.data()['descricao'],
            data: (doc.data()['data'] as Timestamp).toDate(),
          );
          if (tarefa.data.day == DateTime.now().day &&
              tarefa.data.month == DateTime.now().month &&
              tarefa.data.year == DateTime.now().year) {
            _today.add(tarefa);
          }
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  List<Tarefa> get all => _all;
  List<Tarefa> get today => _today;
}
