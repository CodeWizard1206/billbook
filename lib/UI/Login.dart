import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vinays_billbook/Constants.dart';
import 'package:vinays_billbook/UI/COMPONENTS/CustomButton.dart';

class Login extends StatelessWidget {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 8.0,
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 270,
                    maxWidth: 400,
                  ),
                  margin: const EdgeInsets.all(
                    10.0,
                  ),
                  padding: const EdgeInsets.all(
                    10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: Text(
                          'User Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Username',
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 1,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          filled: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        maxLines: 1,
                        onChanged: (value) {},
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      MaterialMenuButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                        ),
                        buttonText: 'LOGIN',
                        leadingIconData: Icon(
                          FlutterIcons.sign_in_faw,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_username.text != '' && _password.text != '') {
                            if (_username.text == 'admin' &&
                                _password.text == 'admin') {
                              Constants.isLoggedIn = true;
                              Navigator.popAndPushNamed(context, '/home');
                            } else {
                              showFlushBar(
                                context: context,
                                title: 'Error!',
                                message:
                                    'Invalid login credentials, please try again...',
                                alertStyle: true,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
