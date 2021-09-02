import 'package:flutter/material.dart';

import 'dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style:TextStyle(color: Colors.greenAccent),
      ),
    );
  }

  Widget buildContainer(Widget child,String s) {
    return Row(

      children:[
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: RotatedBox(
            quarterTurns: -1,
            child: Text(s,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ),

        Expanded(
          child: Container(


          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: 150,
          width: 300,
          child: child,
      ),
        ),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left:10,right: 10,bottom: 10),
              height: 200,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(

                        title: Center(
                          child: Text(
                            selectedMeal.ingredients[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Divider(color: Colors.white,)
                    ],
                  ),
                  itemCount: selectedMeal.ingredients.length,
                ),
                'Ingredients'
            ),

            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('# ${(index + 1)}',style: TextStyle(color: Colors.black),),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Divider(color: Colors.white,)
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
              'Steps'
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.pinkAccent,
        child: Icon(

          isFavorite(mealId) ? Icons.star : Icons.star_border,

        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
