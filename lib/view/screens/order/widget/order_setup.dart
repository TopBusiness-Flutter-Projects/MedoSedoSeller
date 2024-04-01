import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:medosedo_vendor/view/base/custom_button.dart';
import 'package:medosedo_vendor/view/base/textfeild/custom_text_feild.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/data/model/response/order_model.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/order_provider.dart';
import 'package:medosedo_vendor/provider/splash_provider.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/styles.dart';
import 'package:medosedo_vendor/view/base/custom_app_bar.dart';
import 'package:medosedo_vendor/view/base/custom_drop_down_item.dart';
import 'package:medosedo_vendor/view/screens/order/widget/delivery_man_assign_widget.dart';

import '../../../../data/model/response/delivery_man_model.dart';
import '../../../../data/model/response/top_delivery_man.dart';
import '../../../../provider/delivery_man_provider.dart';

class OrderSetup extends StatefulWidget {
  final String? orderType;
  final Order? orderModel;
  final bool onlyDigital;
  const OrderSetup(
      {Key? key, this.orderType, this.orderModel, this.onlyDigital = false})
      : super(key: key);

  @override
  State<OrderSetup> createState() => _OrderSetupState();
}

class _OrderSetupState extends State<OrderSetup> {
  @override
  void initState() {
    Provider.of<DeliveryManProvider>(context, listen: false)
        .deliveryManListURI(context: context, offset: 1, search: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('==order status=>${widget.orderModel!.orderStatus}');
    bool inHouseShipping = false;
    String? shipping = Provider.of<SplashProvider>(context, listen: false)
        .configModel!
        .shippingMethod;
    if (shipping == 'inhouse_shipping' &&
        (widget.orderModel!.orderStatus == 'out_for_delivery' ||
            widget.orderModel!.orderStatus == 'delivered' ||
            widget.orderModel!.orderStatus == 'returned' ||
            widget.orderModel!.orderStatus == 'failed' ||
            widget.orderModel!.orderStatus == 'cancelled')) {
      inHouseShipping = true;
    } else {
      inHouseShipping = false;
    }
    return Consumer<DeliveryManProvider>(
      builder: (context, man, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
              title: getTranslated('order_setup', context),
              isBackButtonExist: true),
          body: Column(
            children: [
              Consumer<OrderProvider>(builder: (context, order, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_MEDIUM,
                    ),
                    inHouseShipping
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Dimensions.PADDING_SIZE_DEFAULT,
                                Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                Dimensions.PADDING_SIZE_DEFAULT,
                                Dimensions.PADDING_SIZE_SMALL),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .5,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(.125)),
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(.12),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.PADDING_SIZE),
                                  child: Text(getTranslated(
                                      widget.orderModel!.orderStatus,
                                      context)!),
                                )),
                          )
                        : CustomDropDownItem(
                            title: 'order_status',
                            widget: DropdownButtonFormField<String>(
                              value: widget.orderModel!.orderStatus,
                              isExpanded: true,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              iconSize: 24,
                              elevation: 16,
                              style: robotoRegular,
                              onChanged: (value) {
                                print('======Selected type==$value======');
                                order.updateOrderStatus(
                                    widget.orderModel!.id, value, context);
                              },
                              items: order.orderStatusList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(getTranslated(value, context)!,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color)),
                                );
                              }).toList(),
                            ),
                          ),
                    CustomDropDownItem(
                      title: 'payment_status',
                      widget: DropdownButtonFormField<String>(
                        value: widget.orderModel!.paymentStatus,
                        isExpanded: true,
                        decoration: InputDecoration(border: InputBorder.none),
                        iconSize: 24,
                        elevation: 16,
                        style: robotoRegular,
                        onChanged: (value) {
                          order.setPaymentMethodIndex(value == 'paid' ? 0 : 1);
                          order.updatePaymentStatus(
                              orderId: widget.orderModel!.id,
                              status: value,
                              context: context);
                        },
                        items: <String>['paid', 'unpaid'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(getTranslated(value, context)!,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color)),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (man.listOfDeliveryMan == null)
                                ? Container()
                                : CustomDropDownItem(
                                    title: 'delivery-man',
                                    widget:
                                        DropdownButtonFormField<DeliveryMan>(
                                      // value: man.selectedDeliveryMan,
                                      isExpanded: true,
                                      hint: Text('اختر رجل التوصيل'),
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: robotoRegular,
                                      onChanged: (value) {
                                        man.selectedDeliveryMan = value;
                                        // order.updatePaymentStatus(
                                        //     orderId: widget.orderModel!.id,
                                        //     status: value,
                                        //     context: context);
                                      },
                                      items: man.listOfDeliveryMan!
                                          .map((DeliveryMan value) {
                                        return DropdownMenuItem<DeliveryMan>(
                                          value: value,
                                          child: Text(
                                              ("${value.fName ?? ''} ${value.lName ?? ''} (${value.phone ?? ''})"),
                                              style: robotoRegular.copyWith(
                                                  color: Colors.black)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_SMALL,
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text('سيحصل موظف التوصيل (EGP)',
                                  style: robotoRegular.copyWith(
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.PADDING_SIZE_DEFAULT,
                                  right: Dimensions.PADDING_SIZE_DEFAULT),
                              child: CustomTextField(
                                controller: man.taxPrice,
                                border: true,
                                hintText: 'Ex:50',
                                isAmount: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.PADDING_SIZE_SMALL,
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text('تاريخ التسليم المتوقع',
                                  style: robotoRegular.copyWith(
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.PADDING_SIZE_DEFAULT,
                                  right: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      icon: Icon(Icons.date_range)),
                                  Flexible(
                                    child: CustomTextField(
                                      controller: man.selectedDate,
                                      border: true,
                                      idDate: true,
                                      hintText: '15-12-1999',
                                      isAmount: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                if (man.selectedDate.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'حدد تاريخ الاستلام');
                                } else if (man.selectedDeliveryMan == null) {
                                  Fluttertoast.showToast(
                                      msg: 'اختر رجل التوصيل');
                                } else {
                                  man.addDeliveryManToOrder(
                                      context: context,
                                      orderId: widget.orderModel!.id!,
                                      status: int.parse("1"));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                                //!
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'تأكيد التسليم',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ),
                    !widget.onlyDigital
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: DeliveryManAssignWidget(
                                orderType: widget.orderType,
                                orderModel: widget.orderModel,
                                orderId: widget.orderModel!.id),
                          )
                        : SizedBox(),
                    //!
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<dynamic> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        Provider.of<DeliveryManProvider>(context, listen: false)
            .selectedDate
            .text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }
}
