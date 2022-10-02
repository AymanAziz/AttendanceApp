import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../login_and_register/SignInScreen.dart';

class StudentHomeScreen extends StatefulWidget{
  const StudentHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StudentHomeScreen();

}

class _StudentHomeScreen extends State<StudentHomeScreen>{


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const SignInScreen()),
                    (route) => false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20,left: 20),
                          child: const Text(
                            "Hello",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Card(
                      color: Colors.green,
                      elevation: 16,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Dr. Alok Verma",
                                  style: TextStyle(fontSize: 24),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                        child: Text("Date: 14-06-2021",
                                            style: TextStyle(fontSize: 24))),
                                    Expanded(
                                        child: TextButton(
                                            onPressed: () {},
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(5)),
                                                padding: const EdgeInsets.all(8),
                                                child: const Text("Completed",
                                                    style: TextStyle(fontSize: 24)))))
                                  ],
                                ),
                                const Text("Time: 10:20", style: TextStyle(fontSize: 24)),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text("Aastha Hospital",
                                    style: TextStyle(
                                        fontSize: 24, fontWeight: FontWeight.bold)),
                                const Text("Some address", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: const [Text(
                        "Browse",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                      ],),
                    const SizedBox(
                      height: 10,
                    ),
                    gridViewDrug(context),
                  ],
                )
              ],
            ),
          )),
    ))
    );

  }

}
Widget gridViewDrug(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    crossAxisSpacing: 10,
    scrollDirection: Axis.vertical,
    mainAxisSpacing: 10,
    children: List<Widget>.generate(2, (index) {
      return GridTile(
        child: InkWell(
          onTap: () {
            switch (index) {
              case 0:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const DrugListScreen()),
                // );
                break;
              case 1:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CategoryScreen()),
                // );
                break;
            }
          },
          child: Card(
              color: (index == 0)
                  ? const Color.fromARGB(255, 27, 209, 221)
                  : const Color.fromARGB(255, 24, 191, 161),
              child: Center(
                child: (index == 0)
                    ? const Text(
                  "Drug List",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
                    : const Text("Category",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              )),
        ),
      );
    }),
  );
}