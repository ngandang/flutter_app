
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/module.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

ChangeNotifierProvider<CustomerInfo> createProfileView() {
  return ChangeNotifierProvider(
      create: (_) => CustomerInfo(),
      child: ProfileForm(),
  );
}
class ProfileForm extends StatefulWidget {

  @override
  _ProfileFormState createState() => _ProfileFormState();
}
class _ProfileFormState extends State<ProfileForm> {

  final _formKey = GlobalKey<FormState>();

  final _dateTimeKey = GlobalKey<FormFieldState>();

  final _format = DateFormat('dd/MM/yyyy, HH:mm:ss');

  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController datetime = TextEditingController();

  String salutation = '';

  String _name = '';
  bool checkboxValue = false;
  int radioValue = -1;

  bool showTermError = false;
  bool showRadioError = false;

  TextEditingController address = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool isChanged = false;

  var customerInfo = CustomerInfo(id: '123', name: 'ngan', email: 'ngan@gm.com');



  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerInfo>(
      builder: (context, info, child) {
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 200,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      labelText: 'Salutation'
                                  ),
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
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
                                      info.salutation = value;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },

                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  // controller: name,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  decoration: InputDecoration(
                                      labelText: 'Name'
                                  ),
                                  initialValue: info.name,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    info.name = value;
                                  },

                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          DateTimeField(
                            format: _format,
                            key: _dateTimeKey,
                            decoration: InputDecoration(
                              labelText: 'Date time',

                            ),
                            initialValue: DateTime.now(),
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  // firstDate: DateTime(1900),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  initialEntryMode: DatePickerEntryMode.calendar,
                                  selectableDayPredicate:
                                      (value) =>
                                      value.isBefore(DateTime.now().subtract(Duration(days: 1))) ? false : true,
                                    // value.weekday == 5 || value.weekday == 6 ? false : true,
                                  );
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                  initialEntryMode: TimePickerEntryMode.input
                                );
                                return DateTimeField.combine(date, time);
                              } else {
                                return currentValue;
                              }
                            },
                            autovalidate: isChanged,
                            onChanged: (value) {
                              _dateTimeKey.currentState.validate();
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
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            // controller: phoneNumber,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
                                errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                )
                            ),
                            validator: (value) {
                              if (value.length != 10) {
                                return 'Mobile Number must be of 10 digit';
                              }
                              return null;
                            },
                            onChanged: (value) {
                               info.phoneNumber = value;
                            },

                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            // controller: email,
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: InputDecoration(
                                labelText: 'Email'
                            ),
                            validator: (value) {
                              if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              info.email = value;
                            },
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  // controller: password,
                                  obscureText: !_passwordVisible,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off
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
                                  onChanged: (value) {
                                    info.password = value;
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  // controller: confirmPassword,
                                  obscureText: !_confirmPasswordVisible,
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,
                                  decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _confirmPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                          });
                                        },
                                      )
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    if (value != info.password) {
                                      return 'Password mismatch';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),


                          Row(
                            children: [
                              Flexible(
                                child: RadioListTile(
                                  title: Text('Male'),
                                  value: 'Male',
                                  groupValue: info.gender,
                                  onChanged: (value) {
                                    setState(() {
                                      info.gender = value;
                                      showRadioError = false;
                                    });
                                  },
                                ),
                              ),
                              Flexible(
                                child: RadioListTile(
                                  title: Text('Female'),
                                  value: 'Female',
                                  groupValue: info.gender,
                                  onChanged: (value) {
                                    setState(() {
                                    //   radioValue = value;
                                      showRadioError = false;
                                      info.gender = value;
                                    });
                                  },
                                ),
                              ),

                              Flexible(
                                child: RadioListTile(
                                  title: Text('Unknown'),
                                  value: 'Unknown',
                                  groupValue: info.gender,
                                  onChanged: (value) {
                                    setState(() {
                                      info.gender = value;
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
                          CheckboxListTileFormField(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text('Terms and Conditions'),
                            onSaved: (value) {
                              info.isAccept = value;
                            },
                            validator: (value) {
                              if(!value) {
                                return ' This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          // CheckboxListTile(
                          //   value: info.isAccept,
                          //   controlAffinity: ListTileControlAffinity.leading,
                          //   title: Text('Terms and Conditions'),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       info.isAccept = value;
                          //       showTermError = !value;
                          //     });
                          //   },
                          // ),
                          // showTermError ? Text(
                          //   'Please accept term and conditions',
                          //   style: TextStyle(
                          //       color: Colors.red
                          //   ),
                          // ) : SizedBox(),
                          SizedBox(height: 10),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                color: Colors.blue,
                                minWidth: 100,
                                height: 50,
                                onPressed: () {
                                  validateForm(context);
                                },
                                child: Text('Submit'),
                              ),
                              SizedBox(width: 20),
                              FlatButton(
                                color: Colors.grey,
                                minWidth: 100,
                                height: 50,
                                onPressed: () {
                                  _formKey.currentState.reset();
                                  setState(() {
                                    info.isAccept = false;
                                    info.gender = '';
                                    showRadioError = false;
                                    showTermError = false;
                                  });

                                },
                                child: Text('Reset'),
                              )
                            ],
                          ),
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
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  void resetForm() {
    _formKey.currentState.reset();

  }

  void validateForm(context) {
    // FormState form = Form.of(context);
    // form.save();

    final model = Provider.of<CustomerInfo>(context, listen: false);

    // if (model.gender.isEmpty ) {
    //   setState(() {
    //     showRadioError = true;
    //   });
    // }
    // if (!model.isAccept) {
    //   setState(() {
    //     showTermError = true;
    //   });
    // }
    if (_formKey.currentState.validate() )
    {
      openDialog(
        context: context,
        content: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(model.name),
              Text(model.email),
              Text(model.phoneNumber),
              Text(model.password)
            ],
          ),
        )

      );
    }
  }
}


