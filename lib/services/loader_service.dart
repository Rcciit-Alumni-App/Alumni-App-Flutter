import 'package:flutter/material.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderService {
  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  OverlayEntry? _overlayEntry;

  LoaderService() {
    _navigationService = _getIt.get<NavigationService>();
  }

  void showLoader() {
    try {
      final context = _navigationService.navigatorKey.currentContext;
      if (context == null) {
        print('Context is null');
        return;
      }

      final overlay = Overlay.of(context);
      if (overlay == null) {
        print('Overlay not found');
        return;
      }

      _overlayEntry = _createOverlayEntry();
      overlay.insert(_overlayEntry!);
    } catch (e) {
      print('Error showing loader: $e');
    }
  }

  void hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      print('Error hiding loader: $e');
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: LoadingAnimationWidget.inkDrop(
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
