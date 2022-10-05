import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/enums/button_type.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/category.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';
import 'package:shoppingify/widgets/ui/buttons/button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class NewItemForm extends StatefulWidget {
  const NewItemForm({Key? key, required this.categories}) : super(key: key);
  static const routeName = '/add-new-item';
  final List<Category> categories;

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  bool _autoValidate = false;
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _onAddNewItem() async {
    if (_categoryController.text.trim().isEmpty) {
      return;
    }
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => _isLoading = true);
        await context.read<CategoriesService>().addNewItem(Item(
            name: _nameController.text,
            note: _noteController.text,
            imageUrl: _imageController.text,
            category: _categoryController.text));

        Navigator.of(context).popAndPushNamed('/');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Item has been added successfully'),
          ),
        );
      } on DioError catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content:
                Text(error.response!.data['message'] ?? 'Something went wrong'),
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
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
                            validator: (value) => value!.isEmpty
                                ? 'Please enter an image'
                                : null),
                        const SizedBox(height: 20),
                        const Label(text: 'Category'),
                        const SizedBox(height: 5),
                        Autocomplete(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text == '') {
                              return const Iterable<String>.empty();
                            }

                            if (textEditingValue.text.trim() != '') {
                              setState(() {
                                _categoryController.text =
                                    textEditingValue.text;
                              });
                            }
                            return widget.categories
                                .map((category) =>
                                    StringMethods.capitalizeString(
                                        category.category))
                                .where(
                                  (category) => category.toLowerCase().contains(
                                        textEditingValue.text.toLowerCase(),
                                      ),
                                );
                          },
                          onSelected: (String selection) {
                            setState(() {
                              _categoryController.text = selection;
                            });
                          },
                        ),
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
                              onPressedHandler: () => _onAddNewItem(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
