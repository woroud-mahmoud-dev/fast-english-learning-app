import 'package:fast/cubit/story/all_stories_tab_cubit.dart';
import 'package:fast/model/my_services.dart';
import 'package:fast/model/stories_by_subject.dart';
import 'package:fast/model/story.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/auth/login_screen.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StoriesTap extends StatefulWidget {
  final TabController? tabController;

  const StoriesTap({Key? key, this.tabController}) : super(key: key);

  @override
  State<StoriesTap> createState() => _StoriesTapState();
}

class _StoriesTapState extends State<StoriesTap> {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AllStoriesTabCubit()..getAllStories(),
      child: BlocConsumer<AllStoriesTabCubit, AllStoriesTabState>(
        listener: (context, state) {
          if(state is UserNotFound){
            CacheHelper.clearData();
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
                  return const Login();
                }), (route) => false);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          List<StoriesBySubject> storiesBySubject =AllStoriesTabCubit.get(context).storiesBySubject;

          if(state is AllStoriesLoading){
            return Center(
              child:CircularProgressIndicator(color: Orange,),
            );
          }

          if(state is AllStoriesError) {
            return Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'عذراً حدث خطأ ما',
                      style: TextStyle(
                          color:  Colors.black,fontSize: 18, fontFamily: 'Tajawal'
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        AllStoriesTabCubit.get(context).getAllStories();
                      },
                      child: Text(
                        'إعادة محاولة',
                        style: TextStyle(
                            color:  Orange,fontSize: 18, fontFamily: 'Tajawal', fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  ],
                )
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تعلم عبر القصص',
                      style: TextStyle(
                          fontSize: 14,
                          color: DarkBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          AllStoriesTabCubit.get(context).getAllStories();
                          //widget.tabController!.animateTo(8);
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: storiesBySubject.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    itemBuilder: (context, index) {
                      print(storiesBySubject[index].stories);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: InkWell(
                                  onTap: (){
                                    AllStoriesTabCubit.get(context).selectStorySubject(index);
                                  },
                                  child: Stories(stories: storiesBySubject[index],)
                              ),
                            ),
                            Visibility(
                              visible:storiesBySubject[index].showStories ,
                              child: GridView.count(
                                crossAxisCount: 2,
                                controller: ScrollController(keepScrollOffset: false),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: storiesBySubject[index].stories.map<Widget>((value) {
                                  return Container(
                                    height: 150.0,
                                    margin: const EdgeInsets.all(1.0),
                                    child: StoryWidget(
                                      image: value.image,
                                      title: value.title,
                                      onTapped: (){
                                        MyService myService = MyService();
                                        myService.setSelectedStoriesBySubject = storiesBySubject[index];
                                        myService.setSelectedStory = value;
                                        widget.tabController!.animateTo(10);
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
