
import 'package:fast/cubit/training/training_cubit.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gridded_pageview/gridded_pageview.dart';
import 'package:fast/views/widgets/CustomlisIteam.dart';
import '../../../cubit/app_bar_cubit.dart';

class LearnedWords extends StatefulWidget {
  final TabController tabController;
  final AppBarCubit appBarCubit;

  const LearnedWords({Key? key, required this.tabController, required this.appBarCubit}) : super(key: key);

  @override
  State<LearnedWords> createState() => _LearnedWordsState();
}

class _LearnedWordsState extends State<LearnedWords> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BlocProvider(
        create: (BuildContext context) => TrainingCubit(updateBar: (){})..update(),
        child: BlocConsumer<TrainingCubit , TrainingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List<Map<String , dynamic>> subjectsAndWordCount = TrainingCubit.get(context).subjectsAndWordCount;

            if(state is TrainingLoading){
              return const Center(child: CircularProgressIndicator(color: Colors.orange,));
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'احدث الكلمات التي تعلمتها',
                          style: TextStyle(
                              fontSize: 14,
                              color: DarkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              widget.tabController.animateTo(8);
                            },
                            icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                  if(state is! TrainingLoading)
                    Expanded(
                      child: GriddedPageView(
                        indicatorPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                        controller: PageController(), //LearnedWordsCubit.get(context).pagecontroller,
                        overlapIndicator: false,
                        minChildWidth: 300,
                        showIndicator: true,
                        minChildHeight: 90,
                        pagePadding: EdgeInsets.zero,
                        children: List<Widget>.generate(subjectsAndWordCount.length,
                                (int index) {
                              return GestureDetector(
                                  onTap: () {
                                    MyService myService = MyService();
                                     myService.setSelectedSubject = subjectsAndWordCount[index];
                                    widget.tabController.animateTo(6);
                                  },
                                  child: subjectWidget(subjectAndCountOfWords: subjectsAndWordCount[index], context));
                            }),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
