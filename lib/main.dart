import 'dart:convert'; //it is required to convert JsonData

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

var bannerItems = [
  "Burger",
  "Cheese chilly",
  "Noodles",
  "Pizza"
]; //this is image's(snacks) name.
var bannerImages = [
  //images
  "assets/Burger.jpg",
  "assets/chilli-cheese-toast.jpg",
  "assets/Noodles.jpg",
  "assets/Pizza.webp",
]; // variable defined, the variable contains images and its name.

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    /*  the line `MediaQuery.of(context).size.height` is used to obtain the height of the screen in a mobile app.

    This expression utilizes the MediaQuery` class, which provides information about the device's screen and layout constraints.

    Specifically, `size` refers to the screen's dimensions, and `height` extracts the vertical height of the screen.

  Storing this value in the variable `screenHeight` allows you to access and use the screen's height for various layout and design purposes within your Flutter app. */

    double screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = [];
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");

      // Future<List<Widget>> createList() async: This defines an asynchronous function named createList that returns a Future containing a list of widgets (List<Widget>). The async keyword indicates that the function can perform asynchronous operations.
      //
      // List<Widget> items = [ ];: This initializes an empty list named items, which will store a collection of widgets.
      //
      // String dataString = await DefaultAssetBundle.of(context).loadString("assets/data.json");: In this line, a string variable named dataString is declared. The await keyword is used to pause the execution of the function until the asynchronous operation is completed.
      //
      // DefaultAssetBundle.of(context) obtains the default asset bundle for the current context. An asset bundle is a container for static resources like images, fonts, and JSON files that are packaged with the app.
      //
      // .loadString("assets/data.json") is called on the asset bundle. This function asynchronously loads the content of the specified asset file. In this case, it's loading the content of a JSON file named "data.json" from the "assets" directory.
      //
      // The loaded JSON content is assigned to the dataString variable.

      List<dynamic> dataJSON = jsonDecode(
          dataString); // jsonDecode function used parse JSON-formatted strings into Dart objects

      dataJSON.forEach((object) {
        String finalString = "";
        List<dynamic> dataList = object["placeItems"];
        dataList.forEach((item) {
          finalString = finalString + item + " | ";
        });
        items.add(
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2.0,
                          blurRadius: 5.0),
                    ]),
                margin: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      child: Image.asset(object["placeImage"],
                          width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(object["placeName"]),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                finalString,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.black54),
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              "min. Order: ${object["minOrder"]}",
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      });
      return items;
    }

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                    const Text(
                      "foodies",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.person)),
                  ],
                ),
              ),
              const BannerWidgetArea(),
              FutureBuilder(
                  initialData: <Widget>[const Text("")],
                  future: createList(),
                  builder: (context, snapshort) {
                    if (snapshort.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: snapshort.data!,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.no_food),
      ),
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  const BannerWidgetArea({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    PageController controller =
        PageController(viewportFraction: 0.8, initialPage: 1);

    List<Widget> banners = [];
    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      offset: Offset(3.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Image.asset(
                bannerImages[x],
                fit: BoxFit.cover,
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black]))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bannerItems[x],
                    style: const TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  const Text(
                    'more then 40% off',
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      );
      banners.add(bannerView);
    }
    return Container(
      width: 400,
      height: 280,
      child: PageView(
        pageSnapping: true,
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
