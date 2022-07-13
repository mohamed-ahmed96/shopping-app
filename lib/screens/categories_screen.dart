import 'package:flutter/material.dart';
import 'package:shopping_app/models/category_model.dart';

class CategoriesScreen  extends StatelessWidget {
   CategoriesScreen ({Key? key,required this.category}) : super(key: key);

   Category category;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            ListView.separated(
              separatorBuilder:(context, index) => Container(height: 20,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  categoryItem(category.data!.data[index]),
              itemCount: category.data!.data.length,
            ),
          ],
        ),
      ),
    );
  }
  Widget categoryItem(Data data) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Image(
          image: NetworkImage(data.image!),
          width: 150,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 30,),
        Text(
          data.name!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        Spacer(),
        const Icon(Icons.arrow_forward,size: 40,)
      ],
    ),
  );

}
