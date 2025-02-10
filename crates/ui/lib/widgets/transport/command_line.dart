import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizer/api/contracts/ui.dart';
import 'package:mizer/consts.dart';
import 'package:mizer/extensions/context_state_extensions.dart';
import 'package:mizer/widgets/text_field_focus.dart';
import 'package:provider/provider.dart';

class CommandLineInput extends StatefulWidget {
  const CommandLineInput({super.key});

  @override
  State<CommandLineInput> createState() => _CommandLineInputState();
}

class _CommandLineInputState extends State<CommandLineInput> {
  TextEditingController controller = TextEditingController(text: '');
  FocusNode focusNode = FocusNode();
  bool success = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: TRANSPORT_CONTROLS_HEIGHT - 8,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black26),
      ),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          if (!focusNode.hasFocus && controller.text.isEmpty)
            Center(
                child: Text("Command Line",
                    style: textTheme.bodyMedium!.copyWith(color: Colors.white54))),
          if (success) Positioned(child: Icon(Icons.check, color: Colors.green), right: 4),
          if (error)
            Positioned(child: Icon(Icons.warning_amber_outlined, color: Colors.red), right: 4),
          Center(
              child: TextFieldFocus(
                child: EditableText(
                  controller: controller,
                  focusNode: focusNode,
                  style: textTheme.bodyMedium!,
                  autocorrect: false,
                  showCursor: true,
                  cursorColor: Colors.black87,
                  backgroundCursorColor: Colors.black12,
                  textAlign: TextAlign.start,
                  selectionColor: Colors.black38,
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                  onSubmitted: (value) {
                    execute(value);
                    controller.clear();
                    focusNode.requestFocus();
                  },
                ),
              )),
        ],
      ),
    );
  }

  void execute(String cmd) {
    context.read<UiApi>().commandLineExecute(cmd).then((value) {
      setIconState(success: true);
      context.refreshAllStates();
      Future.delayed(Duration(seconds: 3)).then((value) => setIconState());
    }).catchError((err) {
      setIconState(error: true);
      Future.delayed(Duration(seconds: 3)).then((value) => setIconState());
    });
  }

  void setIconState({ bool success = false, bool error = false }) {
    setState(() {
      this.success = success;
      this.error = error;
    });
  }
}
