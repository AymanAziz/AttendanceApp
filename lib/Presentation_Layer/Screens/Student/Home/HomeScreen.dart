import 'package:attandance_app/Data_Layer/Model/LabModel/LabModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../BusinessLogic_Layer/AttendanceBloc/attendance_bloc.dart';
import '../../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../../../BusinessLogic_Layer/GetListLabBloc/get_list_lab_bloc.dart';
import '../../login_and_register/SignInScreen.dart';
import '../Equipment/EquipmentTemplate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _scanBarcode = 'Unknown';
  AttendanceBloc attendanceBloc = AttendanceBloc();
  final GetListLabBloc _getListLabBloc = GetListLabBloc();

  @override
  void initState() {
    attendanceBloc.add(GetListAttendanceUser());
    super.initState();
  }

  DateTime datenow = DateTime.now();

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;

    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    LabModelSQLite labModelSQLite = LabModelSQLite(username: _scanBarcode);
    _getListLabBloc.add(RequestListLab(labModelSQLite));
  }

  ///refresh
  Future<void> refresh() {
    return refreshBloc().then((value) => setState(() {}));
  }

  ///function to get list attendance user
  Future<void> refreshBloc() async {
    attendanceBloc.add(GetListAttendanceUser());

    /// You can do part here what you want to refresh
  }

  @override
  Widget build(BuildContext context) {
    Color colorMainTheme = Theme.of(context).primaryColor;
    String date = DateFormat('d').format(datenow);
    String month = DateFormat("MMM").format(datenow);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                tooltip: "Pull to refresh",
                icon: const Icon(Icons.info_outline_rounded),
                color: const Color.fromARGB(255, 4, 52, 84),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<AttendanceBloc>(create: (context) => attendanceBloc),
            BlocProvider<GetListLabBloc>(create: (context) => _getListLabBloc),
          ],
          child: MultiBlocListener(
              listeners: [
                BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) async {
                  if (state is UnAuthenticated) {
                    // Navigate to the sign in screen when the user Signs Out
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                      (route) => false,
                    );
                  }
                }),
                BlocListener<GetListLabBloc, GetListLabState>(
                    listener: (context, state) async {
                  if (state is ListLabLoaded) {
                    ///return true if user  scan a right qr code
                    print("check if true or not for bloc listener");
                    switch (state.value) {
                      case true:
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>  const EquipmentTemplate(),
                        //         settings: RouteSettings(
                        //           arguments: {"title": _scanBarcode},
                        //         ))).then((_) => setState(() {
                        //   attendanceBloc.add(GetListAttendanceUser(),
                        //   );
                        // }));

                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => const EquipmentTemplate(),settings: RouteSettings(
                       arguments: {"title": _scanBarcode},
                        )));

                        break;
                      default:
                    }
                  }
                })
              ],
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                if (state is AttendanceInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AttendanceListLoaded) {
                  return RefreshIndicator(
                      onRefresh: refresh,
                      child: Builder(builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                            itemCount: state.attendanceList.isEmpty
                                ? 0
                                : state.attendanceList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var parsedDate = DateTime.parse(
                                  state.attendanceList[index].date);
                              String day = DateFormat('d').format(parsedDate);
                              String month =
                                  DateFormat('MMMM').format(parsedDate);

                              return Card(
                                color: const Color.fromARGB(255, 4, 52, 84),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: SizedBox(
                                  width: 200,
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                              color: Colors.blue,
                                              width: 3,
                                            )),
                                          ),
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      day,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 40),
                                                    ),
                                                    Text(
                                                      month,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Card(
                                                color: const Color.fromARGB(
                                                    255, 4, 52, 84),
                                                elevation: 0,
                                                child: Text(
                                                  "Name: ${state.attendanceList[index].name}\n ID: ${state.attendanceList[index].StaffOrUserID}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      backgroundColor:
                                                          Color.fromARGB(
                                                              255, 4, 52, 84),
                                                      fontSize: 16),
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }));
                } else {
                  return Container();
                }
              }))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        onPressed: () => scanQR(),
        tooltip: 'Scan QR code',
        elevation: 4.0,
        child: const Icon(Icons.qr_code),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}
