import 'package:cloud_firestore/cloud_firestore.dart';

class CartRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference dbUser = FirebaseFirestore.instance.collection('user');

  Stream<DocumentSnapshot<Object?>> getEquipmentCartTest(String labName) {
    var courseDocStream = db.collection('Makmal1').doc(
        labName).snapshots();
    return courseDocStream;
  }

  //  Future<DocumentSnapshot> getEquipmentCart(String labName)  async {
  //   var courseDocStream = await db.collection('Makmal1').doc().get();
  //   return courseDocStream;
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEquipmentCart(String labName)   {
    var courseDocStream =  db.collection('Makmal1').snapshots();
    return courseDocStream;
  }


  ///get data specific  user from Repository check if is user or not
  Future getSpecificEquipmentDetails(String labName) async {
    db.collection("users").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        print(result.data());
      }
    });
  }

}