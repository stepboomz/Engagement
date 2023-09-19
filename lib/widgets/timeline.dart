// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

typedef TimelineBuilder = List<Widget> Function(
  BuildContext context,
  ScrollController controller,
);

class Timeline extends StatelessWidget {
  const Timeline({
    Key? key,
    required this.controller,
    this.height = 0,
    required this.children,
  }) : super(key: key);

  final ScrollController controller;
  final double height;
  final TimelineBuilder children;

  _body(BuildContext context, TimelineState state, Size size) =>
      DeferredPointerHandler(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...(state is TimelineLoaded
                  ? children.call(context, controller)
                  : [DeferPointer(child: TimelineLoadingWidget(state))]),
              SingleChildScrollView(
                physics: state is TimelineLoaded
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                controller: controller,
                child: Container(height: size.height + height),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimelineCubit(),
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) {
          final size = MediaQuery.of(context).size;
          return size.width < 600
              ? _body(context, state, size)
              : const Center(
                  child: Text(
                    'Suport mobile >>',
                  ),
                );
        },
      ),
    );
  }
}

class TimelineLoadingWidget extends StatelessWidget {
  const TimelineLoadingWidget(this.state, {super.key});

  final TimelineState state;

  onTap(BuildContext context) => context.read<TimelineCubit>().init();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset('assets/images/welcome.png')
                  .animate(target: state is TimelineLoading ? 1 : 0)
                  .fadeOut()
                  .swap(
                    builder: (_, __) =>
                        Image.asset('assets/images/vinyl_disc.png')
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .rotate(end: 1, duration: 10.seconds),
                  ),
            ),
            //สวัสดี.. เพื่อประสบการณ์ที่ดียิ่งขึ้น\nตรวจสอบให้แน่ใจว่าระดับเสียงมือถือของคุณ\nไม่สูงหรือต่ำเกินไป\n\nสร้างโดย:
            const Text(
              ' cefemony out engagement\n\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Caveat', fontSize: 35),
            ).animate(target: state is TimelineLoading ? 1 : 0).fadeOut().swap(
                  builder: (_, __) => const Text(
                    'กำลังโหลด กรุณารอสักครู่..',
                    // style: caveatStyle,
                  ),
                ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              // decoration: BoxDecoration(
              //   color: const Color.fromARGB(255, 233, 62, 62),
              //   borderRadius: BorderRadius.circular(16),
              // ),
              child: Text('< แตะที่หน้าจอเพื่อเริ่มต้น >',
                  style: TextStyle(
                      // fontFamily: 'Caveat',
                      color: Color.fromARGB(255, 103, 101, 101))),
            ).animate(target: state is TimelineLoading ? 1 : 0).fadeOut()
            //     .swap(builder: (_, __) => const SizedBox()),
          ],
        ));
  }
}

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit() : super(TimelineInitial());

  final player = AudioPlayer();

  void init() async {
    emit(TimelineLoading());
    await Future.delayed(1.seconds);
    await player.setAsset('assets/audio/audio.mp3');
    player.play();
    emit(TimelineLoaded());
  }
}

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineLoaded extends TimelineState {}
