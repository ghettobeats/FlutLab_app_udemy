import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addtx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(this.addtx);
  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.datetime,
              // onChanged: (value) => amountInput = value,
            ),
            TextButton(
              onPressed: () => {
                addtx(
                  titleController.text,
                  double.parse(amountController.text),
                )
              },
              child: Text('Add Transactions',
                  style: TextStyle(
                    color: Colors.purple,
                  )),
            )
          ]),
        ),
      );
}
