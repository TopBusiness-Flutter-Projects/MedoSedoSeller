import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/data/model/response/product_model.dart';
import 'package:medosedo_vendor/localization/language_constrants.dart';
import 'package:medosedo_vendor/provider/auth_provider.dart';
import 'package:medosedo_vendor/provider/product_provider.dart';
import 'package:medosedo_vendor/provider/shop_provider.dart';
import 'package:medosedo_vendor/utill/dimensions.dart';
import 'package:medosedo_vendor/utill/styles.dart';
import 'package:medosedo_vendor/view/base/custom_app_bar.dart';
import 'package:medosedo_vendor/view/screens/product/product_details_review_screen.dart';
import 'package:medosedo_vendor/view/screens/product/widget/product_details_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? productModel;
  const ProductDetailsScreen({Key? key, this.productModel}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;

  void load(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false)
        .getProductWiseReviewList(context, 1, widget.productModel!.id);
    Provider.of<ProductProvider>(context, listen: false)
        .getProductDetails(context, widget.productModel!.id);
    Provider.of<SellerProvider>(context, listen: false)
        .getCategoryList(context, null, 'en');
  }

  @override
  void initState() {
    super.initState();
    load(context);
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);

    _tabController?.addListener(() {
      print('my index is' + _tabController!.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: getTranslated('product_details', context),
          isBackButtonExist: true,
          isSwitch: (widget.productModel!.requestStatus == 1) ? true : false,
          isAction: true,
          productSwitch: true,
          switchAction: (value) {
            if (value == true) {
              Provider.of<ProductProvider>(context, listen: false)
                  .productStatusOnOff(context, widget.productModel!.id, 1);
            } else {
              Provider.of<ProductProvider>(context, listen: false)
                  .productStatusOnOff(context, widget.productModel!.id, 0);
            }
            setState(() {});
          },
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            load(context);
          },
          child:
              Consumer<AuthProvider>(builder: (authContext, authProvider, _) {
            return Column(children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).cardColor,
                  child: TabBar(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    controller: _tabController,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Theme.of(context).hintColor,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 1,
                    unselectedLabelStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: [
                      Tab(text: getTranslated("product_details", context)),
                      Tab(text: getTranslated("reviews", context)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  ProductDetailsWidget(productModel: widget.productModel),
                  ProductReviewScreen(productModel: widget.productModel),
                ],
              )),
            ]);
          }),
        ));
  }
}
