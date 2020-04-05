import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hinttextlabel;
  final Function onpressed;

  const InputField({@required this.hinttextlabel, @required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onpressed,
      decoration: InputDecoration(
        hintText: hinttextlabel,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
