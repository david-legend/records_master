import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

import 'full_screen_dialog_demo.dart';
import 'full_screen_dialog_scanner.dart';

//Represents Major actions performed on home screen
enum actions { check_in, check_out, scan, media }

//Used as titles passed down to the full screen dialog
List<String> actions_string = ['Check In', 'Check Out', 'Scan'];

//actions that could be performed when dialog pops up
enum DialogDemoAction { cancel, discard, disagree, agree }

//title for dialog and user fails to scan (on back press)
const String _alertWithoutTitleText = 'Failed to scan?';

class Action {
  final String title;
  final IconData icon;
  final key;

  Action({this.title, this.icon, this.key});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInAsyncCall_scan_finish = false;
  final List<Action> allActions = [
    Action(title: 'Check In', icon: MdiIcons.login, key: actions.check_in),
    Action(title: 'Check Out', icon: MdiIcons.logout, key: actions.check_out),
    Action(title: 'Scan', icon: MdiIcons.qrcodeScan, key: actions.scan),
    Action(title: 'Media', icon: MdiIcons.map, key: actions.media),
  ];

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        //retry scan
      }
    });
  }

  //this dialog pops up when user press the back button and fails to scan
  //while scanner is active
  dialog(dynamic actionType) {
    showDemoDialog<DialogDemoAction>(
      context: context,
      child: AlertDialog(
        content: Text(
          _alertWithoutTitleText,
//          style: dialogTextStyle,
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context, DialogDemoAction.cancel);
            },
          ),
          FlatButton(
            child: const Text('RETRY'),
            onPressed: () {
              //onpress of retry triggers the scanner again
              scan(actionType);
              Navigator.pop(context, DialogDemoAction.cancel);
            },
          ),
        ],
      ),
    );
  }

  showfullScreenDialog(String title, {String barcode}) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute<DismissDialogAction>(
          builder: (BuildContext context) => FullScreenDialog(
                dialogTitle: title,
              ),
          fullscreenDialog: true,
        ));

    print('Saved Successfully');
    Toast.show("$title successful", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  showScanFullScreenDialog(String title, {String barcode}) {
    Navigator.push(
        context,
        MaterialPageRoute<DismissDialogAction>(
          builder: (BuildContext context) => ScannerFullScreenDialog(
                dialogTitle: title,
              ),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall_scan_finish,
      progressIndicator: CircularProgressIndicator(),
      child: GridView.count(
        // Create a grid with 2 columns.
        crossAxisCount: 2,
        // Generate a number(depends on the length of the allActions variable)
        // widgets that display action icons in a grid
        children: List.generate(allActions.length, (index) {
          return RawMaterialButton(
            padding: EdgeInsets.zero,
            splashColor: theme.primaryColor.withOpacity(0.12),
            highlightColor: Colors.transparent,
            onPressed: () {
              scan(allActions[index].key);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    allActions[index].icon,
                    size: 80.0,
                    color: theme.primaryColorDark,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: 48.0,
                  alignment: Alignment.center,
                  child: Text(
                    allActions[index].title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.display1,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  //Determines which action to perform based on actionType
  determineWhichActionToPerform(dynamic actionType) {
    switch (actionType) {
      case actions.check_in:
        fakeNetworkCall(0);
//        showfullScreenDialog(actions_string[0]);
        break;
      case actions.check_out:
        fakeNetworkCall(1);
//        showfullScreenDialog(actions_string[1]);
        break;
      case actions.scan:
        fakeNetworkCall(2);
        break;
        break;
      default:
        print("THIS ISN'T SUPPOSED TO HAPPEN");
        break;
    }
  }

  //triggers or performs the actual scan
  Future scan(dynamic actionType) async {
    try {
      String barcode = await BarcodeScanner.scan();
      print('ACTION BEING PERFORMED: $actionType');

      determineWhichActionToPerform(actionType);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        //'The user did not grant the camera permission!';
      } else {
        //this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      dialog(actionType);
      //setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      //setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  void fakeNetworkCall(int index) {
    setState(() {
      _isInAsyncCall_scan_finish = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isInAsyncCall_scan_finish = false;
      });
      if (index == 2) {
        showScanFullScreenDialog('Results');
      } else {
        showfullScreenDialog(actions_string[index]);
      }
    });
  }

  //navigates to a different screen when route is passed
  navigateToDestination(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}

//TODO: 1. enable scan  --- done
//TODO: 2. dialog onback press  ---done
//TODO: 6. repeat the above for check in and check out.. ---done
//TODO: 4. full screen dialog when qr code is how we want it.

//TODO: 3. dialog when there is no internet
//TODO: 5. dialog when qr code is not what we issued.

//TODO: 7. Brain storm account and settings screen..
