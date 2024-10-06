import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class CircularButton extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final double? space;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;
  final bool? loading;
  const CircularButton(
      {super.key,
        this.alignment,
        this.padding,
        this.color,
        this.decoration,
        this.width,
        this.height,
        this.margin,
        this.gradientColorOne,
        this.gradientColorTwo,
        this.shadowColor,
        this.dx,
        this.dy,
        this.gradient,
        this.label,
        this.style,
        this.icon,
        this.fontWeight,
        this.fontStyle,
        this.iconColor,
        this.textColor,
        this.fontSize,
        this.begin,
        this.end,
        this.blurRadius,
        this.spreadRadius,
        this.child,
        this.borderRadius,
        this.onTap,
        this.space,
        this.iconSize,
        this.boxShadow,
        this.loading,
      });

  @override
  Widget build(BuildContext context) {
    // final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        padding: padding,
        height: height ?? 40,
        width: width ?? widths/1.2,
        decoration: BoxDecoration(
            borderRadius:
            borderRadius ?? BorderRadius.circular(30),
            color: color ?? ColorConstant.primaryButtonColor,
            gradient: gradient,
            boxShadow: boxShadow
        ),
        child: child ??  (icon == null
            ? loading == true
            ?  const CircularProgressIndicator(
          color: Colors.white,
        )

            : Text(
          label == null ? "" : label!,
          style: GoogleFonts.alike(
              textStyle: TextStyle(
                  color: textColor ?? ColorConstant.whiteColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight ?? FontWeight.w500)),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor ?? ColorConstant.whiteColor,
              size: iconSize,
            ),
            SizedBox(
              width: space ?? 5,
            ),
            loading == true
                ? const CircularProgressIndicator(
              color: Colors.white,
            )
                :Text(
              label == null ? "" : label!,
              style: GoogleFonts.alike(
                  textStyle: TextStyle(
                      color: textColor ?? ColorConstant.whiteColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight ?? FontWeight.w500)),
            ),
          ],
        )),
      ),
    );
  }
}
