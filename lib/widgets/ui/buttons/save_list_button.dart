import 'package:flutter/material.dart';

class SaveListButton extends StatelessWidget {
  const SaveListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            width: 310,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorStyle: TextStyle(fontSize: 12),
                      errorMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      labelText: 'Enter a name',
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),

                    // border: InputBorder.none,
                    // ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
