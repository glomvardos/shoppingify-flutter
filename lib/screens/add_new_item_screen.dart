import 'package:flutter/material.dart';
import 'package:shoppingify/enums/button-type.dart';
import 'package:shoppingify/widgets/ui/button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);
  static const routeName = '/add-new-item';

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Label(text: 'Name'),
                    const SizedBox(height: 5),
                    InputField(
                        labelText: 'Enter a name',
                        controller: _nameController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a name' : null),
                    const SizedBox(height: 20),
                    const Label(text: 'Note'),
                    const SizedBox(height: 5),
                    InputField(
                        inputLines: 7,
                        labelText: 'Enter a note',
                        controller: _noteController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a note' : null),
                    const SizedBox(height: 20),
                    const Label(text: 'Image'),
                    const SizedBox(height: 5),
                    InputField(
                        labelText: 'Enter an image',
                        controller: _imageController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter an image' : null),
                    const SizedBox(height: 20),
                    const Label(text: 'Category'),
                    const SizedBox(height: 5),
                    InputField(
                        labelText: 'Enter a category',
                        controller: _imageController,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter a category' : null),
                    const SizedBox(height: 20),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          type: ButtonType.secondary,
                          text: 'cancel',
                          onPressedHandler: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 20),
                        Button(
                          type: ButtonType.primary,
                          text: 'Save',
                          onPressedHandler: () => {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
