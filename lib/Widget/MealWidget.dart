import 'package:app_resep_makanan/BloC/GetMeal.dart';
import 'package:app_resep_makanan/Model/Meal.dart';
import 'package:app_resep_makanan/Model/MealResponse.dart';
import 'package:app_resep_makanan/Widget/Detail.dart';
import 'package:flutter/material.dart';


class MealWidget extends StatefulWidget {
  @override
  _MealWidgetState createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  @override
  void initState() {
    super.initState();
    mealBloc..getListCategoryMeal();
  }

  Route _open(Meal meal,int index) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => new Detail(meal:meal,index:index),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.easeInExpo;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }

    );
  }

  _openDetail(context, meal) {
    final route = MaterialPageRoute(
      builder: (context) => Detail(meal:meal),
    );
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10,),
          child: Text(
            "Meal Category".toUpperCase(),
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        StreamBuilder<MealResponse>(
            stream: mealBloc.subject.stream,
            builder: (context, AsyncSnapshot<MealResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildMealWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            })
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  Widget _buildMealWidget(MealResponse data) {
    List<Meal> meal = data.meal;
    if (meal.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Meal",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return SingleChildScrollView(
        child: Container(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            shrinkWrap: true,
            itemCount: meal.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 0.0, bottom: 10.0, right: 5.0, left: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_open(meal[index],index));
                      print('openpage');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        meal[index].strCategoryThumb == null
                            ? Container(
                          decoration: new BoxDecoration(
                            color: Colors.cyan,
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: 60.0,
                              )
                            ],
                          ),
                        )
                            :
                        SizedBox(
                          height: 10.0,
                        ),
                        Hero(
                          tag: "avatar-$index",
                          child: Container(
                              height: 100.0,
                              decoration: new BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(meal[index].strCategoryThumb)),
                              )),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: Expanded(
                            child: Center(
                              child: Text(
                                meal[index].strCategory,
                                maxLines: 2,
                                style: TextStyle(
                                    height: 1.4,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}