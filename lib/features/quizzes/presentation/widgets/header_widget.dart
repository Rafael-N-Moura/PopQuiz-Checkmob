import 'package:flutter/material.dart';
import 'package:popquiz/core/util/util.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
    required this.label,
    required this.icon,
    required this.function,
  }) : super(key: key);

  String? label;
  Icon icon;
  Function() function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 4, top: 10),
                  child: SingleChildScrollView(
                    child: Text(
                      label ?? 'Erro',
                      style: Util.heeaderTextStyle,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                  ),
                  child: GestureDetector(
                    onTap: function,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      child: Container(
                        child: icon,
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.white,
              thickness: 5,
            ),
          )
        ],
      ),
    );
  }
}
