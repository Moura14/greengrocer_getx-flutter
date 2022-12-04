import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validatores.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();
  ForgotPasswordDialog({required String email, Key? key}) : super(key: key) {
    emailController.text = email;
  }

  final formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Digite seu email para recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                CustomTextField(
                  formFieldKey: formFieldKey,
                  icon: Icons.email,
                  label: 'Email',
                  validator: emailValidator,
                  controller: emailController,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(width: 2, color: Colors.green),
                  ),
                  onPressed: () {
                    formFieldKey.currentState!.validate();
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
