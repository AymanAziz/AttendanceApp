import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../../../../../Data_Layer/Model/UserModel/userModel.dart';
import '../../../../../Data_Layer/Provider/UserProvider/UserProvider.dart';


class PdfApi {
  static Future<File> generateCenteredText(
      selectDate1,selectDateDatabase,
      listAttendance) async {
    final pdf = pw.Document();
    final UserdbProvider  userDbProvider =UserdbProvider();

    final imageByteData = await rootBundle.load('assets/USIMLOGO.png');
    // Convert ByteData to Uint8List
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
    final image = pw.MemoryImage(imageUint8List);


    userModelSQLite user = await userDbProvider.checkUserData();




    //date only
    var myFormat = DateFormat('d-MM-yyyy');


    var value = pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Image(image,width: 90)
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text("Attendance",
                    style: pw.TextStyle(
                        font: pw.Font.timesBold(),
                        fontSize: 20,
                        decoration: pw.TextDecoration.underline))
              ]),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 1, color: const PdfColor(0, 0, 0, 1.0)),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Attendance Date: ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(selectDate1 ?? selectDateDatabase,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                      // decoration: pw.TextDecoration.underline

                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Retrieve By : ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(user.username,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Staff ID: ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(user.userID,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("Email: ",
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
                pw.Text(user.email,
                    style: pw.TextStyle(
                      font: pw.Font.timesBold(),
                      fontSize: 12,
                    )),
              ]),
              pw.SizedBox(height: 3),
              pw.Divider(thickness: 1, color: const PdfColor(0, 0, 0, 1.0)),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text("List Attendance",
                    style: pw.TextStyle(
                        font: pw.Font.timesBold(),
                        fontSize: 14,
                        decoration: pw.TextDecoration.underline)),
              ]),
              pw.SizedBox(height: 10),
              pw.ListView.builder(
                  itemCount: listAttendance.isEmpty
                      ? 0
                      : listAttendance.length,
                  itemBuilder: (Context context, int index) {

                    return pw.Row(
                      children: [
                        pw.Text(
                            '${index+1}'),
                        pw.SizedBox(width: 50),
                        pw.Text(
                            '${listAttendance[index]['username']}'),
                      ],
                    );

                  }
              ),
              pw.SizedBox(height: 20),
            ]);
          }),
    );
    return saveDocument(name: 'receipt.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}