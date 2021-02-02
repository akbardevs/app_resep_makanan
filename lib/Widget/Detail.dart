import 'package:app_resep_makanan/Model/Meal.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Meal meal;
  int index;
  Detail({Key key, this.meal,this.index}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Detail"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Card(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 10.0, right: 5.0, left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Hero(
                    tag: "avatar-${widget.index}",
                    child: Container(
                        height: 200.0,
                        decoration: new BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(widget.meal.strCategoryThumb)),
                        )),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          widget.meal.strCategory,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.meal.strCategoryDescription,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

}
