import 'package:fast/cubit/about_us_cubit.dart';
import 'package:fast/views/app_info/policy_and_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../utlis/constant.dart';
import '../../utlis/launcher_url_in_platform.dart';


class AppInfo extends StatelessWidget {
 const AppInfo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:  Colors.white,
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: SvgPicture.asset("assets/icons/back.svg"),
            ),
            title: const Text(
              'من نحن',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: BlocProvider(
            create: (context) {
              AboutUsCubit cubit = AboutUsCubit();
              cubit.getData();
              return cubit ;
            },
            child: BlocConsumer<AboutUsCubit, AboutUsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is AboutUsLoading){
                  return Center(
                    child:CircularProgressIndicator(color: Orange,),
                  );
                }

                if(state is AboutUsError) {
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
                              AboutUsCubit.get(context).getData();
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

                return Container(
                  height: height,
                  width: width,
                  margin: const EdgeInsets.only(top: 32),
                  child:SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AboutUsCubit.get(context).appName.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              color: DarkBlue,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'version: ${AboutUsCubit.get(context).version}',
                          style: TextStyle(
                              fontSize: 16,
                              color: BlueGrey,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset("assets/icons/fast_icon.png",height: 100,),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: const PolicyAndPrivacy(), duration:const Duration(microseconds: 800)));
                            },
                            child: Text(AboutUsCubit.get(context).aboutUs.about, style: TextStyle(fontSize:16 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.bold),)
                        ),
                        Container(
                          margin:const EdgeInsets.symmetric(vertical: 32 , horizontal: 16),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'روابط التواصل الاجتماعي:',                        style: TextStyle(
                              fontSize: 18,
                              color: DarkBlue,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 56,
                              child: TextButton(
                                onPressed: () {
                                  launchInBrowser(Uri.parse(
                                      'https://wa.me/${AboutUsCubit.get(context).aboutUs.phone}'));
                                },
                                child: Image.asset(
                                  'assets/icons/whatsapp.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 56,
                              child: TextButton(
                                onPressed: () {
                                  launchInBrowser(Uri.parse(AboutUsCubit.get(context).aboutUs.facebook));
                                },
                                child: Image.asset(
                                    'assets/icons/facebook.png'),
                              ),
                            ),
                            SizedBox(
                              height: 56,
                              child: TextButton(
                                onPressed: () {
                                  launchInBrowser(Uri.parse(AboutUsCubit.get(context).aboutUs.instagram));
                                },
                                child: Image.asset(
                                    'assets/icons/Instagram.png'),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only( top: 8.0),
                          child: Text('powered by Step-Alpha'  ,style: TextStyle(fontFamily: 'Tajawal', fontSize: 18,color: Colors.black45), ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
      ),
    );

  }
}
