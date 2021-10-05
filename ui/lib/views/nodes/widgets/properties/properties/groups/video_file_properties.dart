// @dart=2.11
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mizer/protos/nodes.pb.dart';

import '../property_group.dart';

class VideoFileProperties extends StatelessWidget {
  final VideoFileNodeConfig config;
  final Function(VideoFileNodeConfig) onUpdate;

  VideoFileProperties(this.config, { @required this.onUpdate });

  @override
  Widget build(BuildContext context) {
    return PropertyGroup(
      title: "Video File",
      children: [],
    );
  }
}
