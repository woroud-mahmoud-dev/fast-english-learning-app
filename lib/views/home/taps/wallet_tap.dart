import 'package:fast/cubit/wallet_cubit.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/wallet_custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/app_bar_cubit.dart';

class WalletTap extends StatelessWidget {
  final AppBarCubit appBarCubit;
  final TabController tabController;

  WalletTap({Key? key,required this.appBarCubit, required this.tabController}) : super(key: key);
  final WordOperations wordOperations = WordOperations();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => WalletCubit()..getHardWords()..getMistakeWords()..getPerfectWords()..getStories(),
      child: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          debugPrint(state.toString());
        },
        builder: (context, state) {

          return Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'محفظتي',
                    style: TextStyle(
                        fontSize: 14,
                        color: DarkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TapNameWidget(
                    onPressed: () {
                      WalletCubit.get(context).onPress(0);
                    },
                    height: height,
                    width: width,
                    name: 'القصص',
                    borderColor: DarkBlue,
                    backGroundColor: WalletCubit.get(context).showStories
                        ? DarkBlue
                        : Colors.white,
                    textColor: !WalletCubit.get(context).showStories
                        ? DarkBlue
                        : Colors.white,
                  ),
                  TapNameWidget(
                      textColor: !WalletCubit.get(context).showWords
                          ? DarkBlue
                          : Colors.white,
                      height: height,
                      width: width,
                      name: 'الكلمات',
                      borderColor: DarkBlue,
                      backGroundColor: WalletCubit.get(context).showWords ||
                              state is ChangeTypeWordsState
                          ? DarkBlue
                          : Colors.white,
                      onPressed: () {
                        WalletCubit.get(context).onPress(1);
                      }),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              WalletCubit.get(context).showStories
                  ?  SavedStoriesWidget(
                tabController: tabController,
                allStories: WalletCubit.get(context).storiesList,
              )
                  : Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WordTapNameWidget(
                                onPressed: () {
                                  WalletCubit.get(context).onPressWordsType(2);
                                },
                                height: height,
                                width: width,
                                name: 'أخطائي السابقة',
                                backGroundColor: WalletCubit.get(context)
                                        .showPreviousMistakes
                                    ? Colors.red
                                    : Colors.white,
                                textColor: !WalletCubit.get(context)
                                        .showPreviousMistakes
                                    ? Colors.red
                                    : Colors.white,
                                numberOfWords:    WalletCubit.get(context).mistakesWordsList.length,
                              ),
                              WordTapNameWidget(
                                textColor:
                                    !WalletCubit.get(context).showPerfectWords
                                        ? Colors.green
                                        : Colors.white,
                                height: height,
                                width: width,
                                name: 'الكلمات المتقنة',
                                backGroundColor:
                                    WalletCubit.get(context).showPerfectWords
                                        ? Colors.green
                                        : Colors.white,
                                onPressed: () {
                                  WalletCubit.get(context).onPressWordsType(1);
                                },
                                numberOfWords:   WalletCubit.get(context).perfectWordsList.length,
                              ),
                              WordTapNameWidget(
                                onPressed: () {
                                  WalletCubit.get(context).onPressWordsType(0);
                                },
                                height: height,
                                width: width,
                                name: 'الكلمات الصعبة',
                                backGroundColor:
                                    WalletCubit.get(context).showHardWords
                                        ? Orange
                                        : Colors.white,
                                textColor:
                                    !WalletCubit.get(context).showHardWords
                                        ? Orange
                                        : Colors.white,
                                numberOfWords:    WalletCubit.get(context).hardWordsList.length,
                              ),
                            ],
                          ),
                         Expanded(
                                  child: ListWidget(
                                    isHard:WalletCubit.get(context).showHardWords?true:false ,
                                  wordsList: WalletCubit.get(context).showHardWords ?
                                  WalletCubit.get(context).hardWordsList :
                                  WalletCubit.get(context).showPreviousMistakes ?
                                  WalletCubit.get(context).mistakesWordsList :
                                  WalletCubit.get(context).perfectWordsList,
                                  wordOperations: wordOperations,
                                  backGroundColor: WalletCubit.get(context).showPreviousMistakes ?
                                  Colors.red:
                                  WalletCubit.get(context).showHardWords ? Orange : Colors.green,
                                ),),
                              // :!getAllSuccess? const Center(child: Text('loading ')): GestureDetector(
                              //   onTap: (){
                              //     WalletCubit.get(context).addToWallet();
                              //   },
                              //   child: const Center(child: Text('refresh '))),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
