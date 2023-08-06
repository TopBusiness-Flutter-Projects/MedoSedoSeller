import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/helper/price_converter.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/refund_provider.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/styles.dart';
import 'package:medosedo_vendor/view/base/custom_divider.dart';
import 'package:medosedo_vendor/view/screens/refund/widget/refund_details.dart';

class RefundPricingWidget extends StatelessWidget {
  const RefundPricingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( bottom: Dimensions.PADDING_SIZE_SMALL),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Consumer<RefundProvider>(
            builder: (context, refund,_) {
              return Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.PADDING_SIZE_SMALL),
                child: refund.refundDetailsModel != null?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  ProductCalculationItem(title: 'product_price',price: refund.refundDetailsModel!.productPrice,isQ: true, isPositive: true,),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                  ProductCalculationItem(title: 'product_discount',price: refund.refundDetailsModel!.productTotalDiscount, isNegative: true,),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  ProductCalculationItem(title: 'coupon_discount',price: refund.refundDetailsModel!.couponDiscount, isNegative: true,),


                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  ProductCalculationItem(title: 'product_tax',price: refund.refundDetailsModel!.productTotalTax, isPositive: true,),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  ProductCalculationItem(title: 'subtotal',price: refund.refundDetailsModel!.subtotal),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  CustomDivider(),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                  Row(children: [
                    Text('${getTranslated('total_refund_amount', context)}',
                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.FONT_SIZE_DEFAULT),),
                    Spacer(),
                    Text('${PriceConverter.convertPrice(context,
                        refund.refundDetailsModel!.refundAmount)}',
                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.FONT_SIZE_LARGE),),
                  ],),


                ]):SizedBox(),);}),
      ),
    );
  }
}
