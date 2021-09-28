import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/shared/components/components.dart';


class SearchScreen extends StatelessWidget
{
  var controllerSearch=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller:controllerSearch ,
                  keyboardType: TextInputType.text,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: ( value){
                    if(value!.isEmpty)
                    {
                      return('title must not be empty');
                    }
                  },

                  decoration: InputDecoration(
                    labelText: 'search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),

                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: list.length>0,
                  builder: (context)=> ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index)=> buildArticleItem(list[index],context,),
                    separatorBuilder: (context, index)=>myDivider(),
                    itemCount: list.length,
                  ),
                  fallback: (context)=> Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),

        );
      },

    );
  }
}
