import 'package:flutter/material.dart';
import 'package:servicio/screens/service_page/service_detail_view.dart';
import 'package:servicio/shared/parallax_page_view.dart';
import 'package:servicio/widget/stub_data.dart';
import 'package:servicio/widget/theme.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final List<String> hotelCategories = StubData().hotelCategories;
  final List<HotelCard> hotels = StubData().hotels;

  int checkedItem = 0;



  @override
  Widget build(BuildContext context) {
    final themeData = ServicioThemeProvider.get();


    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top),
              SizedBox(height: 20),
              Container(
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 10.0),
                          color: Colors.white,
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "What do you need?",
                            hintStyle:
                                TextStyle(color: Colors.indigo, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    Text("Hello UserName,", style: themeData.textTheme.display2),
                    const SizedBox(height: 4),
                    Text("Find your perfect Service",
                        style: TextStyle(
                            fontSize: 24, color: themeData.primaryColorLight)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Service and Repair Centers",
                            style: TextStyle(
                                fontSize: 23,
                                color: themeData.primaryColorLight,
                                fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () {},
                          child: Text("View all",
                              style: TextStyle(fontSize: 12, color: themeData.accentColor, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                height: 32,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          checkedItem = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: double.infinity,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 20 : 5, right: 5),
                        decoration: BoxDecoration(
                          color: index == checkedItem
                              ? themeData.accentColor
                              : themeData.unselectedWidgetColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              hotelCategories[index],
                              style: TextStyle(
                                  color: index == checkedItem
                                      ? Colors.white
                                      : themeData.accentColor),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: hotelCategories.length,
                ),
              ),
              const SizedBox(height: 10),
              ParallaxPageView(
                viewportFraction: 0.7,
                height: 300,
                data: hotels,
                onCardTap: (hotel) {
                  Navigator.of(context).push(
                    PageRouteBuilder<void>(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget child) {
                              return
                              ServiceDetailPage(
                                heroTag: "${hotel.cardTitle()}",
                                imageAsset: hotel.cardImageAsset(),
                              );
                            });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
