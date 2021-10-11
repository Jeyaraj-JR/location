import 'package:flutter/material.dart';
import 'package:jeyaraj_app/page/HomeScreen.dart';
import 'package:jeyaraj_app/page/google_Sign_Api.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> SignIn() async {
    final users = await GoogleSignInApi.login();
    if (users == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sign in Failed")));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        "assets/index1.png",
                        height: 160,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcom to find ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 50,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage("assets/index2.png"),
                            height: 35.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Sign in with Google",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      onTap: SignIn,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
