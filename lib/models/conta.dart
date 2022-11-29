import 'dart:math';

import 'package:flutter/material.dart';
import '../models/item_conta.dart';
import '../models/pessoa.dart';

class Conta with ChangeNotifier {
  final Set<Pessoa> _pessoas = {};
  final List<ItemConta> itens = [];
  String _descricao;

  Conta(
    this._descricao, {
    Conta? original,
  }) {
    if (original != null) {
      _pessoas.addAll(original._pessoas);
      itens.addAll(original.itens);
    }
  }

  List<Pessoa> get pessoas => _pessoas.toList();
  int get nPessoas => _pessoas.length;
  int get length => itens.length;
  String get descricao => _descricao;

  set descricao(String descricao) {
    if (descricao.length >= 4) {
      _descricao = descricao;
      notifyListeners();
    }
  }

  void addPessoa(Pessoa pessoa) {
    _pessoas.add(pessoa);
    notifyListeners();
  }

  void removePessoa(Pessoa pessoa) {
    for (int i = 0; i < itens.length; i++) {
      ItemConta item = itens[i];
      item.removePessoa(pessoa);
      if (item.pessoas.isEmpty) {
        itens.remove(item);
        i--;
      }
    }
    _pessoas.remove(pessoa);
    calculoRachaConta();
    notifyListeners();
  }

  void addItem(ItemConta item) {
    itens.add(item);
    calculoRachaConta();
    notifyListeners();
  }

  void removeItem(ItemConta item) {
    itens.remove(item);
    calculoRachaConta();
    notifyListeners();
  }

  void calculoRachaConta() {
    for (Pessoa pessoa in pessoas) {
      pessoa.zeraDivida();
    }

    for (ItemConta item in itens) {
      if (item.pessoas.isEmpty) continue;
      if (item.pagamento) {
        item.pessoas[0].addSaldo(item.valor);
        continue;
      }

      int valorIndividual = item.valor ~/ item.pessoas.length;
      for (Pessoa pessoa in item.pessoas) {
        pessoa.addDivida(valorIndividual);
      }

      int sobra = item.valor - valorIndividual * item.pessoas.length;
      item.pessoas[Random().nextInt(item.pessoas.length)].addDivida(sobra);
    }
  }
}
