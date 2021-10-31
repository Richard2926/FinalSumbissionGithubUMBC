import 'package:flutter/material.dart';
import 'package:hackumbc/screens/item_details_screen.dart';

import 'constants.dart';

// import '../../../constants.dart';

class OtherItem extends StatelessWidget {
  final Map item;

  const OtherItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  void onTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ItemDetailsSreen(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    String manipulate(String x) {
      x = x.toLowerCase();
      List list = x.split(' ');
      if (list.length < 2) {
        x = x.toLowerCase();
        return "${x[0].toUpperCase()}${x.substring(1)}";
      }
      return "${list[0][0].toUpperCase()}${list[0].substring(1)} ${list[1][0].toUpperCase()}${list[1].substring(1)}";
    }
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        // width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Hero(
                    tag: item['foodID'],
                    child: Image.network(
                      item['foodURL'],
                      height: constraints.maxHeight * 0.65,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(manipulate(item['foodName']), style: kTitleStyle),
                        Text(item['storeName'], style: kDescriptionStyle),


                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 15),
                      child: Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: kTitleStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
                //
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 10.0),
                //       child: Flexible(child: Text(item['foodName'], style: kTitleStyle)),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 10.0),
                //       child: Text(item['storeName'], style: kDescriptionStyle),
                //     ),
                //     Spacer(),
                //   ],
                // ),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 10.0, bottom: 15),
                //       child: Text(
                //         '\$${item['price'].toStringAsFixed(2)}',
                //         style: kTitleStyle.copyWith(fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //     // Padding(
                //     //   padding: const EdgeInsets.all(8.0),
                //     //   child: Container(
                //     //     padding: const EdgeInsets.all(7),
                //     //     decoration: BoxDecoration(
                //     //       color: kPrimaryColor,
                //     //       borderRadius: BorderRadius.circular(10),
                //     //     ),
                //     //     child: Icon(
                //     //       Icons.add,
                //     //       size: 20,
                //     //       color: Colors.white,
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
