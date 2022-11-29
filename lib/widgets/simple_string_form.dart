import 'package:flutter/material.dart';

class SimpleStringForm extends StatelessWidget {
  final String descricao;
  final int strLength;

  const SimpleStringForm(
      {required this.descricao, required this.strLength, Key? key})
      : super(key: key);

  bool _validate(String str) {
    if (str.trim().isEmpty) return false;
    if (str.length < strLength) return false;
    return true;
  }

  void _submit(BuildContext context, String str) {
    if (_validate(str)) {
      Navigator.of(context).pop(str);
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
            Text(
              '$descricao:',
              style: const TextStyle(fontSize: 20),
            ),
            TextFormField(
              initialValue: "",
              onFieldSubmitted: (str) => _submit(context, str),
            ),
          ],
        ),
      ),
    );
  }
}
