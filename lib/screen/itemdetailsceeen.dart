import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import '../model/item.dart';
import '../model/user.dart';
import '../myconfig.dart';

class ItemDetailScreen extends StatefulWidget {
  final User user;
  final Item item;
  const ItemDetailScreen({super.key, required this.user, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int currentImageIndex = 0;
  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;
  late double screenHeight, screenWidth, cardwitdh;
  final df = DateFormat('dd-MM-yyyy hh:mm a');
  @override
  void initState() {
    super.initState();
    qty = int.parse(widget.item.itemQty.toString());
    totalprice = double.parse(widget.item.itemPrice.toString());
    singleprice = double.parse(widget.item.itemPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    List<String> imageUrls = [
      "${MyConfig().SERVER}/barterit/assets/items/${widget.item.itemId}.1.png",
      "${MyConfig().SERVER}/barterit/assets/items/${widget.item.itemId}.2.png",
      "${MyConfig().SERVER}/barterit/assets/items/${widget.item.itemId}.3.png",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Item Details")),
      body: Column(
        children: [
          Flexible(
              flex: 4,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: false,
                shrinkWrap: true,
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                    child: Card(
                      child: Container(
                        width: screenWidth,
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              )),
          Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.item.itemName.toString(),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(6),
                },
                children: [
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        widget.item.itemDesc.toString(),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Quantity Available",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        widget.item.itemQty.toString(),
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        "RM ${double.parse(widget.item.itemPrice.toString()).toStringAsFixed(2)}",
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        "${widget.item.itemLocality}/${widget.item.itemState}",
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const TableCell(
                      child: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        df.format(
                            DateTime.parse(widget.item.itemDate.toString())),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Column(
          //   children: [
          //     Container(
          //   padding: const EdgeInsets.all(8),
          //   child:
          //       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //     IconButton(
          //         onPressed: () {
          //           if (userqty <= 1) {
          //             userqty = 1;
          //             totalprice = singleprice * userqty;
          //           } else {
          //             userqty = userqty - 1;
          //             totalprice = singleprice * userqty;
          //           }
          //           setState(() {});
          //         },
          //         icon: const Icon(Icons.remove)),
          //     Text(
          //       userqty.toString(),
          //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //     ),
          //     IconButton(
          //         onPressed: () {
          //           if (userqty >= qty) {
          //             userqty = qty;
          //             totalprice = singleprice * userqty;
          //           } else {
          //             userqty = userqty + 1;
          //             totalprice = singleprice * userqty;
          //           }
          //           setState(() {});
          //         },
          //         icon: const Icon(Icons.add)),
          //   ]),
          // ),
          // Text(
          //   "RM ${totalprice.toStringAsFixed(2)}",
          //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          // ElevatedButton(
          //     onPressed: () {
          //       addtocartdialog();
          //     },
          //     child: const Text("   Add to Cart   "))

          //   ],
          // ))
        ],
      ),
    );
  }
}
