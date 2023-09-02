import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/widgets/widget_home_categories.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousel(context),
            const WidgetCategories(),
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 200.0,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.asset("assets/images/istockphoto-521812367-170667a.webp"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-2449665.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-2733918.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-5745903.jpeg"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.asset("assets/images/pexels-photo-6152382.jpeg"),
          ),
        ],
      ),
    );
  }
}
