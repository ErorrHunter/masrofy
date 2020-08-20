import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtran;

  NewTransaction(this.addtran);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredPrice = double.parse(amountController.text);
    if (enteredPrice <= 0 || enteredTitle.isEmpty||selectedDate==null) {
      return;
    }
    widget.addtran(enteredTitle, enteredPrice,selectedDate);
    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData,
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'price'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            Container(
                height: 50,
                child: Row(children: <Widget>[
                  Expanded(
                      child: Text(selectedDate == null
                          ? 'No Date picked'
                          : DateFormat.yMd().format(selectedDate))),
                  FlatButton(
                    child: Text('choose a date'),
                    onPressed: datePicker,
                  ),
                ])),
            RaisedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purpleAccent),
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
