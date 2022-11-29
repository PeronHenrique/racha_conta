import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_conta.dart';
import 'simple_money_form.dart';
import '../widgets/pessoa_widget.dart';
import '../models/conta.dart';

class ListaPessoasWidget extends StatelessWidget {
  const ListaPessoasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Conta conta = Provider.of<Conta>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: conta.nPessoas,
        itemBuilder: (ctx, i) => Row(
          children: [
            PessoaWidget(
                pessoa: conta.pessoas[i],
                addPayment: () => addPayment(context, conta, i),
                onDelete: () => getDialog(context).then((value) {
                      if (value ?? false) {
                        conta.removePessoa(conta.pessoas[i]);
                      }
                    })),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Future<bool?> getDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Deletar pessoa?'),
        content: const Text('Tem certeza que deseja deletar este pessoa?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
              child: const Text('Sim')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text('Não')),
        ],
      ),
    );
  }
}

void addPayment(BuildContext context, Conta conta, int index) {
  String name = conta.pessoas[index].name;
  showModalBottomSheet<int>(
    context: context,
    builder: (_) => const SimpleMoneyForm(),
  ).then((valor) => conta.addItem(ItemConta(
        descricao: "Pagamento $name",
        valor: valor!,
        pagamento: true,
        key: UniqueKey(),
        pessoas: [conta.pessoas[index]],
      )));
}
