import 'package:flutter/material.dart';

class Pessoa {
  final String name;
  final Key key;
  int _saldo = 0;

  Pessoa({
    required this.name,
    required this.key,
  });

  String get saldoStr => 'R\$ ${(_saldo / 100).toStringAsFixed(2)}';

  int addDivida(int valor) {
    _saldo -= valor;
    return _saldo;
  }

  int addSaldo(int valor) {
    _saldo += valor;
    return _saldo;
  }

  void zeraDivida() {
    _saldo = 0;
  }

  @override
  operator ==(other) => other is Pessoa && name == other.name;

  @override
  int get hashCode => Object.hash(name, 0);
}
