import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class ChangePassword extends StatefulWidget{
  const ChangePassword ({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword>{
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reNewPasswordController = TextEditingController();
  bool checkCurrentPassword = true;
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();

  // utk view password
  bool _obscureText = true;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _toggle3() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }


  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body:SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 1,
                child:  Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: cWidth,
                            child: TextFormField(
                              controller: _oldPasswordController,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 10.0),
                                hintText: 'Old Password',
                                suffix: InkWell(
                                  onTap: _toggle,
                                  child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 16),
                                ),
                              ),
                              validator: (value) {
                                return value != null && value.length < 6
                                    ? "Please enter a valid password"
                                    : null;
                              },
                            )
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: cWidth,
                            child: TextFormField(
                              controller: _newPasswordController,
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 10.0),
                                hintText: 'New Password',
                                suffix: InkWell(
                                  onTap: _toggle2,
                                  child: Icon(
                                      _obscureText1
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 16),
                                ),
                              ),
                              validator: (value) {
                                return value != null && value.length < 6
                                    ? "Please enter a valid password"
                                    : null;
                              },
                            )
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: cWidth,
                            child: TextFormField(
                              controller: _reNewPasswordController,
                              obscureText: _obscureText2,
                              decoration: InputDecoration(
                                border:const UnderlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 10.0),
                                hintText: 'Re-Enter New Password',
                                suffix: InkWell(
                                  onTap: _toggle3,
                                  child: Icon(
                                      _obscureText2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 16),
                                ),
                              ),
                              validator: (value) {
                                return value != null && value.length < 6
                                    ? "Please enter a valid password"
                                    : null;
                              },
                            )
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(70, 30, 70, 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                //what happened when press the button when all form is validate
                                try {
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: user.email!,
                                    password: _oldPasswordController.text,
                                  );

                                  user.updatePassword(_reNewPasswordController.text).then((_){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Successfully changed password'),
                                          backgroundColor: Colors.green,
                                        )
                                    );

                                    Navigator.pop(context);

                                  }).catchError((error){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Something went wrong please try again later'),
                                          backgroundColor: Colors.red,
                                        )
                                    );

                                    if (kDebugMode) {
                                      print("Password can't be changed" + error.toString());
                                    }
                                    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('No user found'),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Wrong password provided'),
                                          backgroundColor: Colors.red,
                                        )
                                    );
                                  }
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
          ),
        ),
      ),
    );
  }

}