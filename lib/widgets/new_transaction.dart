import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  //Submitting the data
  void _submiData(BuildContext ctx) {
    final inTitle = _titleController.text;
    final inAmount = double.tryParse(
        _amountController.text == '' ? '0' : _amountController.text);

    //show message in case of invalid data
    if (inTitle.isEmpty || inAmount <= 0) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: const Text(
            'Invalid input!',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    //Adding the data
    widget.addTx(
      inTitle,
      inAmount,
      _selectedDate,
    );
    Navigator.of(context).pop(); //hide the Buttom Sheet Modal
  }

  //Show the date picker to choose a date
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (ctx) => Container(
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: Container(
                height: MediaQuery.of(ctx).size.height,
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                      onSubmitted: (_) => _submiData(ctx),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      onSubmitted: (_) => _submiData(ctx),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDate.format('dd/MM/yyyy'),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onPressed: _presentDatePicker,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                        ),
                      ),
                      child: Text('Add Transaction'),
                      onPressed: () => _submiData(ctx),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
