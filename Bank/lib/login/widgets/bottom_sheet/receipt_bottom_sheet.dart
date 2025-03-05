import 'package:flutter/material.dart';
import 'package:new_app/model/item_model.dart';

class ReceiptBottomSheet extends StatefulWidget {
  final List<ItemModel> itemsList;
  const ReceiptBottomSheet({super.key, required this.itemsList});
  @override
  State<ReceiptBottomSheet> createState() => _ReceiptBottomSheetState();
}

class _ReceiptBottomSheetState extends State<ReceiptBottomSheet> {
  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < widget.itemsList.length; i++) {
      total += widget.itemsList[i].price * widget.itemsList[i].quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("RECEIPT "),
        Container(
          color: Colors.white38,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Text("Item Name"),
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text("Item Price")),
              Expanded(child: SizedBox()),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Text("Item Quantity"),
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Text("Total Price"),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.itemsList.length,
              itemBuilder: (ctx, index) {
                //TODO SETSTATE HERE WILL CREATE AN ERROR
                return Container(
                  color: Colors.white38,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(widget.itemsList[index].name),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Text("${widget.itemsList[index].price}")),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text("${widget.itemsList[index].quantity}"),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(
                            "${widget.itemsList[index].price * widget.itemsList[index].price}"),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          color: Colors.white38,
          child: Text("total price ${calculateTotal()}"),
        )
      ],
    );
  }
}
