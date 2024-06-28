import 'package:flutter/material.dart';
import 'package:school_daashboard/core/config/extensions/context_extensions.dart';
import 'package:school_daashboard/core/resources/dimension_manager.dart';
import 'package:school_daashboard/features/home/data/models/home_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final list = [
    HomeItem(title: 'Classes', image: 'assets/classes.png'),
    HomeItem(title: 'Teachers', image: 'assets/teachers.png'),
    HomeItem(title: 'Students', image: 'assets/students.png'),
    HomeItem(title: 'Statistics', image: 'assets/statistics.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: context.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(AppRaduis.r15),
                  boxShadow: [
                    BoxShadow(
                        color: context.primaryColor,
                        blurRadius: 3,
                        offset: const Offset(0, 2))
                  ]),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppRaduis.r15)),
                          gradient: const LinearGradient(colors: [
                            Color(0xff2AD4FF),
                            Color(0xff8080FF),
                          ])),
                      child: Image.asset(list[index].image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      list[index].title,
                      style: context.textTheme.titleLarge,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
