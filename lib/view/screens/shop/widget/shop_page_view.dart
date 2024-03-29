import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/data/model/response/product_model.dart';
import 'package:medosedo_vendor/provider/product_provider.dart';
import 'package:medosedo_vendor/provider/shop_info_provider.dart';
import 'package:medosedo_vendor/view/screens/review/product_review_screen.dart';
import 'package:medosedo_vendor/view/screens/shop/widget/shop_product_list.dart';

class ShopPageView extends StatelessWidget {
  const ShopPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
    builder: (context,shopProvider,child){
      return shopProvider.selectedIndex == 0?
      Consumer<ProductProvider>(
          builder: (context, prodProvider, child) {
            List<Product> productList;
            productList = prodProvider.sellerProductList;

            print('===length==>$productList');
            return ShopProductList(productList: productList);
          }
      ):
      ProductReview();

    }

    );
  }
}
