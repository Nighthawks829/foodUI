import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_ui/burgerpage.dart';
import 'package:food_ui/foodtabs.dart';
import 'package:food_ui/main.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6.0,
                        spreadRadius: 4.0,
                        offset: const Offset(0.0, 3.0),
                      )
                    ],
                    color: const Color(0xFFC6E7FE),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/tuxedo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'SEARCH FOR',
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w800,
                fontSize: 27.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'RECIPES',
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w800,
                fontSize: 27.0,
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              padding: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.notoSans(fontSize: 14.0),
                  border: InputBorder.none,
                  fillColor: Colors.grey.withOpacity(0.5),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Recommended',
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildListItem(
                  'Hamburg',
                  'assets/burger.png',
                  '21',
                  const Color(0xFFFFE9C6),
                  const Color(0xFFDA9551),
                ),
                _buildListItem(
                  'Chips',
                  'assets/fries.png',
                  '15',
                  const Color(0xFFC2E3FE),
                  const Color(0xFF6A8CAA),
                ),
                _buildListItem(
                  'Donuts',
                  'assets/doughnut.png',
                  '15',
                  const Color(0xFFD7FADA),
                  const Color(0xFF56CC7E),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.5),
              labelStyle: GoogleFonts.notoSans(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.notoSans(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(
                  child: Text('FEATUARED'),
                ),
                Tab(
                  child: Text('COMBO'),
                ),
                Tab(
                  child: Text('FAVORITES'),
                ),
                Tab(
                  child: Text(
                    'RECOMMENDED',
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 450.0,
            child: TabBarView(
              controller: tabController,
              children: const [
                FoodTab(),
                FoodTab(),
                FoodTab(),
                FoodTab(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildListItem(String foodName, String imgPath, String price, Color bgColor,
      Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BurgerPage(
                heroTag: foodName,
                foodName: foodName,
                pricePerItem: price,
                imgPath: imgPath,
              ),
            ),
          );
        },
        child: Container(
          height: 175.0,
          width: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: bgColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: foodName,
                child: Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      imgPath,
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              Text(
                foodName,
                style: GoogleFonts.notoSans(
                  fontSize: 17.0,
                  color: textColor,
                ),
              ),
              Text(
                '\$$price',
                style: GoogleFonts.notoSans(
                  fontSize: 17.0,
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
