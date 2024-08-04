import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_1/service/database.dart';
import 'package:project_1/service/shared_pref.dart';


class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  int total = 0;
  Timer? _timer;
  Stream<QuerySnapshot>? foodStream;

  void startTimer() {
    _timer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getthesharedpref() async {
    id = await SharedPref().getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getthesharedpref();
    if (id != null) {
      foodStream = await DatabaseMethods().getFoodCart(id!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    ontheload();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void calculateTotal(AsyncSnapshot<QuerySnapshot> snapshot) {
    total = 0;
    for (var doc in snapshot.data!.docs) {
      total += int.tryParse(doc["Total"].toString()) ?? 0;
    }
  }

  Widget foodCart() {
    return StreamBuilder<QuerySnapshot>(
      stream: foodStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text("Your cart is empty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)));
        }

        calculateTotal(snapshot);
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            String itemId = ds.id; // Document ID for removal
            String quantity = ds["Quantity"] ?? "1";
            String total = ds["Total"] ?? "0";
            String name = ds["Name"] ?? "Unknown";
            String image = ds["Image"] ?? "";

            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(quantity, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(width: 16.0),
                      image.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                image,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 80,
                              width: 80,
                              color: Colors.grey.shade200,
                              child: Center(child: Icon(Icons.image, color: Colors.grey.shade500)),
                            ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(height: 4.0),
                            Text("\$" + total, style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Color.fromARGB(255, 146, 19, 9)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Remove Item"),
                                content: Text("Are you sure you want to remove this item from your cart?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Remove"),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await DatabaseMethods().removeItemFromCart(id!, itemId);
                                      setState(() {}); 
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Cart", style: TextStyle(color:Colors.white,fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: foodCart(),
            ),
            Divider(thickness: 1.5, color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("\$" + total.toString(), style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Implement checkout functionality
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "CheckOut",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
