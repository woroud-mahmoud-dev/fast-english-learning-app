import 'package:fast/local_storage/subject_operation.dart';
import 'package:fast/local_storage/word_operation.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/word.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/widgets/CustomlisIteam.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ViewWords extends StatefulWidget {
  final TabController tabController;

  const ViewWords({Key? key, required this.tabController}) : super(key: key);

  @override
  State<ViewWords> createState() => _ViewWordsState();
}

class _ViewWordsState extends State<ViewWords> {
  MyService myService = MyService();
  late Future<List<Word>> subjectWords;
  bool isLoadingSubjectWords = false;
  SubjectOperations operations = SubjectOperations();
  WordOperations wordOperations = WordOperations();
  var formKey = GlobalKey<FormState>();

  Future<List<Word>> getSubjectWords(int index) async {
    List<Word> response =
        await wordOperations.getCorrectWordsBySubjectId(index);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'احدث الكلمات التي تعلمتها',
                        style: TextStyle(
                            fontSize: 14,
                            color: DarkBlue,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                        onPressed: () {
                          widget.tabController.animateTo(5);
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
                FutureBuilder<List<Word>>(
                    future: getSubjectWords(
                        myService.getSelectedSubject['subject'].id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Word>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height * 0.56,
                              decoration: BoxDecoration(
                                  color: LightBlue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                //   mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 65,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Container(
                                            height: 45,
                                            width: 45,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: CircularPercentIndicator(
                                              radius: 22.1,
                                              lineWidth: 1.3,
                                              percent: (myService
                                                          .getSelectedSubject[
                                                      'countCorrect'] /
                                                  myService.getSelectedSubject[
                                                      'numberOfWords']),
                                              center: Text(
                                                '${(double.parse((myService.getSelectedSubject['countCorrect'] * 100 / myService.getSelectedSubject['numberOfWords']).toString()).isNaN) ? 0.0 : (myService.getSelectedSubject['countCorrect'] * 100 / myService.getSelectedSubject['numberOfWords']).toInt()}%',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: DarkBlue,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              progressColor: DarkBlue,
                                              backgroundColor: Colors.white54,
                                            ),
                                          ),
                                          const Spacer(),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                myService
                                                    .getSelectedSubject[
                                                        'subject']
                                                    .ar_title,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: DarkBlue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${myService.getSelectedSubject['numberOfWords']}/${myService.getSelectedSubject['countCorrect']} كلمة',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: DarkBlue,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: DarkBlue,
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: ListView.builder(
                                      key: formKey,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(10),
                                      itemCount: snapshot.data!.length < 5
                                          ? snapshot.data!.length
                                          : 5,
                                      itemBuilder: (context, int i) {
                                        return buildListIteam(
                                          context,
                                          word: snapshot.data![i],
                                          index: i,
                                          tap: () {
                                            //enWord = SubjectWords[i].correct_word;
                                            myService.setCorrectWord =
                                                snapshot.data![i].correct_word;
                                            widget.tabController.animateTo(7);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            showAllWords(
                              tabController: widget.tabController,
                              myList: snapshot.data!,
                            ),
                          ],
                        );
                      } else {
                        return const Text('loading ...');
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
