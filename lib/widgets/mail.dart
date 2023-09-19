// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stepboomzxwispynew/utils/controller_helper.dart';
import 'package:stepboomzxwispynew/widgets/letter.dart';
import 'package:stepboomzxwispynew/widgets/timeline_widget.dart';

class MailBack extends TimelineWidget {
  const MailBack(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    const size = Offset(360, 480);

    // adapters
    final end = maxExtent.at(0.25);
    final imageAdapter = ScrollAdapter(controller, begin: minExtent, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: minExtent, end: end);

    return BlocProvider(
      create: (_) => MailCubit()..init(context),
      child: BlocBuilder<MailCubit, MailState>(
        builder: (context, state) {
          if (state is MailLoaded) {
            return Center(
              child: SizedBox(
                width: size.dx,
                height: size.dy,
                child: ClipRRect(
                  clipper: MailRect(size),
                  child: RepaintBoundary(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image(
                                  image: state.baseBack, fit: BoxFit.fitHeight)
                              .animate(adapter: imageAdapter),
                        ),
                        Positioned.fill(
                          child: Image(
                                  image: state.stars, fit: BoxFit.fitHeight)
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .rotate(duration: 80000.ms, end: 1),
                        ),
                        Positioned.fill(
                          child: Image(
                                  image: state.stars, fit: BoxFit.fitHeight)
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .scaleXY(begin: 0.8, end: 0.8)
                              .rotate(
                                  duration: 160000.ms, begin: -0.5, end: 0.5),
                        ),
                        Positioned.fill(
                            child: Image(
                                image: state.vignette, fit: BoxFit.fitHeight)),
                        // Image(image: stamp, fit: BoxFit.fitHeight),
                        Positioned.fill(
                          child:
                              Image(image: state.flower, height: size.dy * 0.8)
                                  .animate()
                                  .scaleXY(begin: 0.6, end: 0.6),
                        ),
                      ],
                    ),
                  ),
                )
                    .animate(adapter: mailAdapter)
                    .scaleXY(begin: 0.5)
                    .moveY(begin: 50)
                    .then()
                    .rotate(end: -0.25)
                    .flipH(begin: 0, end: 0.5, perspective: 0.3)
                    .scaleXY(end: 0.7)
                    .swap(
                      builder: (_, __) => MailFront(
                        controller,
                        state: state,
                        minExtent: end,
                        maxExtent: maxExtent,
                      ),
                    ),
              ),
            ).animate(delay: 1.seconds).fadeIn(duration: 1.seconds);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class MailFront extends TimelineWidget {
  const MailFront(
    super.controller, {
    super.key,
    required this.state,
    super.minExtent,
    super.maxExtent,
  });

  final MailLoaded state;

  @override
  Widget build(BuildContext context) {
    // adapters
    final end = maxExtent.at(0.5);
    final headAdapter = ScrollAdapter(controller, begin: minExtent, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: minExtent, end: end);

    return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
          Image(
            image: state.baseFront,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            height: 200,
            width: 300,
            child: Container(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          Image(image: state.body),
          Image(image: state.head)
              .animate(adapter: headAdapter)
              .flipV(alignment: Alignment.topCenter, end: -1, perspective: -1)
        ])
        .animate(adapter: mailAdapter)
        .flipH(begin: -0.5, perspective: 0.2)
        .swap(
          builder: (context, child) => MailLetter(
            controller,
            state: state,
            minExtent: end,
            maxExtent: maxExtent,
          ),
        );
  }
}

class MailLetter extends TimelineWidget {
  const MailLetter(
    super.controller, {
    super.key,
    required this.state,
    super.minExtent,
    super.maxExtent,
  });

  final MailLoaded state;

  @override
  Widget build(BuildContext context) {
    // adapters
    final end = maxExtent.at(0.75);
    final letterAdapter = ScrollAdapter(controller, begin: minExtent, end: end);
    final bodyAdapter = ScrollAdapter(controller, begin: minExtent, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: minExtent, end: end);

    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image(image: state.baseFront),
              Image(image: state.head)
                  .animate()
                  .flipV(alignment: Alignment.topCenter, begin: -1, end: -1),
            ],
          )
              .animate(adapter: mailAdapter)
              .moveY(end: 100)
              .then()
              .moveY(end: 100)
              .fadeOut(),
          Positioned(
            height: 200 * 3,
            child: Letter(
              controller,
              minExtent: end.at(0.8),
              maxExtent: maxExtent,
              size: const Offset(300, 200),
            )
                .animate(adapter: letterAdapter)
                .moveY(end: -200)
                .then()
                .scaleXY(end: 1),
          ),
          Image(image: state.body)
              .animate(adapter: bodyAdapter)
              .moveY(end: 100)
              .then()
              .moveY(end: 100)
              .fadeOut(),
        ]);
  }
}

class MailRect extends CustomClipper<RRect> {
  MailRect(this.rectSize);

  final Offset rectSize;

  @override
  RRect getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: rectSize.dx,
      height: rectSize.dy,
    );

    return RRect.fromRectAndRadius(rect, const Radius.circular(10));
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) => false;
}

class MailCubit extends Cubit<MailState> {
  MailCubit() : super(MailInitial());

  init(BuildContext context) {
    // IMAGES
    const assetPath = 'assets/images';
    const baseBack = AssetImage('$assetPath/mail_b_base.png');
    const stars = AssetImage('$assetPath/mail_b_stars.png');
    const vignette = AssetImage('$assetPath/mail_b_vignette.png');
    const stamp = AssetImage('$assetPath/mail_b_stamp.png');
    const flower = AssetImage('$assetPath/mail_b_flower.png');
    const baseFront = AssetImage('$assetPath/mail_f_base.png');
    const body = AssetImage('$assetPath/mail_f_body.png');
    const head = AssetImage('$assetPath/mail_f_head.png');

    precacheImage(baseFront, context);
    precacheImage(body, context);
    precacheImage(head, context);

    emit(const MailLoaded(
      baseBack: baseBack,
      stars: stars,
      vignette: vignette,
      stamp: stamp,
      flower: flower,
      baseFront: baseFront,
      body: body,
      head: head,
    ));
  }
}

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object?> get props => [];
}

class MailInitial extends MailState {}

class MailLoaded extends MailState {
  final AssetImage baseBack;
  final AssetImage stars;
  final AssetImage vignette;
  final AssetImage stamp;
  final AssetImage flower;
  final AssetImage baseFront;
  final AssetImage body;
  final AssetImage head;

  const MailLoaded({
    required this.baseBack,
    required this.stars,
    required this.vignette,
    required this.stamp,
    required this.flower,
    required this.baseFront,
    required this.body,
    required this.head,
  });
}
