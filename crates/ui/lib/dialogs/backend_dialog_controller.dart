import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/protos/ui.pb.dart';
import 'package:provider/provider.dart';

import 'package:mizer/dialogs/backend_dialog.dart';

class BackendDialogController extends StatefulWidget {
  final Widget child;

  const BackendDialogController({required this.child, super.key});

  @override
  State<BackendDialogController> createState() => _BackendDialogControllerState();
}

class _BackendDialogControllerState extends State<BackendDialogController> {
  StreamSubscription<ShowDialog>? _dialogSubscription;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    _dialogSubscription = context.read<UiApi>().dialogRequests().listen((request) {
      if (!context.mounted) {
        return;
      }
      showDialog(
          context: context,
          builder: (context) => BackendDialog(dialogRequest: request)
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dialogSubscription?.cancel();
  }
}
