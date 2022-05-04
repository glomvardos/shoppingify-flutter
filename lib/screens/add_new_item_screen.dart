import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shoppingify/enums/button-type.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/api/api.dart';
import 'package:shoppingify/widgets/ui/buttons/button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);
  static const routeName = '/add-new-item';

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final _api = ApiService();

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
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => _isLoading = true);

        await _api.addNewItem(Item(
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
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content:
                Text(e.response!.data['message'] ?? 'Something went wrong'),
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
      body: _isLoading
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
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a name'
                                  : null),
                          const SizedBox(height: 20),
                          const Label(text: 'Note'),
                          const SizedBox(height: 5),
                          InputField(
                              inputLines: 7,
                              labelText: 'Enter a note',
                              controller: _noteController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a note'
                                  : null),
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
                          InputField(
                              labelText: 'Enter a category',
                              controller: _categoryController,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter a category'
                                  : null),
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
            ),
    );
  }
}
