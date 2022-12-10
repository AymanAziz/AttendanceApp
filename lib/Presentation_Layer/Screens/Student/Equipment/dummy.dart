// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../BusinessLogic_Layer/GetListLabBloc/get_list_lab_bloc.dart';
//
// class EquipmentScreen extends StatefulWidget {
//   const EquipmentScreen( {Key? key}) : super(key: key);
//
//   @override
//   State<EquipmentScreen> createState() => _EquipmentScreenState();
// }
//
// class _EquipmentScreenState extends State<EquipmentScreen> {
//   final GetListLabBloc _getListLabBloc = GetListLabBloc();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final todo = ModalRoute.of(context)?.settings.arguments as Map;
//     String title = todo['title'];
//
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(),
//       body: BlocProvider(create:(context) {
//         _getListLabBloc.add(GetListLabListEquipment(title));
//         return _getListLabBloc;
//       },
//         child: BlocBuilder<GetListLabBloc, GetListLabState>(builder:
//             (context,state){
//           if(state is ListLabLoading)
//           {
//             return const Center(child: CircularProgressIndicator());
//           }
//           else if (state is ListLabEquipmentLoaded)
//           {
//             return Container(
//               padding: const EdgeInsets.all(10),
//               child: ListView.builder(
//                 itemCount: state.value.isEmpty
//                     ? 0
//                     : state.value.length,
//                 itemBuilder: (BuildContext context, int index) {
//
//                   return Card(
//                     color: const Color.fromARGB(255, 4, 52, 84),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     elevation: 10,
//                     shadowColor: Colors.black,
//                     child: SizedBox(
//                       width: 200,
//                       height: 100,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Row(
//                           children: [
//                             Container(
//                               decoration: const BoxDecoration(
//                                 border: Border(
//                                     right: BorderSide(
//                                       color: Colors.blue,
//                                       width: 3,
//                                     )),
//                               ),
//                               child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                   ),
//                                   color: Colors.white,
//                                   child: Padding(
//                                     padding: const EdgeInsets.fromLTRB(
//                                         20, 0, 20, 0),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           state.value[index].name.toString(),
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 40),
//                                         ),
//                                         Text(
//                                           state.value[index].quantity.toString(),
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           state.value[index].user.toString(),
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                   ); },
//
//               ),
//             );
//           }
//           else
//           {
//             return const Text('error');
//           }
//         })
//
//         ,),
//     ));
//   }
// }
