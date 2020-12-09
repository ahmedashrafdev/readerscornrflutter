import 'package:flutter/material.dart';
import 'package:readerscorner/ui/widgets/logo.dart';
import 'package:readerscorner/ui/widgets/btn.dart';
import 'package:readerscorner/ui/widgets/text.dart';
import 'package:readerscorner/scoped-models/main_model.dart';
import 'package:readerscorner/ui/base_view.dart';
import 'package:readerscorner/ui/widgets/loader.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
 final Map<String, dynamic> _formData = {
    "email": "ahmed@ahmed.com",
    "password": "123456",
  };



  @override
  Widget build(BuildContext context) {
    return  BaseView<MainModel>(
        builder: (context, child, model) => Loader(
        show: false,
          child: Scaffold(
        body: Stack(
          children: <Widget>[
            appLogo(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Padding(
                 padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                           _buildEmailTextField(),
                           _buildPasswordTextField(),

                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  elevation: 0.0,
                                  
                                  child: RaisedButton(
                          child: Text('Login'),
                          textColor: Colors.white,
                          color:Theme.of(context).primaryColor,
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            print('login');
                            print('_formData');
                            model.login(_formData, context);
                          },
                        )
                                    ),
                            ),
//                          Expanded(child: Container()),

                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: appText(
                                      text: 'Don\'t Have Account ? Sign Up',
                                    ))),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            // Visibility(
            //   visible: loading ?? true,
            //   child: Center(
            //     child: Container(
            //       alignment: Alignment.center,
            //       color: Colors.white.withOpacity(0.9),
            //       child: CircularProgressIndicator(
            //         valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

   Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      initialValue: '',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 5) {
          return 'Email is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
       obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      initialValue: '',
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 6) {
          return 'Password is required and should be 6+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

}
