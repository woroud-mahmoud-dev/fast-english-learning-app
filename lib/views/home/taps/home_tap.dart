import 'package:fast/cubit/home_tap_cubit.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/object.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/auth/login_screen.dart';
import 'package:fast/views/widgets/linerIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/error_widget.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  late IndicatorController indicatorController;
  @override
  void initState() {
    indicatorController = IndicatorController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeTapCubit , HomeTapState>(
      builder: (context, state) {

        List<SubjectModel> subjectsList = HomeTapCubit.get(context).subjectsList;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '  هيا نختار موضوع نريد ان نتعلمه ',
                  style: TextStyle(
                      color: DarkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            if (state is GetSubjectsLoadingState)
              const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.orange,))),

            if (state is GetSubjectsErrorState)  FastErrorWidget(onTapped : ()=>  HomeTapCubit.get(context).getSelectedSubjects() ),
            if (state is GetSubjectsEmptyState)
              Expanded(
                child: Center(
                  child: Text(
                    "لا يوجد مواضيع مختارة",
                    style: TextStyle(fontSize: 14, color: DarkBlue),
                  ),
                ),
              ),

            if (state is GetSubjectsSuccessState)
              Expanded(
                child: GridView.count(
                  //physics: const BouncingScrollPhysics(),
                  childAspectRatio: (1 / 1),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: List.generate(subjectsList.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            //CacheHelper.saveData(key: 'storyId', value: subjectsList[index].id);
                            subId = subjectsList[index].id;
                            //SubStoryName = subjectsList[index].ar_title;
                            widget.tabController.animateTo(8);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Orange,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl + subjectsList[index].image),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                subjectsList[index].ar_title,
                                style: TextStyle(
                                    color: DarkBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),

          ],
        );
      },
    );
  }
}


