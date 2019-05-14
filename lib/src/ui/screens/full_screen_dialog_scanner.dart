import 'dart:async';

import 'package:flutter/material.dart';

enum DialogActions {
  cancel,
  discard,
  save,
}

class ScannerFullScreenDialog extends StatefulWidget {
  final String dialogTitle;
  final String barcode;

  ScannerFullScreenDialog({this.dialogTitle, this.barcode});

  @override
  ScannerFullScreenDialogState createState() => ScannerFullScreenDialogState();
}

class ScannerFullScreenDialogState extends State<ScannerFullScreenDialog> {
  Future<bool> _onWillPop() async {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'Close ${widget.dialogTitle}?',
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
                  child: const Text('CLOSE'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dialogTitle),
        actions: <Widget>[],
      ),
      body: Form(
        onWillPop: _onWillPop,
        child: ListView(
//          padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  listofInfo('Title', 'The 1992 Constitution', Icons.book),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  listofInfo('Location', 'Container/root', Icons.location_on),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  listofInfo('Pages', '900 pages', Icons.games),
                  Divider(
                    color: Colors.grey[500],
                  ),
                  listofInfo('Size', '28 MB', Icons.map),
                  Divider(
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget listofInfo(String title, String subtitle, IconData icon) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              fontFamily: "Roboto",
            )),
      ),
    );
  }
}
