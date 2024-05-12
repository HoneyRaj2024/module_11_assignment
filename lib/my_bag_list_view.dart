import 'package:flutter/material.dart';
import 'my_bag_list_item.dart';

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
