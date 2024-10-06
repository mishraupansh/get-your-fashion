import 'package:flutter/material.dart';

class ConstantTextButton extends StatelessWidget {
  final String? label;
  final Function()? onTap;
  final Color? labelColor;
  final  FontWeight? labelWeight;
  final double? labelSize;
  const ConstantTextButton({super.key, this.label, this.onTap, this.labelColor, this.labelWeight,
    this.labelSize,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Text(
          label!,
          style: TextStyle(
              color: labelColor??Colors.orange,
              fontWeight: labelWeight ?? FontWeight.bold,
              fontSize:labelSize ?? 15
          ),
        ));
  }
}
