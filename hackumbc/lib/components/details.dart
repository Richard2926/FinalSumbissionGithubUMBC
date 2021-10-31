import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final Map item;
  const Details({
    Key ?key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['foodName'],
                style: kTitleStyle.copyWith(fontSize: 18),
              ),
              SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: kBlackColor.withOpacity(0.7),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(height: 20),
          Row(
            children: [

              // Icon(Icons.horizontal_rule, color: kBlackColor.withOpacity(0.7),),
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 10),
                // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                // ignore: deprecated_member_use
                child: MaterialButton(onPressed: () async{
                  await launch(item['foodLink']);
                },
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        item['storeImg'],
                        height: MediaQuery.of(context).size.height * 0.04,
                        fit: BoxFit.contain,
                      ),
                    ),

                    Text(item['storeName'], style: kTitleStyle,),
                  ],
                )),
              ),
              // Icon(Icons.add, color: kPrimaryColor),
              Spacer(),
              Text('\$${item['price'].toStringAsFixed(2)}', style: kTitleStyle.copyWith(fontSize: 18))
            ],
          ),
        ],
      ),
    );
  }
}