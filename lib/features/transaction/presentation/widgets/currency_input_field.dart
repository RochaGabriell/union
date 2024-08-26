/* Flutter Imports */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:union/core/common/widgets/form_field.dart';

class CurrencyInputField extends StatefulWidget {
  final TextEditingController valueController;

  const CurrencyInputField({
    super.key,
    required this.valueController,
  });

  @override
  State<CurrencyInputField> createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  String _formattedValue = '0,00';

  @override
  void initState() {
    super.initState();
    widget.valueController.addListener(_formatInput);
  }

  void _formatInput() {
    String value = widget.valueController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (value.isEmpty) {
      _formattedValue = '0,00';
    } else {
      double parsedValue = double.parse(value) / 100;
      final formatter = NumberFormat.currency(
        locale: 'pt_BR',
        symbol: '',
        decimalDigits: 2,
      );
      _formattedValue = formatter.format(parsedValue);
    }

    widget.valueController.value = TextEditingValue(
      text: _formattedValue,
      selection: TextSelection.collapsed(offset: _formattedValue.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      icon: const Icon(Icons.monetization_on),
      label: 'Valor',
      hint: '0,00',
      keyboardType: TextInputType.number,
      controller: widget.valueController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    widget.valueController.removeListener(_formatInput);
    widget.valueController.dispose();
    super.dispose();
  }
}
