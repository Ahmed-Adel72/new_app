import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit.dart';
import 'package:news_app/layout/news_app/states.dart';
import 'package:news_app/shared/components/components.dart';


class ScienceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){},
      builder: (context, state){
        var list=NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length>0,
          builder: (context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index)=> buildArticleItem(list[index],context),
            separatorBuilder: (context, index)=> myDivider(),
            itemCount: 20,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
