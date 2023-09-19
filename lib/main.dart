// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stepboomzxwispynew/utils/const.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:stepboomzxwispynew/utils/controller_helper.dart';
import 'package:stepboomzxwispynew/widgets/background_light.dart';
import 'package:stepboomzxwispynew/widgets/background_table.dart';
import 'package:stepboomzxwispynew/widgets/clock.dart';
import 'package:stepboomzxwispynew/widgets/date.dart';
import 'package:stepboomzxwispynew/widgets/deco_frame.dart';
import 'package:stepboomzxwispynew/widgets/end_screen.dart';
import 'package:stepboomzxwispynew/widgets/mail.dart';
import 'package:stepboomzxwispynew/widgets/overlay_text.dart';
import 'package:stepboomzxwispynew/widgets/potrait.dart';
import 'package:stepboomzxwispynew/widgets/story.dart';
import 'package:stepboomzxwispynew/widgets/timeline.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  JustAudioPlatform.instance = JustAudioPlugin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final height = 12000.0;

  _body(ScrollController controller, Size size, double maxExtent) => [
        Positioned(
          width: size.width + 200,
          child: BackgroundTable(
            controller,
            maxExtent: maxExtent.at(0.2),
          ),
        ),
        MailBack(controller, maxExtent: maxExtent.at(0.2)),
        Positioned(
          width: size.width,
          right: 0,
          child: BackgroundLight(
            controller,
            maxExtent: maxExtent.at(0.2),
          ),
        ),
        Positioned(
          width: size.width,
          bottom: 0,
          child: OverlayText(
            controller,
            play: true,
            maxExtent: maxExtent.at(0.05),
            text: 'ดึงหน้าจอขึ้นช้าๆ',
          ),
        ),
        Potrait(
          controller,
          minExtent: maxExtent.at(0.19),
          maxExtent: maxExtent.at(0.29),
          image: 'potrait_bride',
          name: 'wispynew',
          subtitle: 'Nitchakan Bunrit',
        ),
        Potrait(
          controller,
          minExtent: maxExtent.at(0.23),
          maxExtent: maxExtent.at(0.33),
          image: 'potrait_groom',
          name: 'stepboomz',
          subtitle: 'Supasit Theprak',
        ),
        Positioned.fill(
          child: DecoFrame(
            controller,
            minExtent: maxExtent.at(0.05),
            maxExtent: maxExtent.at(0.5),
          ),
        ),
        Positioned.fill(
          child: Transform.scale(
            scaleX: -1,
            child: DecoFrame(
              controller,
              minExtent: maxExtent.at(0.05),
              maxExtent: maxExtent.at(0.5),
            ),
          ),
        ),
        Clock(
          controller,
          minExtent: maxExtent.at(0.4),
          maxExtent: maxExtent.at(0.6),
        ),
        const Text(
          'สร้างความทรงจำ\nที่จะไหลไปตามกาลเวลา\nตลอดไป...',
          textAlign: TextAlign.center,
          // style: caveatStyle,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.4),
                end: maxExtent.at(0.6),
              ),
            )
            .fadeIn()
            .then()
            .fadeOut(),
        Positioned(
          width: size.width + 200,
          height: size.height,
          child: Story(
            controller,
            minExtent: maxExtent.at(0.27),
            maxExtent: maxExtent.at(0.45),
          ),
        ),
        Positioned(
          width: size.width,
          height: size.height,
          child: DateAnnouncement(
            controller,
            minExtent: maxExtent.at(0.5),
            maxExtent: maxExtent.at(0.7),
          ),
        ),
        Positioned(
          width: size.width,
          height: size.height,
          child: EndScreen(
            controller,
            minExtent: maxExtent.at(0.7),
            maxExtent: maxExtent,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stepboomz x wispynew',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: CustomScrollBehavior(),
      home: SafeArea(
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              body: Timeline(
                  height: height,
                  controller: ScrollController(),
                  children: (context, controller) {
                    final maxExtent = controller.hasClients
                        ? controller.position.maxScrollExtent
                        : height;
                    final size = MediaQuery.of(context).size;
                    return size.width < 600
                        ? _body(controller, size, maxExtent)
                        : const [
                            Center(
                              child: Text(
                                ' อุปกรณ์ของคุณไม่ได้รับการรับรองหรือรองรับ >>',
                              ),
                            )
                          ];
                  }))),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
