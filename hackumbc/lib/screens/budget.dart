import 'package:flutter/material.dart';
import 'package:hackumbc/components/constants.dart';
import 'package:hackumbc/globaldata.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:hackumbc/components/other_item.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<Budget> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                child: Container(
                    child: SfRadialGauge(axes: <RadialAxis>[

                  RadialAxis(

                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(widget: Text('\$' + total.toInt().toString() + '/\$100 Budget', style: kTitleStyle,))
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: total,
                        color: Colors.pinkAccent,
                        cornerStyle: CornerStyle.bothCurve,
                        dashArray: [],
                      )
                    ],
                  )
                ])),
              ),
            ),
            Center(
                child: Text('Your Suggested budget for Today is now ' + ((finals.length == 1) ? '\$12.00' : '\$8.00'), style:
                kTitleStyle,)
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History:",
                    style: kTitleStyle.copyWith(fontSize: 25),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Text(
                  //     'More',
                  //     style: TextStyle(color: Colors.pinkAccent),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 5000,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.vertical,
                itemCount: finals.length,
                itemBuilder: (_, i) => Container(height: 100, child: OtherItem(item: finals[i])),
                separatorBuilder: (_, __) => SizedBox(height: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
