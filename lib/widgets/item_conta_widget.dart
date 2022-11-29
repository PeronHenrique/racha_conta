import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conta.dart';
import '../models/item_conta.dart';
import '../models/pessoa.dart';

class ItemContaWidget extends StatefulWidget {
  final ItemConta item;
  const ItemContaWidget({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemContaWidget> createState() => _ItemContaWidgetState();
}

class _ItemContaWidgetState extends State<ItemContaWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Conta conta = Provider.of<Conta>(context, listen: true);
    return GestureDetector(
      child: Dismissible(
        key: ValueKey(widget.item.key),
        direction: DismissDirection.endToStart,
        background: getBackground(context),
        confirmDismiss: (_) => getDialog(context),
        onDismissed: (_) => conta.removeItem(widget.item),
        child: getItemCard(context, widget.item),
      ),
      onLongPress: () {
        //TODO: add edit to item conta
        // Navigator.of(context)
        //     .pushNamed(AppRoutes.itemContaForm, arguments: widget.item)
        //     .then((value) {
        //   // widget.item = value as ItemConta
        // });
      },
    );
  }

  Future<bool?> getDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Deletar item?'),
        content: const Text('Tem certeza que deseja deletar este item?'),
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

  Container getBackground(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Icon(
        Icons.delete,
        size: 30,
        color: Theme.of(context).colorScheme.onError,
      ),
      color: Theme.of(context).colorScheme.error,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
    );
  }

  Widget getItemCard(BuildContext context, ItemConta item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              minLeadingWidth: 80,
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 25,
                child: Text(
                  item.valorStr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              title: Text(
                item.descricao,
                style: const TextStyle(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 30,
                ),
              ),
            ),
          ),
          if (_expanded && !item.pagamento) getItemPessoas(item),
        ],
      ),
    );
  }

  Widget getItemPessoas(ItemConta item) {
    List<Pessoa> pessoas = item.pessoas;
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: pessoas.length,
        itemBuilder: (ctx, i) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              pessoas[i].name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
