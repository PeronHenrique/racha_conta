import 'package:flutter/material.dart';
import '../models/pessoa.dart';

class ItemConta {
  final String descricao;
  final int valor;
  final Key key;
  final bool pagamento;
  final Set<Pessoa> _pessoas = {};

  ItemConta({
    this.pagamento = false,
    required this.descricao,
    required this.valor,
    required this.key,
    List<Pessoa>? pessoas,
  }) {
    if (pessoas != null) {
      _pessoas.addAll(pessoas);
    }
  }

  void addPessoa(Pessoa pessoa) {
    _pessoas.add(pessoa);
  }

  void removePessoa(Pessoa pessoa) {
    if (_pessoas.contains(pessoa)) _pessoas.remove(pessoa);
  }

  List<Pessoa> get pessoas => _pessoas.toList();
  String get valorStr => 'R\$ ${(valor / 100).toStringAsFixed(2)}';

  void removeAllPessoas() {
    _pessoas.removeWhere((a) => true);
  }
}
