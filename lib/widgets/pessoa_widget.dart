import 'package:flutter/material.dart';

import '../models/pessoa.dart';

class PessoaWidget extends StatelessWidget {
  final Pessoa pessoa;
  final void Function() onDelete;
  final void Function() addPayment;

  const PessoaWidget({
    required this.pessoa,
    required this.onDelete,
    required this.addPayment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        elevation: 5,
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 33,
                child: Text(
                  pessoa.saldoStr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
              Text(
                pessoa.name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      onLongPress: () => onDelete(),
      onDoubleTap: () => addPayment(),
    );
  }
}
