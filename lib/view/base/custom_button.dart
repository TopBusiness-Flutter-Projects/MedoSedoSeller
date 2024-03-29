import 'package:flutter/material.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/styles.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final bool isColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? borderRadius;
  CustomButton({this.onTap, required this.btnTxt, this.backgroundColor, this.isColor = false, this.fontColor, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isColor? backgroundColor : backgroundColor != null ?
            backgroundColor : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadius != null? borderRadius! : Dimensions.PADDING_SIZE_EXTRA_SMALL)),
        child: Text(btnTxt!,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              color: fontColor != null? fontColor : Colors.white,
            )),
      ),
    );
  }
}
