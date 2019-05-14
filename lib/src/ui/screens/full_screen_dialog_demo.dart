import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:record_master/src/ui/widgets/datepicker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

enum DismissDialogAction {
  cancel,
  discard,
  save,
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.subhead,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: date.subtract(const Duration(days: 30)),
                    lastDate: date.add(const Duration(days: 30)),
                  ).then<void>((DateTime value) {
                    if (value != null)
                      onChanged(DateTime(value.year, value.month, value.day,
                          time.hour, time.minute));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(DateFormat('EEE, MMM d yyyy').format(date)),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: theme.dividerColor))),
            child: InkWell(
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: time,
                ).then<void>((TimeOfDay value) {
                  if (value != null)
                    onChanged(DateTime(date.year, date.month, date.day,
                        value.hour, value.minute));
                });
              },
              child: Row(
                children: <Widget>[
                  Text('${time.format(context)}'),
                  const Icon(Icons.arrow_drop_down, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenDialog extends StatefulWidget {
  final String dialogTitle;
  final String barcode;

  FullScreenDialog({this.dialogTitle, this.barcode});

  @override
  FullScreenDialogState createState() => FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  DateTime _fromDate = DateTime.now();
  bool _saveNeeded = false;
  bool _hasLocation = false;
  bool _hasName = false;
  bool _isInAsyncCall_save = false;

  Future<bool> _onWillPop() async {
    _saveNeeded = _hasLocation || _hasName || _saveNeeded;
    if (!_saveNeeded) return true;

    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Discard ${widget.dialogTitle}?',
                style: dialogTextStyle,
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop(
                        false); // Pops the confirmation dialog but not the page.
                  },
                ),
                FlatButton(
                  child: const Text('DISCARD'),
                  onPressed: () {
                    Navigator.of(context).pop(
                        true); // Returning true to _onWillPop will pop again.
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    List s = widget.dialogTitle.split(' ');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dialogTitle),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return FlatButton(
                child: Text('SAVE',
                    style: theme.textTheme.body1.copyWith(color: Colors.white)),
                onPressed: () {
                  saveRecord();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: theme.primaryColor,
                    content: Text(
                      '${s[0]}ing ${s[1]} ....',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 3),
                  ));
                },
              );
            },
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall_save,
        progressIndicator: CircularProgressIndicator(),
        child: Form(
          onWillPop: _onWillPop,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.bottomLeft,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'username',
                    filled: false,
                  ),
                  style: theme.textTheme.subhead,
                  onChanged: (String value) {
                    setState(() {
                      _hasLocation = value.isNotEmpty;
                    });
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DateTimePicker(
                    labelText: 'Return Date',
                    selectedDate: _fromDate,
                    selectDate: (DateTime date) {
                      setState(() {
                        _fromDate = date;
                      });
                    },
                  ),
                ],
              ),
            ].map<Widget>((Widget child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                height: 96.0,
                child: child,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void saveRecord() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    setState(() {
      _isInAsyncCall_save = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isInAsyncCall_save = false;
      });
      Navigator.pop(context, DismissDialogAction.save);
    });
  }
}
