import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_getx/app/core/logger/core_logger.dart';
import 'package:flutter_base_getx/app/di/injection.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';

@singleton
class NetworkInfo extends GetxService {
  final RxBool _isConnected = true.obs;
  final RxBool _isShowingDialog = false.obs;
  final Connectivity _connectivity = Connectivity();
  final logger = getIt<CoreLogger>();
  late BehaviorSubject<ConnectivityResult> _connectivityStream;

  bool get isConnected => _isConnected.value;
  bool get isShowingDialog => _isShowingDialog.value;

  @override
  void onInit() {
    super.onInit();
    _connectivityStream =
        BehaviorSubject<ConnectivityResult>.seeded(ConnectivityResult.wifi);
    _initConnectivity().catchError(_handleError);
  }

  @override
  void onClose() {
    _connectivityStream.close();
    super.onClose();
  }

  /// Initializes connectivity monitoring.
  Future<void> _initConnectivity() async {
    try {
      var initialResult = await _connectivity.checkConnectivity();
      _updateConnectionStatus([initialResult.first]);

      _connectivity.onConnectivityChanged
          .debounceTime(const Duration(milliseconds: 500))
          .listen((result) => _updateConnectionStatus(result))
          .onError(_handleError);
    } catch (e) {
      _handleError(e);
    }
  }

  /// Updates the connection status and shows/hides the no internet dialog.
  void _updateConnectionStatus(List<ConnectivityResult> result) {
    final isOnline = result.first != ConnectivityResult.none;
    _isConnected.value = isOnline;
    _connectivityStream.add(result.first);

    if (!isOnline && !_isShowingDialog.value) {
      _isShowingDialog.value = true;
      logger.i('No internet connection detected');
      _showNoInternetDialog();
    } else if (isOnline && _isShowingDialog.value) {
      logger.i('Internet connection restored');
      Get.back();
      _isShowingDialog.value = false;
    }
  }

  /// Shows a no internet connection dialog.
  void _showNoInternetDialog() {
    Get.snackbar('no internet', '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient:
            LinearGradient(colors: [Colors.blueGrey, Colors.red]),
        backgroundColor: Colors.black38,
        margin: EdgeInsets.only(bottom: 60),
        colorText: Colors.white,
        isDismissible: true,
        icon: Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
        ),
        shouldIconPulse: true,
        snackStyle: SnackStyle.FLOATING, snackbarStatus: (status) {
      if (status == SnackbarStatus.OPEN) {
        _isShowingDialog.value = true;
      }
      if (status == SnackbarStatus.CLOSED) {
        _isShowingDialog.value = false;
      }
    }, duration: Duration(hours: 1));
  }

  /// Handles errors during connectivity checks.
  void _handleError(dynamic error) {
    logger.e('Connectivity check failed: $error');
    if (!kDebugMode) {
      //Sentry.captureException(error, stackTrace: StackTrace.current);
    }
    _isConnected.value = false;
    _connectivityStream.add(ConnectivityResult.none);
  }
}
