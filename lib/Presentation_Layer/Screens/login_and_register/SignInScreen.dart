import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../BusinessLogic_Layer/AuthBloc/auth_bloc.dart';
import '../../../BusinessLogic_Layer/CheckUser/checkUserStatus.dart';
import '../../../main.dart';
import '../../Widget/curve_widget.dart';
import 'SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // utk view password
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {

    Color colorMainTheme = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
          child: Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false, //new line
              appBar: AppBar(
                elevation: 0,
                backgroundColor:colorMainTheme,
              ),
              body: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is Authenticated) {
                    // Navigating to the dashboard screen if the user is authenticated
                    //but if no internet connection
                    //cant access this app
                    try {
                      bool result =
                      await InternetConnectionChecker().hasConnection;
                      if (result == true) {
                        await checkUserLogin(context);
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                title: const Text('No Internet Connection'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                        );
                      }
                    } catch (e) {}
                  }
                  if (state is AuthError) {
                    // Showing the error message if the user has entered invalid credentials
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                child:
                BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  if (state is Loading) {
                    // Showing the loading indicator while the user is signing in
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UnAuthenticated) {
                    // Showing the sign in form if the user is not authenticated
                    return Container(
                      height: double.infinity,
                      color: Colors.white,
                      child: ListView(children: [
                        Stack(
                          children: const [
                            CurveWidget(),
                          ],
                        ),
                         Row(mainAxisAlignment: MainAxisAlignment.center,children: const[ Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 4, 52, 84)),
                        ),],),
                        SizedBox(height: MediaQuery.of(context).size.width*0.20,),
                        Form(
                            key: _formKey,
                            child: Padding(padding: const EdgeInsets.only(left: 20,right: 20,
                            ),child: Column(
                              children: [
                                //email
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null &&
                                        !EmailValidator.validate(value)
                                        ? 'Enter Valid Email'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 10.0),
                                      hintText: 'email',
                                      prefixIcon: const IconTheme(
                                          data: IconThemeData(
                                              color:
                                              Color.fromARGB(255, 4, 52, 84)),
                                          child: Icon(Icons.email))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //password
                                TextFormField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  obscureText: _obscureText,
                                  //hide password
                                  validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Enter min. 6 characters"
                                        : null;
                                  },

                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 25.0, horizontal: 10.0),
                                      hintText: 'Password',
                                      suffix: InkWell(
                                        onTap: _toggle,
                                        child: Icon(
                                            _obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 16),
                                      ),
                                      prefixIcon: const IconTheme(
                                          data: IconThemeData(
                                              color:
                                              Color.fromARGB(255, 4, 52, 84)),
                                          child: Icon(Icons.lock))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [GestureDetector(
                                    child: const Text('Forgot Password?',
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.blue)),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => const ForgotPasswordScreen()),
                                      // );
                                    },
                                  ),],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                //button sign in
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {
                                      _authenticateWithEmailAndPassword(context);
                                    },
                                    child: const Text('Sign In'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Not a Member? '),
                                    GestureDetector(
                                      child: const Text('Register',
                                          style: TextStyle(
                                              decoration: TextDecoration.underline,
                                              color: Colors.blue)),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const SignUpScreen()),
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),)),
                      ]),
                    );
                  }
                  return const MyApp();
                }),
              ))),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text.trim(), _passwordController.text.trim()),
      );
    }
  }
}
