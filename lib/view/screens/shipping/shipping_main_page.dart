import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/shipping_provider.dart';
import 'package:medosedo_vendor/view/base/custom_app_bar.dart';
import 'package:medosedo_vendor/view/screens/settings/order_wise_shipping_list_screen.dart';
import 'package:medosedo_vendor/view/screens/shipping/category_wise_shipping.dart';
import 'package:medosedo_vendor/view/screens/shipping/widget/product_wise_shipping.dart';

class ShippingMainPage extends StatelessWidget {
  const ShippingMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('shipping_method', context),),
        body: Consumer<ShippingProvider>(
          builder: (context, shippingProvider,_) {
            return shippingProvider.selectedShippingTypeIndex == 0?
            CategoryWiseShippingScreen():
            shippingProvider.selectedShippingTypeIndex == 1?
            OrderWiseShippingScreen():
            ProductWiseShipping();
          }
        ));
  }
}
