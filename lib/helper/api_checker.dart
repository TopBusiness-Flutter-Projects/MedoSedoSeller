import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medosedo_vendor/data/model/response/base/api_response.dart';
import 'package:medosedo_vendor/provider/auth_provider.dart';
import 'package:medosedo_vendor/view/base/custom_snackbar.dart';
import 'package:medosedo_vendor/view/screens/auth/auth_screen.dart';

class ApiChecker {
  static void checkApi(BuildContext? context, ApiResponse apiResponse) {
    if(apiResponse.error.toString() == 'Failed to load data - status code: 401') {
      Provider.of<AuthProvider>(context!,listen: false).clearSharedData();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
    }else {
      String? _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      showCustomSnackBar(_errorMessage, context);
    }
  }
}