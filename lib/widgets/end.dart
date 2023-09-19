import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNoteDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('เขียนการ์ดอวยพร'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'ชื่อ'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'คำอวยพร'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ปิด Dialog
          },
          child: Text('ยกเลิก'),
        ),
        TextButton(
          onPressed: () async {
            final url = Uri.parse('http://localhost:5001/v1/note/addNote');
            final response = await http.post(
              url,
              body: {
                'title': nameController.text,
                'description': descriptionController.text,
              },
            );

            if (response.statusCode == 200) {
              // ส่งข้อมูลสำเร็จ
              Navigator.of(context).pop(); // ปิด Dialog
            } else {
              // การส่งข้อมูลไม่สำเร็จ
              // คุณสามารถแสดงข้อความผิดพลาดหรือทำอะไรก็ตามที่คุณต้องการ
            }
          },
          child: Text('ส่ง'),
        ),
      ],
    );
  }
}
