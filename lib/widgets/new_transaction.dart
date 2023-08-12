import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //here we dont loss data after flutter re-evaluates
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return; //stops if no input is given or negative amount
    }
    widget.addTx(
      //using widget.addTX we can use tx even though its from another class
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop(); //close top most screeent that is displayed
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
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
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),

                //onChanged:(val){
                //  TitleInput=val;
                // } ,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>
                    submitData(), //we are creating an anonymous function to execute the function only when text field is submitted
                //onChanged: (val)=>amountInput=val,
              ), //this is to take user input
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(selectedDate.isNull
                            ? 'No Date Chosen!'
                            : 'PickedDate:${DateFormat.yMd().format(selectedDate)})')),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text("Add Transcation"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorLight,
                    textStyle:
                    TextStyle(color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
