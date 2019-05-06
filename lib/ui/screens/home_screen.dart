import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  
  List<Action> allActions = [
    Action(
      title: 'Check In',
      icon: Icons.add
    ),
    Action(
        title: 'Check Out',
        icon: Icons.phone_iphone
    ),
    Action(
        title: 'Scan',
        icon: Icons.scanner
    ),
    Action(
        title: 'Media',
        icon: Icons.map
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
          onPressed:(){},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  allActions[index].icon,
                  size: 80.0,
                  color: Color(0xFF003D75),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Text(
                  allActions[index].title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.subhead.copyWith(
                    fontFamily: 'PT_Sans',
                    color: Color(0xFF003D75),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Action {
  final String title;
  final IconData icon;

  Action({this.title, this.icon});
}