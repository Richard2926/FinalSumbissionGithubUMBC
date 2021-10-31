import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hackumbc/components/constants.dart';
import 'package:hackumbc/components/food_card.dart';
import 'package:hackumbc/components/grid_product.dart';
import 'package:hackumbc/components/grocery_item.dart';
import 'package:hackumbc/components/other_item.dart';
import '../globaldata.dart';
import 'budget.dart';
import "string_extension.dart";
import 'package:rect_getter/rect_getter.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final Future<QuerySnapshot> _documents =
      FirebaseFirestore.instance.collection('foods').where('price', isLessThanOrEqualTo: budget).get();
  Color priceColor = Colors.pinkAccent.withOpacity(0.3);
  bool reverse = false;
  List reversedList = [];
  List properList = [];
  bool showOther = false;
  List ramen = [];
  List chicken = [];

  //
  // final Duration animationDuration = Duration(milliseconds: 300);
  // final Duration delay = Duration(milliseconds: 300);
  //
  // // GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  // static late Rect rect;
  // var globalKey = RectGetter.createGlobalKey();
  // var rectGetter;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   RectGetter rectGetter = new RectGetter(
  //     key: globalKey,
  //     child: Container(),
  //   );
  //
  // }
  // void _onTap() async {
  //   setState(() => rect = rectGetter.getRect());
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     setState(() =>
  //     rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
  //     Future.delayed(animationDuration + delay, _goToNextPage);
  //   });
  // }
  //
  // void _goToNextPage() {
  //   // Navigator.of(context)
  //   //     .push(FadeRouteBuilder(page: NewPage()))
  //   //     .then((_) => setState(() => rect = null));
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // floatingActionButton: RectGetter(
          //   key: rectGetter.(),
          //   child: FloatingActionButton(
          //     onPressed: _onTap,
          //     child: Icon(Icons.mail_outline),
          //   ),
          // ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Budget()),
              );
            },
            label: const Text('Budget'),
            icon: const Icon(Icons.calendar_today_rounded),
            backgroundColor: Colors.pinkAccent,
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: _documents,
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return const Center(
                  child: SpinKitCubeGrid(
                    color: Colors.black,
                    size: 50.0,
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                QuerySnapshot data = snapshot.data as QuerySnapshot;
                List all = [];
                foods = [];
                jap = [];
                mex = [];
                healthy = [];
                for (QueryDocumentSnapshot i in data.docs) {
                  var doc = i.data();
                  all.add(doc);
                  if (budget < 10) {
                    if (doc['foodName'].toLowerCase().contains('chicken') ||
                        doc['description'].toLowerCase().contains('chicken')) {
                      ramen.add(doc);
                    }
                  } else {
                    if (doc['foodName'].toLowerCase().contains('ramen') || doc['description'].toLowerCase().contains('ramen')) {
                      ramen.add(doc);
                    }
                  }
                  if (doc['categories'] == "100") {
                    jap.add(doc);
                  } else if (doc['categories'] == "011") {
                    healthy.add(doc);
                    mex.add(doc);
                  } else if (doc['categories'] == "010") {
                    mex.add(doc);
                  } else if (doc['categories'] == "001") {
                    healthy.add(doc);
                  } else {
                    foods.add(doc);
                  }
                  reversedList = List.from(all.reversed);
                  properList = reversedList;
                }
                jap.removeRange(0, 15);
                mex.removeRange(0, 10);
                healthy.removeRange(0, 18);
                foods.removeRange(0, 14);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        height: 40,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          onSubmitted: (String text) {
                            setState(() {
                              showOther = true;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FilterChip(
                                  label: Text("Fast Food"),
                                  backgroundColor: Colors.pinkAccent.withOpacity(0.3),
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    print("selected");
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FilterChip(
                                  label: Text("Price Low To High"),
                                  backgroundColor: priceColor,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    this.setState(() {
                                      priceColor = Colors.transparent;
                                      reverse = !reverse;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: FilterChip(
                                  label: Text("Distance : 5 miles"),
                                  backgroundColor: Colors.transparent,
                                  shape: StadiumBorder(side: BorderSide()),
                                  onSelected: (bool value) {
                                    print("selected");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      showOther
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Filtered:",
                                        style: kTitleStyle.copyWith(fontSize: 25),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          'See all',
                                          style: TextStyle(color: Colors.pinkAccent),
                                        ),
                                      ),
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
                                    itemCount: 20,
                                    itemBuilder: (_, i) => Container(height: 100, child: OtherItem(item: ramen[i])),
                                    separatorBuilder: (_, __) => SizedBox(height: 10),
                                  ),
                                )
                              ],
                            )
                          : reverse
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Filtered:",
                                            style: kTitleStyle.copyWith(fontSize: 25),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              'See all',
                                              style: TextStyle(color: Colors.pinkAccent),
                                            ),
                                          ),
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
                                        itemCount: 20,
                                        itemBuilder: (_, i) => Container(height: 100, child: OtherItem(item: properList[i])),
                                        separatorBuilder: (_, __) => SizedBox(height: 10),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    newone(context, "Japanese", jap),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    newone(context, "Mexican", mex),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    newone(context, "Healthy", healthy),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Other",
                                            style: kTitleStyle.copyWith(fontSize: 25),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Text(
                                              'See all',
                                              style: TextStyle(color: Colors.pinkAccent),
                                            ),
                                          ),
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
                                        itemCount: 20,
                                        itemBuilder: (_, i) => Container(height: 100, child: OtherItem(item: foods[i])),
                                        separatorBuilder: (_, __) => SizedBox(height: 10),
                                      ),
                                    )
                                  ],
                                )

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //   child: Container(child: SearchBar(),
                      //   height: 80,),
                      // ),
                      // category(
                      //   context,
                      //   jap,
                      //   "Japanese",
                      //   Color.fromRGBO(125, 164, 227, 1.0),
                      // ),
                      // category(context, mex, "Mexican", Color.fromRGBO(235, 167, 21, 1.0)),
                      // category(context, healthy, "Healthy", Color.fromRGBO(164, 180, 140, 1.0)),
                    ],
                  ),
                );
              }

              return const Center(
                child: SpinKitCubeGrid(
                  color: Colors.pinkAccent,
                  size: 50.0,
                ),
              );
            },
          ),
        ),
        // _ripple(),
      ],
    );
  }

  Widget newone(BuildContext context, String text, List stuff) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: kTitleStyle.copyWith(fontSize: 25),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'See all',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.42,
          child: ListView.separated(
            // reverse: reverse,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: stuff.length,
            itemBuilder: (_, i) => GroceryItem(item: stuff[i]),
            separatorBuilder: (_, __) => SizedBox(width: 10),
          ),
        ),
      ],
    );
  }

  String manipulate(String x) {
    x = x.toLowerCase();
    List list = x.split(' ');
    if (list.length < 2) {
      x = x.toLowerCase();
      return "${x[0].toUpperCase()}${x.substring(1)}";
    }
    return "${list[0][0].toUpperCase()}${list[0].substring(1)} ${list[1][0].toUpperCase()}${list[1].substring(1)}";
  }

  Widget category(BuildContext context, List filtered, String text, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.black, fontFamily: 'Cookie', fontSize: 30),
              ),
              Text(
                'More',
                style: TextStyle(color: Colors.pinkAccent, fontFamily: 'Cookie', fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: filtered.length,
              itemBuilder: (BuildContext context, int index) {
                Map food = filtered[index];
                // return Container(
                //     margin: const EdgeInsets.only(top: 10.0),
                //     child: FoodCard(
                //       width: MediaQuery.of(context).size.width/2.2,
                //       primaryColor: Colors.pinkAccent,
                //       productName: manipulate(food['foodName']),
                //       productPrice: "\$" + food['price'].toStringAsFixed(2),
                //       productUrl: food['foodURL'],
                //       // productClients: product['clients'],
                //       // productRate: product['rate'],
                //     ));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: MediaQuery.of(context).size.height / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: Image.network(
                            food['foodURL'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 13,
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        manipulate(food['foodName']),
                                        style: TextStyle(fontFamily: 'Cookie', fontSize: 25),
                                      ),
                                      Text(
                                        "\$" + food['price'].toStringAsFixed(2),
                                        style: TextStyle(fontFamily: 'Cookie', fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       food['storeName'],
                                  //       style: TextStyle(fontFamily: '', fontSize: 10, color: Colors.white),
                                  //     ),
                                  //     Text(
                                  //       "2 Miles",
                                  //       style: TextStyle(fontFamily: '', fontSize: 10, color: Colors.white),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
// Widget _ripple() {
//   if (rect == null) {
//     return Container();
//   }
//   return AnimatedPositioned(
//     duration: animationDuration,
//     left: rect.left,
//     right: MediaQuery.of(context).size.width - rect.right,
//     top: rect.top,
//     bottom: MediaQuery.of(context).size.height - rect.bottom,
//     child: Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.blue,
//       ),
//     ),
//   );
// }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
