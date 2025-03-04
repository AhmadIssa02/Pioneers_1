import 'package:flutter/material.dart';
import 'package:new_app/model/item_model.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  const ItemTile({super.key, required this.item});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.network(
                widget.item.image,
                width: MediaQuery.of(context).size.width / 10,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(widget.item.name),
              Text("${widget.item.price}JD"),
              Expanded(child: SizedBox()),
              widget.item.quantity > 0
                  ? Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              widget.item.quantity--;
                              setState(() {});
                            },
                            child: Icon(Icons.remove)),
                        Expanded(
                            child: Text(
                          "${widget.item.quantity}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        ElevatedButton(
                            onPressed: () {
                              widget.item.quantity++;
                              setState(() {});
                            },
                            child: Icon(Icons.add)),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () =>
                          {widget.item.quantity = 1, setState(() {})},
                      child: Text("add to cart"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
