import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class AlertService {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  AlertService() {
    _navigationService = _getIt.get<NavigationService>();
  }
  void showSnackBar({required String message, IconData icon = Icons.info, Color color = Colors.blue}) {
    try {
      DelightToastBar(
        snackbarDuration: Duration(seconds: 2),
        autoDismiss: true,
        position: DelightSnackbarPosition.top,
        builder: (context) => ToastCard(
          leading: Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),
          title: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          color: color,
        ),
      ).show(
        _navigationService.navigatorKey.currentContext!,
      );
    } catch (e) {
      print(e);
    }
  }
}