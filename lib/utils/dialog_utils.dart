import 'package:flutter/cupertino.dart';
import 'package:note_app/app_dependencies.dart';
import 'package:note_app/routes/app_router.dart';

class DialogUtils {
  Future<void> showSimpleMessage({
    required BuildContext context,
    required String message,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            message,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                getIt<AppRouter>().pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmation({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            message,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                getIt<AppRouter>().pop();
              },
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                getIt<AppRouter>().pop();
                onConfirm.call();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
