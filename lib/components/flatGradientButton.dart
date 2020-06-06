import 'package:flutter/material.dart';

class FlatGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const FlatGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.5,
          ),
        ],
        
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
