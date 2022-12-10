import 'package:attandance_app/Presentation_Layer/Screens/Student/Cart/ConfirmCartScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../../Data_Layer/Repository/CartRepository/CartRepository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<int> value = <int>[];
  List<int> checkValue = <int>[];
  List<String> equipmentName = <String>[];
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
  }
   getCurrentQuantityAdd(int quantity,specificName, equipmentName,List<int> value,int i) {

    if(!(value[i] > quantity-1))
    {
      if(value[i] == 0)
        {
          setState(() {
            _isButtonDisabled = false;

            value[i] =   value[i] + 1;
            equipmentName[i] = specificName;
          });
        }
      else
        {
          setState(() {
            value[i] =   value[i] + 1;
            equipmentName[i] = specificName;
          });
        }

    }

  }

   getCurrentQuantityMinus(int quantity,String name,List<String> equipmentName,List<int> value,int index,checkValue) {
     Function eq = const ListEquality().equals;
    if(value[index] > 0 )
    {
        setState(() {
          value[index] = value[index] -1;
          ///check if list value is same
          if(value[index] == 0)
            {
              equipmentName[index] = "empty";
              if(eq(value,checkValue))
              {
                _isButtonDisabled = true;
              }
            }
        });

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ButtonTheme(
        minWidth: 200.0,
        height: 100.0,
        child: ElevatedButton(
          onPressed: () {
            if(_isButtonDisabled == true)
              {

              }
            else{
               
              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                  builder: (context) => const ConfirmCartScreen(),settings: RouteSettings(
                arguments: {"cartEquipment": equipmentName,"equipmentQuantity":value},
              )));
            }
          },
          child: const Text("Confirm"),
        ),
      ),



      appBar: AppBar(title: const Text('Checkout'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black, elevation:0
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: CartRepository().getEquipmentCart("Makmal1"),
          builder: (context, asyncSnapshot) {

            switch (asyncSnapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.done:
                {

                  if (!asyncSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (asyncSnapshot.data!.docs.isEmpty) ///if document tu x de
                  {
                    return const Text('');
                  } else if (asyncSnapshot.hasError) {
                    return const Text('error');
                  } else {

                    return ListView.builder(
                        itemCount: asyncSnapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                            },
                            child: SizedBox(
                              height: 100,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                                    child: Text(
                                                      asyncSnapshot.data!.docs[index].get('Name'),
                                                      style: const TextStyle(
                                                          fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),

                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Ink(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: const Color.fromARGB(255, 4, 52, 84)),
                                                               borderRadius: BorderRadius.circular(15.0),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                if(value.isEmpty)
                                                                  {
                                                                  }
                                                                else
                                                                  {
                                                                    print('value not null: $value');
                                                                      getCurrentQuantityMinus(asyncSnapshot.data!.docs[index].get('Quantity'),asyncSnapshot.data!.docs[index].get('Name'),equipmentName,value,index,checkValue);
                                                                  }

                                                              },
                                                              child: const Padding(
                                                                padding: EdgeInsets.all(10.0),
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  size: 20.0,
                                                                  color: Color.fromARGB(255, 4, 52, 84),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 15),
                                                          SizedBox(
                                                            child: value.isEmpty ? const Text("0",style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),) :Text('${value[index]}',style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),) ,
                                                          ),

                                                          const SizedBox(width: 15),
                                                          Ink(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: const Color.fromARGB(255, 4, 52, 84)),
                                                              borderRadius: BorderRadius.circular(15.0),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                if(value.isEmpty)
                                                                {


                                                                    for(int kk =0; kk<asyncSnapshot.data!.docs.length;kk++)
                                                                    {
                                                                      value.add(0);
                                                                      checkValue.add(0);
                                                                      equipmentName.add("empty");


                                                                    }
                                                                    print("total length : ${asyncSnapshot.data!.docs.length}");
                                                                  print("value : $value");
                                                                  getCurrentQuantityAdd(asyncSnapshot.data!.docs[index].get('Quantity'),asyncSnapshot.data!.docs[index].get('Name'),equipmentName,value,index);
                                                                }
                                                                else
                                                                {
                                                                  getCurrentQuantityAdd(asyncSnapshot.data!.docs[index].get('Quantity'),asyncSnapshot.data!.docs[index].get('Name'),equipmentName,value,index);
                                                                }

                                                              },
                                                              child: const Padding(
                                                                padding: EdgeInsets.all(10.0),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 20.0,
                                                                  color: Color.fromARGB(255, 4, 52, 84),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      )


                                                    ],
                                                  ),

                                                ],
                                              )


                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }
            }



          }),
    ));
  }
}

