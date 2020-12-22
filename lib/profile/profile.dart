import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/module.dart';
import 'package:email_validator/email_validator.dart';

class ProfileForm extends StatefulWidget {

  @override
  _ProfileFormState createState() => _ProfileFormState();
}
class _ProfileFormState extends State<ProfileForm> {

  final _formKey = GlobalKey<FormState>();
  final _childFormKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String salutation = '';

  String _name = '';
  bool checkboxValue = false;
  int radioValue = -1;

  bool showTermError = false;
  bool showRadioError = false;

  TextEditingController address = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          child: Center(
              child: Text(
                  'Profile',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Salutation'
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: [
                          DropdownMenuItem<String>(
                            value: "Mr",
                              child: Text('Mr.'),
                          ),
                          DropdownMenuItem<String>(
                            value: "Mrs",
                            child: Text('Mrs.'),
                          ),
                          DropdownMenuItem<String>(
                            value: "Miss",
                            child: Text('Ms.'),
                          )
                        ],
                        // value: salutation,
                        onChanged: (value) {
                          setState(() {
                            salutation = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Name'
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _name = value;
                          });
                        },

                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: phoneNumber,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12
                          )
                        ),
                        validator: (value) {
                          if (value.length !=10 ) {
                            return 'Mobile Number must be of 10 digit';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: 'Email'
                        ),
                        validator: (value) {
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: password,
                        obscureText: !_passwordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: confirmPassword,
                        obscureText: !_confirmPasswordVisible,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                            )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is required';
                          }
                          if (value != password.text) {
                            return 'Password not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      CheckboxListTile(
                        value: checkboxValue,
                        title: Text ('Terms and Conditions'),
                        onChanged: (value) {
                          setState(() {
                            checkboxValue = value;
                            showTermError = ! value;
                          });
                        },
                      ),
                      showTermError ? Text(
                          'Please accept term and conditions',
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ) : SizedBox(),
                      SizedBox(height: 10),
                      Row (
                        children: [
                          Flexible(
                            child: RadioListTile(
                              title: Text('Male'),
                              value: 0,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value;
                                  showRadioError = false;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            child: RadioListTile(
                              title: Text('Female'),
                              value: 1,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value;
                                  showRadioError = false;
                                });
                              },
                            ),
                          ),
                          
                          Flexible(
                            child: RadioListTile(
                              title: Text('Unknown'),
                              value: 2,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value;
                                  showRadioError = false;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      showRadioError ? Text(
                        'This field is required',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ) : SizedBox(),
                      SizedBox(height: 40),
                      Center(
                        child: FlatButton(
                          color: Colors.blue,
                          minWidth: 100,
                          height: 50,
                          onPressed: () {
                            validateForm(context);
                          },
                          child: Text('Submit'),
                        ),
                      ),
                      // Form(
                      //   key: _childFormKey,
                      //   child: TextFormField(
                      //     controller: address,
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     decoration: InputDecoration(
                      //         labelText: 'Child field'
                      //     ),
                      //     validator: (value) {
                      //       if (value.isEmpty) {
                      //         return 'This field is required';
                      //       }
                      //       return null;
                      //     },
                      //
                      //
                      //   ),
                      // ),
                    ],
                  ),

                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void validateForm(context) {
    // FormState form = Form.of(context);
    // form.save();
    if (radioValue < 0) {
      setState(() {
        showRadioError = true;
      });
    }
    if (!checkboxValue) {
      setState(() {
        showTermError = true;
      });
    }
    if (_formKey.currentState.validate() && !showTermError && !showRadioError)
    {
      _formKey.currentState.save();
      openDialog(
        context: context,
        content: Text('Validate Success')

      );
    }
  }
}


