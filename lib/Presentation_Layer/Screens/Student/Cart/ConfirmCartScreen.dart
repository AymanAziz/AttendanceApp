import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmCartScreen extends StatefulWidget {
  const ConfirmCartScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCartScreen> createState() => _ConfirmCartScreenState();
}

class _ConfirmCartScreenState extends State<ConfirmCartScreen> {
  //form
  final _formKey = GlobalKey<FormState>();

  TextEditingController reason = TextEditingController();
  DateTime returnDate = DateTime.now();
  List<String> listEquipmentName = [];

  var myFormat = DateFormat('d-MM-yyyy');

  TextEditingController isStudent = TextEditingController();
  TextEditingController telNumber = TextEditingController();
  TextEditingController userID = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController verPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double cWidth = MediaQuery.of(context).size.width * 0.8;
    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    List<int> equipmentQuantity = todo['equipmentQuantity'];
    List<String> equipmentName = todo['cartEquipment'];

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: equipmentQuantity.length,
                      itemBuilder: (BuildContext context, index) {
                        if (equipmentName[index] == "empty") {
                          return const Text('');
                        } else {
                          return Card( elevation: 5, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ), child: Padding(padding: const EdgeInsets.all(10) ,child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8),
                                child: Text(
                                  equipmentName[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8),
                                child: Text(
                                  equipmentQuantity[index].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),),);
                        }
                        return Container();
                      }),
                ))),
      ),
    );
  }
}

// Card(
//     elevation: 1,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     child:  Form(
//         key: _formKey,
//         child: Padding(padding: const EdgeInsets.all(16),child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             DateTimePicker(
//               initialDate: returnDate,
//               type: DateTimePickerType.date,
//               firstDate: DateTime(2000),
//               lastDate: DateTime(2100),
//               decoration: const InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: "Start Date",
//               ),
//               dateLabelText: 'Return Date',
//               onChanged: (val) => print(val),
//               validator: (value) {
//                 if (value == null ) {
//                   return 'Please enter date to return the equipments';
//                 }
//                 return null;
//               },
//               onSaved: (val) => print(val),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: cWidth,
//               child: TextFormField(
//                 controller: username,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   labelText: 'Names',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => username.text = value!,
//               ),
//             ),///Description
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.fromLTRB(70, 30, 70, 10),
//               child: ButtonTheme(
//                   minWidth: 200.0,
//                   height: 100.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   child: ElevatedButton(
//
//
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//
//                       }
//                     },
//                     child: const Text('Submit'),
//                   )),
//             ),
//           ],
//         ),))
// )
