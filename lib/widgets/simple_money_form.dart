import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class SimpleMoneyForm extends StatelessWidget {
  const SimpleMoneyForm({Key? key}) : super(key: key);

  void _submit(BuildContext context, String str) {
    str = str.replaceAll('R\$ ', '').replaceAll('.', '');
    int valor = int.tryParse(str) ?? -1;

    if (valor >= 0) {
      Navigator.of(context).pop(valor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
          bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            const Text(
              "Adicionar Pagamento:",
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              inputFormatters: [
                CurrencyTextInputFormatter(
                  decimalDigits: 2,
                  symbol: 'R\$ ',
                )
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor"),
              onFieldSubmitted: (str) => _submit(context, str),
            ),
          ],
        ),
      ),
    );
  }
}
