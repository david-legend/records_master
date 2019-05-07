import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum actions { check_in, check_out, scan, media }

class HomeScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
            someFunction(allActions[index].key);
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

  someFunction(dynamic key) {
    switch(key) {
      case actions.check_in:
        print('ACTION $key');
        break;
      case actions.check_out:
        print('ACTION $key');
        break;
      case actions.scan:
        print('ACTION $key');
        break;
      case actions.media:
        print('ACTION $key');
        break;
      default:
        print("THIS ISN'T SUPPOSED TO HAPPEN");
      break;
    }
  }
}

class Action {
  final String title;
  final IconData icon;
  final key;

  Action({this.title, this.icon, this.key});
}