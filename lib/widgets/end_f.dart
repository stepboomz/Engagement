import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stepboomzxwispynew/widgets/timeline_widget.dart';
import 'package:stepboomzxwispynew/utils/controller_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import '../utils/const.dart';

class EndScreen1 extends TimelineWidget {
  const EndScreen1(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  Future<List<Note>> fetchAllNotes() async {
    final response =
        await http.get(Uri.parse('http://localhost:5001/v1/note/getMyNotes'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['response'];
      if (responseData.isNotEmpty) {
        final List<Note> notes =
            responseData.map((json) => Note.fromJson(json)).toList();
        return notes;
      }
    }
    throw Exception('ไม่สามารถดึงข้อมูลได้');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<List<Note>>(
      future: fetchAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading..');
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('ไม่พบข้อมูล');
        } else {
          final notes = snapshot.data!;

          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/mail_b_base.png',
                    fit: BoxFit.fitHeight),
              ),
              Positioned.fill(
                child: Image.asset('assets/images/mail_b_stars.png',
                        fit: BoxFit.fitHeight)
                    .animate(onPlay: (controller) => controller.repeat())
                    .rotate(duration: 80000.ms, end: 1),
              ),
              Positioned.fill(
                child: Image.asset('assets/images/mail_b_stars.png',
                        fit: BoxFit.fitHeight)
                    .animate(onPlay: (controller) => controller.repeat())
                    .scaleXY(begin: 0.8, end: 0.8)
                    .rotate(duration: 160000.ms, begin: -0.5, end: 0.5),
              ),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/mail_b_vignette.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Text(
              //   'wispynew x stepboomz',
              //   textAlign: TextAlign.center,
              //   style: caveatStyle.copyWith(color: Colors.white),
              // )
              //     .animate(
              //       adapter: ScrollAdapter(
              //         controller,
              //         begin: maxExtent.at(0.75, minExtent),
              //         end: maxExtent.at(1, minExtent),
              //       ),
              //     )
              //     .fadeIn()
              //     .moveY(begin: -100),
              // Positioned(
              //     bottom: 0,
              //     child: Text(
              //       'เติบโตไปด้วยกันนะนะนะ',
              //       textAlign: TextAlign.center,
              //       style: caveatStyle.copyWith(color: Colors.white),
              //     )
              //         .animate(
              //           adapter: ScrollAdapter(
              //             controller,
              //             begin: maxExtent.at(0.5, minExtent),
              //             end: maxExtent.at(0.75, minExtent),
              //           ),
              //         )
              //         .fadeIn()),
              // ลูปแสดงข้อความที่มีตำแหน่งสุ่ม
              for (final note in notes)
                Positioned(
                  // left: Random().nextDouble() * size.width,
                  top: Random().nextDouble() * size.height,
                  // right: Random().nextDouble() * size.width,
                  child: Text(
                    '${note.title}:${note.description}',
                    // textAlign: TextAlign.center,
                    style: caveatStyle.copyWith(color: Colors.white),
                  )
                      .animate(
                        adapter: ScrollAdapter(
                          controller,
                          begin: maxExtent.at(0.5, minExtent),
                          end: maxExtent.at(0.75, minExtent),
                        ),
                      )
                      .fadeIn(),
                ),
            ],
          )
              .animate(
                adapter: ScrollAdapter(
                  controller,
                  begin: minExtent,
                  end: maxExtent.at(0.5, minExtent),
                ),
              )
              .fadeIn()
              .moveY(begin: size.height + 100);
        }
      },
    );
  }
}

class Note {
  final String id;
  final String description;
  final String title;
  final int createAt;

  Note({
    required this.id,
    required this.description,
    required this.createAt,
    required this.title,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      description: json['description'],
      createAt: json['createAt'],
      title: json['title'],
    );
  }
}
