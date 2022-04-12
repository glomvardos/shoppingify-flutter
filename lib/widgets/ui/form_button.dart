import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({Key? key, required this.text, required this.onClickHandler})
      : super(key: key);
  final String text;
  final Function onClickHandler;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onClickHandler(),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }
}
