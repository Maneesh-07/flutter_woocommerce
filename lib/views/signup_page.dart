import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/models/customers.dart';
import 'package:flutter_woocommerce/services/api_services.dart';
import 'package:flutter_woocommerce/utils/form_helper.dart';
import 'package:flutter_woocommerce/utils/progressuhd.dart';
import 'package:flutter_woocommerce/utils/validator_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APIService? apiService;
  late CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;


  @override
  void initState() {
    apiService = APIService();
    model = CustomerModel(email: '', firstName: '', lastNmae: '', password: '');
    super.initState();
  }

  @override
  void dispose() {
    _formUI();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: const Text("Sign Up"),
      ),
      body: ProgressHud(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Nmae"),
                FormHelper.textInput(
                  context,
                  model.firstName ,
                  (value) => {
                    this.model.firstName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter Firest Name';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Nmae"),
                FormHelper.textInput(
                    context,
                    model.lastNmae ,
                    (value) => {
                          this.model.lastNmae = value,
                        }, onValidate: (value) {
                  return null;
                }),
                FormHelper.fieldLabel("Email Id"),
                FormHelper.textInput(
                    context,
                    model.email ,
                    (value) => {
                          this.model.email = value,
                        }, onValidate: (value) {
                  if (value?.toString().isEmpty ?? true) {
                    return 'Please Enter Email Id';
                  }
                  if (value.toString().isNotEmpty &&
                      !value.toString().isValidEmail()) {
                    return 'Please enter Valid Email Id';
                  }

                  return null;
                }),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                model.password ,
                  (value) => {
                    this.model.password = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                    icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton("register", () {
                    if (validateAndSave()) {
                      print(model.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });
                      apiService?.createCustomer(model).then(
                        (ret) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    } else {
                      FormHelper.showMessage(context, "WooApp",
                          "Email Id already registered", "Ok", () {
                        Navigator.of(context).pop();
                      });
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
