 import 'package:flutter/material.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/images.dart';
import 'package:medosedo_vendor/utill/styles.dart';
import 'package:medosedo_vendor/view/base/custom_app_bar.dart';
import 'package:medosedo_vendor/view/base/custom_button.dart';
import 'package:medosedo_vendor/view/screens/auth/auth_screen.dart';

class SuccessfullyRegisteredScreen extends StatelessWidget {
  const SuccessfullyRegisteredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('shop_application_submission', context)),
      body: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(width: 50,child: Image.asset(Images.success_icon)),
        ),
        Text(getTranslated('shop_register_message1', context)!,style: robotoMedium,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(getTranslated('send', context)!,style: robotoMedium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Text(getTranslated('successfully', context)!,style: robotoMedium.copyWith(color: Colors.green)),
              ),
              Text(getTranslated('to_admin', context)!,style: robotoMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Text(getTranslated('shop_register_message2', context)!),
        ),
      ])),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
      height: 70,child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: CustomButton(btnTxt: getTranslated('login', context), onTap: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => AuthScreen()), (route) => false);
        },),
      ),),
    );
  }
}
