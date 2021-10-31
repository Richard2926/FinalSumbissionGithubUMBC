import 'package:flutter/material.dart';

import 'constants.dart';

// import '../../../constants.dart';

class GroceryItem extends StatelessWidget {
  final Map item;

  const GroceryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  void onTap(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (_) => ItemDetailsSreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: item.hashCode,
                    child: Image.network(
                      item['foodURL'],
                      height: constraints.maxHeight * 0.65,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Flexible(child: Text(item['foodName'], style: kTitleStyle)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(item['storeName'], style: kDescriptionStyle),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 15),
                      child: Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: kTitleStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(7),
                    //     decoration: BoxDecoration(
                    //       color: kPrimaryColor,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Icon(
                    //       Icons.add,
                    //       size: 20,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
