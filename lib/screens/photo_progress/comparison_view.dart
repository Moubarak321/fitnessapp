import 'package:fitnessapp/common_widget/icon_title_next_row.dart';
import 'package:fitnessapp/common_widget/round_button.dart';
import 'package:fitnessapp/screens/photo_progress/result_view.dart';
import 'package:flutter/material.dart';

import 'package:fitnessapp/common/color_extension.dart';

class ComparisonView extends StatefulWidget {
  const ComparisonView({super.key});

  @override
  State<ComparisonView> createState() => _ComparisonViewState();
}

class _ComparisonViewState extends State<ComparisonView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tcolor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Tcolor.ligthGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/images/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Comparison",
          style: TextStyle(
              color: Tcolor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Tcolor.ligthGrey, 
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/images/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Tcolor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            IconTitleNextRow(
                icon: "assets/images/date.png",
                title: "Select Month 1",
                time: "May",
                onPressed: () {},
                color: Tcolor.ligthGrey),
            const SizedBox(
              height: 15,
            ),
            IconTitleNextRow(
                icon: "assets/images/date.png",
                title: "Select Month 2",
                time: "select Month",
                onPressed: () {},
                color: Tcolor.ligthGrey),
            const Spacer(),
            RoundButton(
                title: "Compare",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultView(
                        date1: DateTime(2023, 5, 1),
                        date2: DateTime(2023, 6, 1),
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
