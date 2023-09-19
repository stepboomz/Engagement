import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stepboomzxwispynew/utils/const.dart';
import 'package:stepboomzxwispynew/utils/controller_helper.dart';
import 'package:stepboomzxwispynew/widgets/timeline_widget.dart';

class Story extends TimelineWidget {
  const Story(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // SEQUENCE 1
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/story/seq_1_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/story/seq_1_title.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              height: size.height,
              width: size.width + 150,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/story/seq_1_deco.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/story/seq_1_woman.png',
                      fit: BoxFit.fitWidth,
                    )
                        .animate(
                          adapter: ScrollAdapter(
                            controller,
                            begin: minExtent,
                            end: maxExtent.at(0.3, minExtent),
                          ),
                        )
                        .moveX(begin: 100, end: -40),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/story/seq_1_man.png',
                      fit: BoxFit.fitWidth,
                    )
                        .animate(
                          adapter: ScrollAdapter(
                            controller,
                            begin: minExtent,
                            end: maxExtent.at(0.3, minExtent),
                          ),
                        )
                        .moveX(begin: -100, end: 40),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/story/seq_1_fg.png',
                      fit: BoxFit.fitWidth,
                    )
                        .animate(
                          adapter: ScrollAdapter(
                            controller,
                            begin: minExtent,
                            end: maxExtent.at(0.3, minExtent),
                          ),
                        )
                        .moveX(begin: 100),
                  ),
                ],
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.25, minExtent),
                      end: maxExtent.at(0.4, minExtent),
                    ),
                  )
                  .scaleXY(end: 0.8),
            ),

            // TEXT
            Positioned(
              bottom: 20,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'จุดเริ่มต้นของความใกล้ชิดของเราคือ \n เราจะมักจะเจอกันตรงป้ายรถประจำทาง\n',
                textAlign: TextAlign.center,
                style: caveatStyle,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.15, minExtent),
                      end: maxExtent.at(0.45, minExtent),
                    ),
                  )
                  .fadeIn()
                  .then()
                  .fadeOut(),
            ),

            // SEQUENCE 2
            Positioned(
              width: size.width,
              height: size.height,
              child: Image.asset(
                'assets/images/story/seq_2_bg.png',
                fit: BoxFit.cover,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.3, minExtent),
                      end: maxExtent.at(0.4, minExtent),
                    ),
                  )
                  .fadeIn()
                  .scaleXY(begin: 1.2),
            ),
            Positioned(
              width: size.width,
              child: Image.asset(
                'assets/images/story/seq_2_row1.png',
                fit: BoxFit.fitWidth,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.35, minExtent),
                      end: maxExtent.at(0.45, minExtent),
                    ),
                  )
                  .fadeIn()
                  .scaleXY(begin: 1.2),
            ),
            Positioned(
              width: size.width,
              child: Image.asset(
                'assets/images/story/seq_2_row2.png',
                fit: BoxFit.fitWidth,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.4, minExtent),
                      end: maxExtent.at(0.5, minExtent),
                    ),
                  )
                  .fadeIn()
                  .scaleXY(begin: 1.2),
            ),
            Positioned(
              width: size.width,
              child: Image.asset(
                'assets/images/story/seq_2_row3.png',
                fit: BoxFit.fitWidth,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.45, minExtent),
                      end: maxExtent.at(0.55, minExtent),
                    ),
                  )
                  .fadeIn()
                  .scaleXY(begin: 1.2),
            ),
            Positioned(
              width: size.width,
              // height: size.height,
              bottom: 0,
              child: Image.asset(
                'assets/images/story/seq_2_row4.png',
                fit: BoxFit.fitWidth,
              )
                  .animate(
                    adapter: ScrollAdapter(
                      controller,
                      begin: maxExtent.at(0.5, minExtent),
                      end: maxExtent.at(0.6, minExtent),
                    ),
                  )
                  .fadeIn()
                  .scaleXY(begin: 1.2),
            ),
          ],
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.6, minExtent),
                end: maxExtent.at(0.8, minExtent),
              ),
            )
            .fadeOut(),

        // TEXT
        Positioned(
          top: 20,
          width: MediaQuery.of(context).size.width,
          child: Text(
            'หลังจากนั้นเราก็เริ่มออกเดท เยอะมากๆ',
            textAlign: TextAlign.center,
            style: caveatStyle.copyWith(
                color: const Color.fromARGB(255, 255, 255, 255)),
          )
              .animate(
                adapter: ScrollAdapter(
                  controller,
                  begin: maxExtent.at(0.3, minExtent),
                  end: maxExtent.at(0.6, minExtent),
                ),
              )
              .fadeIn()
              .then()
              .fadeOut(),
        ),

        // TEXT
        Positioned(
          top: 20,
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'ขอบคุณโลกที่เหวี่ยงให้เรามาเจอกัน\nขอบคุณที่เข้ามาเป็นโลกที่สดใส',
            textAlign: TextAlign.center,
            style: caveatStyle,
          )
              .animate(
                adapter: ScrollAdapter(
                  controller,
                  begin: maxExtent.at(0.7, minExtent),
                  end: maxExtent.at(0.9, minExtent),
                ),
              )
              .fadeIn()
              .then()
              .fadeOut(),
        ),

        // SEQUENCE 3
        Image.asset(
          'assets/images/story/seq_3_hand2.png',
          fit: BoxFit.fitWidth,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.65, minExtent),
                end: maxExtent.at(0.75, minExtent),
              ),
            )
            .moveX(begin: -300)
            .then()
            .moveX(end: -100),
        Image.asset(
          'assets/images/story/seq_3_hand1.png',
          fit: BoxFit.fitWidth,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.6, minExtent),
                end: maxExtent.at(0.7, minExtent),
              ),
            )
            .moveX(begin: 400),
        Image.asset(
          'assets/images/story/seq_3_thumb.png',
          fit: BoxFit.fitWidth,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.65, minExtent),
                end: maxExtent.at(0.75, minExtent),
              ),
            )
            .moveX(begin: -300)
            .then()
            .moveX(end: -100),
        Image.asset(
          'assets/images/story/seq_3_ring.png',
          fit: BoxFit.fitWidth,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.65, minExtent),
                end: maxExtent.at(0.7, minExtent),
              ),
            )
            .moveX(begin: -300)
      ],
    )
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: minExtent,
            end: maxExtent.at(0.2, minExtent),
          ),
        )
        .moveY(begin: size.height + 200)
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: maxExtent.at(0.8, minExtent),
            end: maxExtent.at(1, minExtent),
          ),
        )
        .moveY(end: -size.height - 200);
  }
}
