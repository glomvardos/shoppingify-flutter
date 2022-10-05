import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppingify/screens/add_new_item_screen/add_new_item_screen.dart';

class ShoppingListHeader extends StatelessWidget {
  const ShoppingListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF80485B),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.only(top: 17, right: 20),
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 13),
                    width: 160,
                    child: const Text(
                      "Didn't find what you need?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AddNewItemScreen.routeName);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 11),
                      ),
                    ),
                    child: const Text(
                      "Add item",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: 5,
          child: SvgPicture.asset(
            'assets/images/bottle.svg',
            height: 145,
          ),
        ),
      ],
    );
  }
}
