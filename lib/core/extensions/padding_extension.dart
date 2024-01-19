import 'package:flutter/material.dart';

extension CustomPadding on Widget{
  Widget addPadding({double? padding}){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding??16),
      child: this,
    );
  }
  Widget addPaddingLeft({double? padding}){
    return Padding(
      padding: EdgeInsets.only(left: padding??10),
      child: this,
    );
  }
  Widget addPaddingBottom({double? padding}){
    return Padding(
      padding: EdgeInsets.only(bottom: padding??10),
      child: this,
    );
  }

  Widget addPaddingRight({double? padding}){
    return Padding(
        padding: EdgeInsets.only(right: padding??10),
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