import 'package:flutter/material.dart';
import 'package:bottom_sheet_duration_picker/bottom_sheet_duration_picker.dart';

class StandaloneExamplePage extends StatefulWidget {
  @override
  _StandaloneExamplePageState createState() => _StandaloneExamplePageState();
}

class _StandaloneExamplePageState extends State<StandaloneExamplePage> {
  Duration duration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Standalone"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("${duration.toString()}"),
            RaisedButton(
              child: Text("Pick a duration"),
              onPressed: () async {
                var d = await showDurationPickerBottomSheet(
                    enableDrag: true,
                    themeData: BottomSheetDurationPickerThemeData(
                        bottomSheetThemeData:
                            BottomSheetThemeData(backgroundColor: Colors.amber),
                        dialpadTextStyle: TextStyle(color: Colors.white)),
                    context: context,
                    label: "Pick a duration");
                setState(() {
                  // if the user drags the dialog away a null is returned
                  duration = d ?? duration;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
