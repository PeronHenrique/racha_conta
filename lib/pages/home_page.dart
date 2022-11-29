import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conta.dart';
import '../models/item_conta.dart';
import '../models/pessoa.dart';
import '../utils/app_routes.dart';
import '../widgets/lista_pessoas_widget.dart';
import '../widgets/simple_string_form.dart';
import '../widgets/item_conta_widget.dart';

enum MenuOption {
  changeDescricao,
  removePessoa,
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Conta conta = Provider.of<Conta>(context, listen: true);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _getAppBar(context, conta),
      body: Column(
        children: [
          const ListaPessoasWidget(),
          Container(
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            height: 550,
            child: ListView.builder(
              itemCount: conta.length,
              itemBuilder: (ctx, i) => Column(
                children: [
                  ItemContaWidget(item: conta.itens[i]),
                  const Divider()
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AppRoutes.itemContaForm)
              .then((value) => conta.addItem(value as ItemConta));
        },
      ),
    );
  }

  void showFormPessoa(BuildContext context, Conta conta) {
    showModalBottomSheet<String>(
      context: context,
      builder: (_) => const SimpleStringForm(
        descricao: "Nome",
        strLength: 2,
      ),
    ).then((str) {
      if (str != null) {
        conta.addPessoa(Pessoa(name: str, key: UniqueKey()));
      }
    });
  }

  void showFormDescricaoConta(BuildContext context, Conta conta) {
    showModalBottomSheet<String>(
      context: context,
      builder: (_) => const SimpleStringForm(
        descricao: "Descrição Conta",
        strLength: 4,
      ),
    ).then((str) => conta.descricao = str ?? conta.descricao);
  }

  AppBar _getAppBar(BuildContext context, Conta conta) {
    return AppBar(
      title: Text(conta.descricao),
      actions: [
        IconButton(
          onPressed: () => showFormPessoa(context, conta),
          icon: const Icon(Icons.person_add_alt_sharp),
        ),
        IconButton(
          onPressed: () => showFormDescricaoConta(context, conta),
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }
}
