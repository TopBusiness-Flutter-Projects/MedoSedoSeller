import 'package:flutter/material.dart';
import 'package:medosedo_vendor/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApplicationSeller extends StatefulWidget {
  const WebViewApplicationSeller({super.key});

  @override
  State<WebViewApplicationSeller> createState() =>
      _WebViewApplicationSellerState();
}

class _WebViewApplicationSellerState extends State<WebViewApplicationSeller> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      //?seller_phone=${value.phone ?? ''
      // ?seller_phone=000000
      ..loadRequest(Uri.parse(
          'https://medosedo.com/categories/?seller_phone=${Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.phone}'));
    // #enddocregion webview_controller

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //
        if (await controller.canGoBack()) {
          await controller.goBack();
        } else {
          Navigator.pop(context);
        }

        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                //
                if (await controller.canGoBack()) {
                  controller.goBack();
                } else {
                  Navigator.pop(context);
                }

                return Future(() => false);
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          title: const Text('ميدو سيدو'),
          elevation: 0,
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
