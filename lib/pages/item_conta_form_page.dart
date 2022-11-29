import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item_conta.dart';
import '../models/conta.dart';
import '../models/pessoa.dart';

class ItemContaForm extends StatelessWidget {
  const ItemContaForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Conta conta = Provider.of<Conta>(context, listen: true);
    // List<String> nomesPessoas = conta.pessoas.map((e) => e.name).toList();
    List<bool> checkedList = conta.pessoas.map((e) => false).toList();
    String descricaoItem = '';
    int preco = 0;

    // final ItemConta? args =
    //     ModalRoute.of(context)!.settings.arguments as ItemConta?;

    // String descricaoItem = args?.descricao ?? '';
    // int preco = args?.valor ?? 0;
    // args?.removeAllPessoas();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Criar novo Item'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              initialValue: descricaoItem,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(labelText: 'Descrição do Item'),
              onChanged: (String str) {
                if (_validateDescricao(str)) {
                  descricaoItem = str;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              // initialValue: args?.valorStr,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(labelText: 'Preço'),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  decimalDigits: 2,
                  symbol: 'R\$ ',
                )
              ],
              keyboardType: TextInputType.number,
              onChanged: (String str) {
                int precoStr = _validatePreco(str);
                if (precoStr >= 0) {
                  preco = precoStr;
                }
              },
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: conta.nPessoas,
              itemBuilder: (ctx, i) {
                return _PessoaCheckBox(
                  name: conta.pessoas[i].name,
                  onChanged: (bool checked) {
                    checkedList[i] = checked;
                    // if (args != null) {
                    //   if (checked) {
                    //     args.addPessoa(conta.pessoas[i]);
                    //   } else {
                    //     args.removePessoa(conta.pessoas[i]);
                    //   }
                    // }
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              // if (args != null) {
              //   Navigator.of(context).pop();
              // }

              List<Pessoa> pessoasChecked = [];
              for (int i = 0; i < conta.nPessoas; i++) {
                if (checkedList[i]) {
                  pessoasChecked.add(conta.pessoas[i]);
                }
              }

              if (pessoasChecked.isNotEmpty &&
                  preco > 0 &&
                  descricaoItem.isNotEmpty) {
                ItemConta item = ItemConta(
                  descricao: descricaoItem,
                  valor: preco,
                  key: UniqueKey(),
                  pessoas: pessoasChecked,
                );
                Navigator.of(context).pop(item);
              }
            },
            child: const Text(
              'Salvar',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }

  bool _validateDescricao(String str) {
    if (str.trim().isEmpty) return false;
    if (str.length < 4) return false;
    return true;
  }

  int _validatePreco(String str) {
    str = str.replaceAll('R\$ ', '').replaceAll('.', '');
    return int.tryParse(str) ?? -1;
  }
}

class _PessoaCheckBox extends StatefulWidget {
  final String name;
  final void Function(bool) onChanged;

  const _PessoaCheckBox({
    required this.name,
    required this.onChanged,
  });

  @override
  State<_PessoaCheckBox> createState() => _PessoaCheckBoxState();
}

class _PessoaCheckBoxState extends State<_PessoaCheckBox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        widget.name,
        textAlign: TextAlign.center,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: _checked,
      onChanged: (bool? value) {
        setState(() {
          _checked = value ?? false;
          widget.onChanged(_checked);
        });
      },
    );
  }
}
