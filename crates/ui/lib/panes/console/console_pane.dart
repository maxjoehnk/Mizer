import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mizer/state/console_bloc.dart';
import 'package:mizer/widgets/panel.dart';

import '../../protos/console.pb.dart';

final Map<ConsoleLevel, Color> levelColors = {
  ConsoleLevel.DEBUG: Colors.white30,
  ConsoleLevel.INFO: Colors.green.shade300,
  ConsoleLevel.WARNING: Colors.orange.shade300,
  ConsoleLevel.ERROR: Colors.red.shade300,
};

class ConsolePane extends StatefulWidget {
  const ConsolePane({super.key});

  @override
  State<ConsolePane> createState() => _ConsolePaneState();
}

class _ConsolePaneState extends State<ConsolePane> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: "Console",
      child: BlocBuilder<ConsoleCubit, ConsoleState>(
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
          return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ConsoleMessageItem(message: state.messages[index]),
                );
              },
              itemCount: state.messages.length);
        },
      ),
    );
  }
}

class ConsoleMessageItem extends StatelessWidget {
  final ConsoleMessage message;

  const ConsoleMessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            message.level.name.toTitleCase(),
            style: TextStyle(
              color: levelColors[message.level],
            ),
          ),
        ),
        SizedBox(width: 2),
        Text(
          message.message,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Expanded(child: Container()),
        SizedBox(
          width: 100,
          child: Text(
            message.category.name.toTitleCase(),
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.deepOrange.shade200,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          DateFormat.Hms().format(DateTime.fromMillisecondsSinceEpoch(message.timestamp.toInt())),
          style: TextStyle(
            color: Colors.white54,
          ),
        ),
        SizedBox(width: 4),
      ],
    );
  }
}
