import 'package:flutter/material.dart';

extension CustomPadding on Widget{
  Widget addPadding({double? padding}){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding??16),
      child: this,
    );
  }
}

//for same container use extension

extension Decor on Container{
  Container adddecor(){
    return Container(
      decoration: this.decoration,
    );
  }
}