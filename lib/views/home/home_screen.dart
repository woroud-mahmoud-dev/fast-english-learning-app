import 'package:fast/api/notification_api_plus.dart';
import 'package:fast/local_storage/sql_database.dart';
import 'package:fast/views/home/learned_words/learnd_words_screen.dart';
import 'package:fast/views/home/learned_words/view_words.dart';
import 'package:fast/views/home/stories/play_story_tap.dart';
import 'package:fast/views/home/stories/stories_tap.dart';
import 'package:fast/views/home/taps/tarining_tap.dart';
import 'package:fast/views/home/taps/profile_tap.dart';
import 'package:fast/views/home/taps/home_tap.dart';
import 'package:fast/views/home/taps/wallet_tap.dart';
import 'package:fast/views/translation/translation_screen.dart';
import 'package:fast/views/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utlis/constant.dart';

import '../../cubit/app_bar_cubit.dart';
import '../../cubit/home_tap_cubit.dart';
import '../../cubit/profile_cubite.dart';
import '../../cubit/training/training_cubit.dart';
import '../../cubit/wallet_cubit.dart';
import '../../local_storage/word_operation.dart';
import '../../network/local/chach_helper.dart';
import '../widgets/linerIndicator.dart';
import 'learned_words/word_detailes.dart';

class Home extends StatefulWidget {
  final Map<String, int> homeData;
  const Home({Key? key, required this.homeData}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late SqlDb sqlDb;
  late int _currentIndexBottomNavigationBarItem;
  late TabController tabController;
  late bool floatingActionButtonVisible;
  late AppBarCubit appBarCubit;
  late IndicatorController indicatorController1;
  late IndicatorController indicatorController2;
  late TrainingCubit trainingCubit;
  late HomeTapCubit homeTabCubit;
  late WalletCubit walletCubit;
  late Map<String, int> homeData;

  @override
  void initState() {
    sqlDb = SqlDb();
    appBarCubit = AppBarCubit();
    indicatorController1 = IndicatorController();
    indicatorController2 = IndicatorController();
    trainingCubit = TrainingCubit(updateBar: afterBuild);
    homeTabCubit = HomeTapCubit();
    walletCubit = WalletCubit();
    floatingActionButtonVisible = true;
    _currentIndexBottomNavigationBarItem = 3;

    homeData = widget.homeData;
    tabController = TabController(
      length: 11,
      vsync: this,
      initialIndex: 3,
      animationDuration: const Duration(milliseconds: 500),
    );

    tabController.addListener(handleTabSelection);
    SchedulerBinding.instance.addPostFrameCallback((_) => afterBuild());

    super.initState();
  }

  afterBuild() {
    WordOperations operations = WordOperations();
    operations.countCorrectWord().then((value) {
      setState(() {
        homeData = value;
        double x = value['dalyCorrectWords']! *
            100 /
            (CacheHelper.getData(key: 'wordNumber'));
        indicatorController1.animatedTo(x);
        indicatorController2.animatedTo(x);
      });
    });
  }

  void handleTabSelection() {
    int tabIndex = tabController.index;
    switch (tabIndex) {
      // HomeTapCubit
      case 3:
        homeTabCubit.getSelectedSubjects();
        break;
      // HomeTapCubit
      case 2:
        walletCubit
          ..getHardWords()
          ..getMistakeWords()
          ..getPerfectWords()
          ..getStories();
        break;
      // TrainingCubit
      case 8:
        trainingCubit.update();
        break;
    }

    if (mounted) {
      setState(() {
        afterBuild();
        if (tabController.index < 4) {
          floatingActionButtonVisible = true;
          _currentIndexBottomNavigationBarItem = tabController.index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider<WalletCubit>(
            create: (context) => WalletCubit(),
          ),
          BlocProvider<HomeTapCubit>(
            create: (context) => homeTabCubit..getSelectedSubjects(),
          ),
          BlocProvider<TrainingCubit>(
            create: (context) => trainingCubit..update(),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: tabController.index != 3 ? DarkBlue : Colors.white,
            shadowColor: Colors.transparent,
            leadingWidth: 80,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: onPressedButtonFAST,
                  child: Text(
                    'FAST',
                    style: TextStyle(
                        color:
                            tabController.index != 3 ? Colors.white : DarkBlue,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
            leading: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: DropDownWidget(),
            ),
          ),
          body: Column(
            children: [
              Opacity(
                opacity: (tabController.index == 3) ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: width,
                  height: (tabController.index == 3) ? 125 : 0,
                  decoration: BoxDecoration(
                    color: DarkBlue,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: LightOrange,
                                  ),
                                  Text(
                                    'كلمة ${homeData['countCorrectWord']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                'أهلاً ${CacheHelper.getData(key: 'name')}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/images/tree2.svg',
                              height: 70,
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'معدل الإنجاز اليومي',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: width * 0.72,
                                  child: LinerIndicator(
                                    showPer: true,
                                    width: width - 100,
                                    controller: indicatorController1,
                                    colorBorder: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: (tabController.index != 3) ? 1 : 0,
                child: Container(
                  height: (tabController.index != 3) ? 90 : 0,
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: DarkBlue,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                    onTap: _starIconButtonCallback,
                                    child: SvgPicture.asset(
                                        "assets/icons/star.svg")),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  'كلمة ${homeData['countCorrectWord']}',
                                  style: TextStyle(
                                      color: Orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      LinerIndicator(
                        showPer: true,
                        width: width - 100,
                        controller: indicatorController2,
                        colorBorder: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: <Widget>[
                    ProfileTap(appBarCubit: appBarCubit),
                    StoriesTap(tabController: tabController),
                    WalletTap(
                      appBarCubit: appBarCubit,
                      tabController: tabController,
                    ),
                    HomeTap(tabController: tabController),
                    Translation(tabController: tabController),
                    LearnedWords(
                        tabController: tabController, appBarCubit: appBarCubit),
                    ViewWords(
                      tabController: tabController,
                    ),
                    WordDetails(
                      tabController: tabController,
                    ),
                    TrainingTap(
                      tabController: tabController,
                    ),
                    StoriesTap(tabController: tabController),
                    PlayStoryTap(tabController: tabController),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Visibility(
            visible: tabController.index < 4 && tabController.index > 0,
            child: FloatingActionButton(
              backgroundColor: Orange,
              onPressed: floatingActionButtonOnPressedCallback,
              child: const Center(
                child: Icon(Icons.search),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: BottomNavigationBar(
                unselectedFontSize: 11,
                selectedFontSize: 12,

                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "حسابي",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.newspaper), label: "القصص"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.description), label: "محفظتي"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "الصفحة الرئيسية"),
                ],
                onTap: onTapedBottomsNavigationBarItem,
                currentIndex: _currentIndexBottomNavigationBarItem,
                backgroundColor: DarkBlue,
                type: BottomNavigationBarType.fixed,
                // Fixed
                selectedItemColor: Colors.grey,
                unselectedItemColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTapedBottomsNavigationBarItem(int tabIndex) {
    _currentIndexBottomNavigationBarItem = tabIndex;
    tabController.animateTo(tabIndex);
  }

  void onPressedButtonFAST() {}

  void _starIconButtonCallback() {}

  void floatingActionButtonOnPressedCallback() async {
    /*WordOperations  wordOperations = WordOperations();
    wordOperations.getLatestWords();*/

    floatingActionButtonVisible = false;
    tabController.animateTo(4);
  }
}
