import 'package:flutter/material.dart';
import 'package:new_app/login/widgets/bottom_sheet/receipt_bottom_sheet.dart';
import 'package:new_app/login/widgets/tiles/item_tile.dart';
import 'package:new_app/model/item_model.dart';

class CapitalMartView extends StatefulWidget {
  const CapitalMartView({super.key});

  @override
  State<CapitalMartView> createState() => _CapitalMartViewState();
}

class _CapitalMartViewState extends State<CapitalMartView> {
  // static const List<String> itemsList = ["1", "2", "3", "4"];
  static List<ItemModel> itemsList = [
    ItemModel(
        image:
            "https://appleman.pk/cdn/shop/products/iPhone-11-1_086be1d4-8f62-46b9-89d2-76be66dce6bd.jpg?v=1667315355",
        name: "iphone11",
        price: 899.9),
    ItemModel(
        image:
            "https://jormall.net/cdn/shop/products/bx31mFm_800x.jpg?v=1644764318",
        name: "Samsung s22",
        price: 254.9),
    ItemModel(
        image:
            "https://images-na.ssl-images-amazon.com/images/I/814jcmzPhXL._SS400_.jpg",
        name: "LG",
        price: 154.9),
    ItemModel(
        image:
            "https://vintagemobile.fr/cdn/shop/files/Nokia-3310-Vintage-Mobile-777_1024x.jpg?v=1684801535",
        name: "Nokia331",
        price: 7.5),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
              itemCount: itemsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, index) {
                return ItemTile(
                  item: itemsList[index],
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                final newList =
                    itemsList.where((element) => element.quantity > 0).toList();
                if (newList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("No Item in Cart"),
                  ));
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ReceiptBottomSheet(
                          itemsList: newList,
                          onDelete: (item) {
                            for (int i = 0; i < itemsList.length; i++) {
                              if (itemsList[i].name == item.name) {
                                itemsList[i].quantity = 0;
                              }
                            }
                          });
                    },
                  ).then((c) {
                    setState(() {});
                  });
                }
              },
              child: Text("Checkout")),
        )
      ],
    );
  }
}
