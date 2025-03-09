import 'package:flutter/material.dart';
import 'package:new_app/model/item_model.dart';

class ReceiptBottomSheet extends StatefulWidget {
  final List<ItemModel> itemsList;
  final Function(ItemModel) onDelete;
  final Function(ItemModel) onRemove;
  final Function(ItemModel) onAdd;
  const ReceiptBottomSheet(
      {super.key,
      required this.itemsList,
      required this.onDelete,
      required this.onRemove,
      required this.onAdd});
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
              SizedBox(width: 4),
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
              Expanded(child: SizedBox()),
              SizedBox(
                width: MediaQuery.of(context).size.width / 10,
                child: Icon(Icons.receipt),
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
                      SizedBox(width: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(widget.itemsList[index].name),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Text("${widget.itemsList[index].price}")),
                      Expanded(child: SizedBox()),
                      //TODO + - (and at 0 delete ) use callback
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: () {
                                  if (widget.itemsList[index].quantity == 1) {
                                    widget.onDelete(widget.itemsList[index]);
                                    widget.itemsList.removeAt(index);
                                  } else {
                                    widget.onRemove(widget.itemsList[index]);
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 18,
                                )),
                            Text(
                              "${widget.itemsList[index].quantity}",
                              style: TextStyle(fontSize: 16),
                            ),
                            InkWell(
                              onTap: () {
                                widget.onAdd(widget.itemsList[index]);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Text(
                            "${widget.itemsList[index].price * widget.itemsList[index].price}"),
                      ),
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                        child: IconButton(
                          onPressed: () {
                            widget.onDelete(widget.itemsList[index]);
                            widget.itemsList.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Container(
          color: Colors.white38,
          child: Text("total price ${calculateTotal()} JD"),
        )
      ],
    );
  }
}
