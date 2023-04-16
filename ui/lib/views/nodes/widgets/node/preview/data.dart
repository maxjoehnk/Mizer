import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mizer/api/plugin/ffi/history.dart';
import 'package:mizer/api/plugin/nodes.dart';

class DataRenderer extends StatefulWidget {
  final NodesPluginApi pluginApi;
  final String path;

  DataRenderer(this.pluginApi, this.path);

  @override
  State<DataRenderer> createState() => _DataRendererState(pluginApi.getHistoryPointer(path));
}

class _DataRendererState extends State<DataRenderer> {
  final Future<NodeHistoryPointer> previewRef;

  _DataRendererState(this.previewRef);

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

            return DataTree(pointer: snapshot.requireData);
          },
        ));
  }
}

class DataTree extends StatefulWidget {
  final NodeHistoryPointer pointer;

  const DataTree({required this.pointer, Key? key}) : super(key: key);

  @override
  State<DataTree> createState() => _DataTreeState(pointer);
}

class _DataTreeState extends State<DataTree> with SingleTickerProviderStateMixin {
  final NodeHistoryPointer pointer;
  late final Ticker ticker;
  StructuredData? data;

  _DataTreeState(this.pointer);

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      setState(() {
        data = pointer.readData();
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
    if (data == null) {
      return Container();
    }
    var flatList = data!.flatten();
    return ListView.builder(
        itemBuilder: (BuildContext context, index) {
          var item = flatList[index];
          return Row(
            children: [
              Container(width: item.level * 24),
              if (item.key != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(item.key!),
                ),
              if (item.hasChildren) Icon(item.isExpand ? Icons.arrow_drop_down : Icons.arrow_right),
              DataTreeEntry(data: item.data),
            ],
          );
        },
        itemCount: flatList.length);
  }
}

class DataTreeEntry extends StatelessWidget {
  final StructuredData data;

  const DataTreeEntry({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.text != null) {
      return Text("${data.text}", style: TextStyle(color: Colors.blue));
    }
    if (data.float != null) {
      return Text("${data.float}", style: TextStyle(color: Colors.orange));
    }
    if (data.integer != null) {
      return Text("${data.integer}", style: TextStyle(color: Colors.orange));
    }
    if (data.boolean != null) {
      return Text("${data.boolean}", style: TextStyle(color: Colors.red));
    }
    if (data.array != null) {
      return Text("Array (${data.array!.length} Items)", style: TextStyle(color: Colors.grey));
    }
    if (data.object != null) {
      return Text("Object (${data.object!.length} Items)", style: TextStyle(color: Colors.grey));
    }
    return Container();
  }
}

class FlattenedTreeNode {
  final int level;
  final bool isExpand = true;
  final StructuredData data;
  final String? key;
  final bool hasChildren;

  FlattenedTreeNode({required this.level, required this.data, this.key, this.hasChildren = false});
}

extension TreeExtensions on StructuredData {
  List<FlattenedTreeNode> flatten({int level = 0, String? key}) {
    if (this.array != null) {
      return [
        FlattenedTreeNode(level: level, data: this, key: key, hasChildren: true),
        ...this.array!.map((data) => data.flatten(level: level + 1)).flattened
      ];
    }
    if (this.object != null) {
      return [
        FlattenedTreeNode(level: level, data: this, key: key, hasChildren: true),
        ...this
            .object!
            .entries
            .sorted((lhs, rhs) {
              if (lhs.value.object != null && rhs.value.object == null) {
                return -1;
              } else if (lhs.value.object == null && rhs.value.object != null) {
                return 1;
              } else {
                return lhs.key.compareTo(rhs.key);
              }
            })
            .map((entry) => entry.value.flatten(level: level + 1, key: entry.key))
            .flattened
      ];
    }
    return [FlattenedTreeNode(level: level, data: this, key: key)];
  }
}
