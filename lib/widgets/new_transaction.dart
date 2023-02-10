import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final submitText = _titleController.text;
    final submitamount = double.parse(_amountController.text);
    if (submitText.isEmpty || submitamount <= 0 || _selectedDate == null)
      return;
    widget.addtx(submitText, submitamount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDayPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1980),
            lastDate: DateTime(2032))
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) => amountInput = value,
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date Choosen'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                ),
                TextButton(
                    onPressed: _presentDayPicker,
                    child: const Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor))
              ]),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('ADD TRANSACTION',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ]),
        ),
      );
}
