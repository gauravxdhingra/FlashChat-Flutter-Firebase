import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hinttextlabel;
  final Function onpressed;
  final bool obscuretext;
  
  final TextInputType kbtp;

  const InputField({
    @required this.hinttextlabel,
    @required this.onpressed,
    this.obscuretext,
    this.kbtp, 
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onpressed,
      obscureText: obscuretext,
      keyboardType: kbtp,
      style: TextStyle(color: Colors.black),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        // labelText: hinttextlabel,
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
