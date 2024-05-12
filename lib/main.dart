import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({Key? key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  int total = 0; // Initialize total here

  List<int> itemCounts = [0];

  void updateTotal(int price) {
    setState(() {
      total += price;
    });
  }

  void _updateItemCount(int index, int count) {
    if (index >= itemCounts.length) {
      itemCounts.add(count);
    } else {
      itemCounts[index] = count;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "My Bag",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MyBagListView(updateTotal: updateTotal, updateItemCount: _updateItemCount),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount:",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    Text(
                      "$total\$",
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.red,
              ),
              child: TextButton(
                onPressed: () {
                  showCheckoutDialog(context, itemCounts.reduce((a, b) => a + b));
                },
                child: const Text(
                  "CHECK OUT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCheckoutDialog(BuildContext context, int totalItems) {
    if (totalItems == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "You have not added any items yet!",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'OKAY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Congratulations!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You have added \n $totalItems items \n on your bag!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'OKAY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

}

class MyBagListView extends StatelessWidget {
  final List<String> titles = ["Pullover", "T-Shirt", "Sport Dress"];
  final List<String> colorsName = ["Color:", "Color:", "Color:"];
  final List<String> colorValue = ["Black", "Gray", "Black"];
  final List<String> sizesName = ["Size:", "Size:", "Size:"];
  final List<String> sizesValue = ["L", "L", "M"];
  final List<int> prices = [51, 30, 43, 90];
  final List<String> images = ["assets/photo.png", "assets/photo2.png", "assets/photo3.png"];
  final Function(int) updateTotal;
  final Function(int, int) updateItemCount;

  MyBagListView({required this.updateTotal, required this.updateItemCount});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return MyBagListItem(
          index: index,
          title: titles[index],
          colorName: colorsName[index],
          colorValue: colorValue[index],
          sizeName: sizesName[index],
          sizeValue: sizesValue[index],
          price: prices[index],
          imagePath: images[index],
          updateTotal: updateTotal,
          updateItemCount: updateItemCount,
        );
      },
    );
  }
}

class MyBagListItem extends StatefulWidget {
  final int index;
  final String title;
  final String colorName;
  final String colorValue;
  final String sizeName;
  final String sizeValue;
  final int price;
  final String imagePath;
  final Function(int) updateTotal;
  final Function(int, int) updateItemCount;

  MyBagListItem({
    required this.index,
    required this.title,
    required this.colorName,
    required this.colorValue,
    required this.sizeName,
    required this.sizeValue,
    required this.price,
    required this.imagePath,
    required this.updateTotal,
    required this.updateItemCount,
  });

  @override
  _MyBagListItemState createState() => _MyBagListItemState();
}

class _MyBagListItemState extends State<MyBagListItem> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width: 120.0,
                height: 120.0,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.more_vert, color: Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    Column(
                        children: [
                          Row(
                            children: [
                              Text('${widget.colorName}',
                                style: const TextStyle(color: Colors.grey),),
                              const SizedBox(width: 5,),
                              Text('${widget.colorValue}',
                                style: const TextStyle(color: Colors.black),),
                            ],
                          ),
                        ]
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(' ${widget.sizeName}',
                                  style: const TextStyle(color: Colors.grey,),),
                                const SizedBox(width: 5,),
                                Text(' ${widget.sizeValue}',
                                  style: const TextStyle(color: Colors.black),),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (itemCount > 0) {
                            itemCount--;
                            widget.updateTotal(-widget.price);
                            widget.updateItemCount(widget.index, itemCount);
                          }
                        });
                      },
                      child: Image.asset(
                          'assets/minus.png', width: 45.0, height: 45.0),
                    ),
                    const SizedBox(width: 10,),
                    Text('$itemCount'),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          itemCount++;
                          widget.updateTotal(widget.price);
                          if (itemCount % 5 == 0 && itemCount != 0) {
                            showAboveTotalDialog(context, widget.title);
                          }
                          widget.updateItemCount(widget.index, itemCount);
                        });
                      },
                      child: Image.asset(
                          'assets/plus.png', width: 45.0, height: 45.0),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(width: 110,),
                    Text('${widget.price}\$', style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAboveTotalDialog(BuildContext context, String itemName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "You have added 5 $itemName on your bag!",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'OKAY',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
