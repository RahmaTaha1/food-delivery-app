import 'package:flutter/material.dart';
import 'package:project_1/Widget/widget_support.dart';
import 'package:project_1/service/database.dart';
import 'package:project_1/service/shared_pref.dart';

class Details extends StatefulWidget {
  final String image, name, detail, price;

  const Details({
    required this.detail,
    required this.name,
    required this.image,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  int total = 0;
  String? id;

  @override
  void initState() {
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  Future<void> ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  Future<void> getthesharedpref() async {
    id = await SharedPref().getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.5,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.name,
                style: AppWidget.semiBoldTextFeildStyle(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                          total -= int.parse(widget.price);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    quantity.toString(),
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                        total += int.parse(widget.price);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                widget.detail,
                style: AppWidget.lightgreyTextFeildStyle(),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Delivery Time",
                    style: AppWidget.semiBoldTextFeildStyle(),
                  ),
                  const SizedBox(width: 30),
                  const Icon(Icons.alarm, color: Colors.black54),
                  const SizedBox(width: 5),
                  Text("45 min", style: AppWidget.semiBoldTextFeildStyle()),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: AppWidget.semiBoldTextFeildStyle(),
                        ),
                        Text(
                          "\$${total.toString()}",
                          style: AppWidget.boldTextFeildStyle(),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> addFoodToCart = {
                          "Name": widget.name,
                          "Quantity": quantity.toString(),
                          "Total": total.toString(),
                          "Image": widget.image,
                        };
                        await DatabaseMethods().addFoodToCart(addFoodToCart, id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orangeAccent,
                            content: Text(
                              "Food Added to Cart",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
