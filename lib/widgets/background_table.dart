import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stepboomzxwispynew/utils/controller_helper.dart';
import 'package:stepboomzxwispynew/widgets/timeline_widget.dart';
import 'package:stepboomzxwispynew/widgets/vinyl.dart';

class BackgroundTable extends TimelineWidget {
  const BackgroundTable(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/background_table.png', fit: BoxFit.cover),
        const Positioned(
          width: 350,
          height: 350,
          top: 80,
          child: Vinyl(),
        ),
      ],
    )
        .animate(delay: 1.seconds)
        .fadeIn(duration: 1.seconds)
        .scaleXY(duration: 1.seconds, begin: 0.9)
        .animate(adapter: ScrollAdapter(controller, end: maxExtent.at(0.2)))
        .scaleXY(end: 0.9)
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: maxExtent.at(0.7),
            end: maxExtent,
          ),
        )
        .fadeOut();
  }
}
