import 'dart:async';
import 'package:flutter/material.dart';
class LoaderService {
  final _loadingStreamController = StreamController<bool>.broadcast();

  Stream<bool> get loadingStream => _loadingStreamController.stream;

  void showLoader() {
    _loadingStreamController.add(true);
  }

  void hideLoader() {
    _loadingStreamController.add(false);
  }

  void dispose() {
    _loadingStreamController.close();
  }
}

class LoaderWidget extends StatelessWidget {
  final LoaderService loaderService;

  LoaderWidget({required this.loaderService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: loaderService.loadingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
