import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/plugin/nodes.dart';
import 'package:mizer/widgets/inputs/color.dart';

class ColorRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  ColorRenderer(this.pluginApi, this.path);

  @override
  State<ColorRenderer> createState() => _ColorRendererState(pluginApi.getHistoryPointer(path));
}

class _ColorRendererState extends State<ColorRenderer> {
  final Future<NodeHistoryPointer> previewRef;

  _ColorRendererState(this.previewRef);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder(
          future: previewRef,
          builder: (context, AsyncSnapshot<NodeHistoryPointer> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            return ColorPreview(pointer: snapshot.requireData);
          },
        ));
  }
}

class ColorPreview extends StatefulWidget {
  final NodeHistoryPointer pointer;

  const ColorPreview({required this.pointer, Key? key}) : super(key: key);

  @override
  State<ColorPreview> createState() => _ColorPreviewState(pointer);
}

class _ColorPreviewState extends State<ColorPreview> with SingleTickerProviderStateMixin {
  final NodeHistoryPointer pointer;
  late final Ticker ticker;
  ColorValue? color;

  _ColorPreviewState(this.pointer);

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      setState(() {
        color = pointer.readColor();
      });
    });
    ticker.start();
  }

  @override
  void dispose() {
    ticker.dispose();
    pointer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return Container();
    }
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: _color),
      margin: const EdgeInsets.all(8),
    );
  }

  Color get _color {
    return Color.fromARGB(
        255, (color!.red * 255).toInt(), (color!.green * 255).toInt(), (color!.blue * 255).toInt());
  }
}
