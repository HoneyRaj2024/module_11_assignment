import 'package:flutter/material.dart';

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
