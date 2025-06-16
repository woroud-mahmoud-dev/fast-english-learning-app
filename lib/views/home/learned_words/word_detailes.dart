import 'package:fast/cubit/training/Learned_word_cubite.dart';
import 'package:fast/cubit/training/learned_words_states.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/my_services.dart';

class WordDetails extends StatefulWidget {
  final TabController tabController;

  WordDetails({Key? key, required this.tabController}) : super(key: key);

  @override
  State<WordDetails> createState() => _WordDetailsState();
}

class _WordDetailsState extends State<WordDetails> {
  MyService myService = MyService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (BuildContext context) => LearnedWordsCubit(),
        child: BlocConsumer<LearnedWordsCubit, LearnedWordsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return  SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(children: [
                      //const SelectLanWidget(),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
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
                                    widget.tabController.animateTo(6);
                                  },
                                  icon: const Icon(Icons.arrow_forward)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CacheHelper.getData(key: 'lanCode') ==
                                                  'US-UK'
                                              ? Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 7, left: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Spacer(),
                                                      InkWell(
                                                        onTap: () async {
                                                          LearnedWordsCubit.get(context).speckUK(
                                                            myService.getCorrectWord ?? '',
                                                          );
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/UK.svg",
                                                              width: 15,
                                                              height: 10,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(height: 2),
                                                            SvgPicture.asset(
                                                              'assets/icons/person_icon.svg',
                                                              fit: BoxFit.fill,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      InkWell(
                                                        onTap: () async {
                                                          LearnedWordsCubit.get(
                                                                  context)
                                                              .speakUS(
                                                            myService.getCorrectWord ?? '',
                                                          );
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/US.svg",
                                                              width: 15,
                                                              height: 10,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            const SizedBox(height: 2),
                                                            SvgPicture.asset(
                                                              'assets/icons/person_icon.svg',
                                                              fit: BoxFit.fill,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                              height: 15,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(left: 10),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (CacheHelper.getData(
                                                              key: 'lanCode') ==
                                                          'en-UK') {
                                                        LearnedWordsCubit.get(
                                                                context)
                                                            .speckUK(
                                                          myService
                                                                  .getCorrectWord ??
                                                              '',
                                                        );
                                                      } else if (CacheHelper
                                                              .getData(
                                                                  key:
                                                                      'lanCode') ==
                                                          'en-US') {
                                                        LearnedWordsCubit.get(
                                                                context)
                                                            .speakUS(
                                                          myService
                                                                  .getCorrectWord ??
                                                              '',
                                                        );
                                                      }

                                                      LearnedWordsCubit.get(
                                                              context)
                                                          .speakOne(myService
                                                                  .getCorrectWord ??
                                                              '');
                                                    },
                                                    child: SvgPicture.asset(
                                                        'assets/icons/person_icon.svg',
                                                        fit: BoxFit.fill,
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.07,
                                                        height: 25),
                                                  ),
                                                ),
                                          const Spacer(),
                                          const Spacer(),
                                          Text(
                                            myService.getCorrectWord ?? '',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: DarkBlue),
                                          ),
                                          const Spacer(),
                                          Container(
                                              width: 50,
                                              height: 48,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                  ),
                                                  color: Colors.green),
                                              child: Center(
                                                  child: Text(
                                                '${index}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: DarkBlue),
                                              ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.green,
                                        height: 0,
                                        endIndent: 7,
                                        indent: 7,
                                        thickness: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'شرح عن أصل الكلمة',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: DarkBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      ' تفاصيل عن الترجمة',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: DarkBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/translate.svg',
                                          fit: BoxFit.fill,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.06,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'ترجمة الكلمة',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
