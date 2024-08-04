import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Pages/details.dart';
import 'package:project_1/Widget/widget_support.dart';
import 'package:project_1/service/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool icecream = false, pizza = true, burger = false, salad = false;

  Stream? fooditemStream;

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  Widget allItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(
                    detail: ds["Detail"],
                    name: ds["Name"],
                    image: ds["Image"],
                    price: ds["Price"],
                  )),
                );
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              ds["Image"],
                              height: 170,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            ds["Name"],
                            style: AppWidget.semiBoldTextFeildStyle(),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Fresh and Healthy",
                            style: AppWidget.lightTextFeildStyle(),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "\$" + ds["Price"],
                            style: AppWidget.semiBoldTextFeildStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details(
                    detail: ds["Detail"],
                    name: ds["Name"],
                    image: ds["Image"],
                    price: ds["Price"],
                  )),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, bottom: 20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            ds["Image"],
                            height: 130,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                ds["Name"],
                                style: AppWidget.semiBoldTextFeildStyle(),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "Honey goat cheese",
                                style: AppWidget.lightTextFeildStyle(),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                "\$" + ds["Price"],
                                style: AppWidget.semiBoldTextFeildStyle(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Rahma,", style: AppWidget.semiBoldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.food_bank,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text("Yummy Food!", style: AppWidget.headTextFeildStyle()),
              Text(
                "Try it And You Will Be Back Again",
                style: AppWidget.lightTextFeildStyle(),
              ),
              const SizedBox(height: 30),
              showItem(),
              const SizedBox(height: 30),
              Container(height: 310, child: allItems()),
              const SizedBox(height: 30),
              allItemsVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                pizza = true;
                icecream = false;
                burger = false;
                salad = false;
              });
              fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: pizza ? Color.fromARGB(255, 146, 18, 28) : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/pizzaaa.png",
                  height: 42,
                  width: 42,
                  fit: BoxFit.cover,
                  color: pizza ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                pizza = false;
                icecream = false;
                burger = true;
                salad = false;
              });
              fooditemStream = await DatabaseMethods().getFoodItem("Burger");
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: burger ? Color.fromARGB(255, 146, 18, 28) : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/burgerr.png",
                  height: 42,
                  width: 42,
                  fit: BoxFit.cover,
                  color: burger ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                pizza = false;
                icecream = true;
                burger = false;
                salad = false;
              });
              fooditemStream = await DatabaseMethods().getFoodItem("Ice-cream");
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: icecream ? Color.fromARGB(255, 146, 18, 28) : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/icee.png",
                  height: 42,
                  width: 42,
                  fit: BoxFit.cover,
                  color: icecream ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                pizza = false;
                icecream = false;
                burger = false;
                salad = true;
              });
              fooditemStream = await DatabaseMethods().getFoodItem("Salad");
            },
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                    color: salad ? Color.fromARGB(255, 146, 18, 28) : Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/saladd.png",
                  height: 42,
                  width: 42,
                  fit: BoxFit.cover,
                  color: salad ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
