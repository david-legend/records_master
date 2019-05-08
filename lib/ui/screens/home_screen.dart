import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum actions { check_in, check_out, scan, media }
enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}
const String _alertWithoutTitleText = 'Discard draft?';

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
  final List<Action> allActions = [
    Action(
      title: 'Check In',
      icon: MdiIcons.login,
      key: actions.check_in

    ),
    Action(
      title: 'Check Out',
      icon: MdiIcons.logout,
      key: actions.check_out
    ),
    Action(
      title: 'Scan',
      icon: MdiIcons.qrcodeScan,
      key: actions.scan
    ),
    Action(
      title: 'Media',
      icon: MdiIcons.map,
      key: actions.media
    ),
  ];

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
          //retry scan
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return GridView.count(
      // Create a grid with 2 columns.
      crossAxisCount: 2,
      // Generate 100 Widgets that display their index in the List
      children: List.generate(allActions.length, (index) {
        return RawMaterialButton(
          padding: EdgeInsets.zero,
          splashColor: theme.primaryColor.withOpacity(0.12),
          highlightColor: Colors.transparent,
          onPressed: (){
            someFunction(allActions[index].key, context: context);
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
    );
  }

  someFunction(dynamic key, {BuildContext context}) {
    switch(key) {
      case actions.check_in:
        print('ACTION $key');
        break;
      case actions.check_out:
        print('ACTION $key');
        break;
      case actions.scan:
        print('ACTION $key');
        scan();
//        navigateToDestination(context, "/scan");
        break;
      case actions.media:
        print('ACTION $key');
        break;
      default:
        print("THIS ISN'T SUPPOSED TO HAPPEN");
      break;
    }
  }

  navigateToDestination(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  dialog() {
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
            onPressed: () { Navigator.pop(context, DialogDemoAction.cancel); },
          ),
          FlatButton(
            child: const Text('DISCARD'),
            onPressed: () { Navigator.pop(context, DialogDemoAction.discard); },
          ),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
        dialog();
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}


//TODO: 1. enable scan
//TODO: 2. dialog onback press
//TODO: 3. dialog when there is no internet
//TODO: 4. full screen dialog when qr code is how we want it.
//TODO: 5. dialog when qr code is not what we issued.
//TODO: 6. repeat the above for check in and check out..
//TODO: 7. Brain storm account and settings screen..