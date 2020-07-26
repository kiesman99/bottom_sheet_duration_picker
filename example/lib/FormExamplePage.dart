import 'package:bottom_sheet_duration_picker/bottom_sheet_duration_picker.dart';
import 'package:flutter/material.dart';

class FormExamplePage extends StatefulWidget {
  @override
  _FormExamplePageState createState() => _FormExamplePageState();
}

class _FormExamplePageState extends State<FormExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Example"),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("This Form field will show an error if the given duration is more than 50 minutes."),
              ),
              DurationPickerFormField(
                title: "Duration",
                autovalidate: true,
                initialValue: Duration(minutes: 5),
                // ignore: missing_return
                validator: (Duration d) {
                  if (
                    d.inMinutes.remainder(60) > 50 ||
                        (d.inMinutes.remainder(60) >= 50 && d.inSeconds.remainder(60) > 0)
                  ) {
                    return "More than 50 minutes";
                  }
                },
                labelBuilder: (Duration d) {
                  return "${d.inMilliseconds}ms";
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
