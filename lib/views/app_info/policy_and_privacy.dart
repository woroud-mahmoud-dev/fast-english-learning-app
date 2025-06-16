import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/policy_and_privacy_cubit.dart';
import '../../utlis/constant.dart';


class PolicyAndPrivacy extends StatelessWidget {
 const PolicyAndPrivacy({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:  Colors.white,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:  SvgPicture.asset("assets/icons/back.svg"),
          ),
          title:  const Text('الشروط والأحكام' ,maxLines: 1,textAlign: TextAlign.center,  style: TextStyle(color: Colors.indigo,fontSize: 24 ,fontWeight: FontWeight.bold ,),),

        ),
        body: BlocProvider(
          create: (context) => PolicyAndPrivacyCubit()..getPolicyAndPrivacy(),
          child: BlocConsumer<PolicyAndPrivacyCubit, PolicyAndPrivacyState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {

              if(state is PolicyAndPrivacyLoading){
                return Container( color:Colors.white, height: height, width: width, child: const Center(child:  CircularProgressIndicator(color: Colors.orange,)));
              }


              return Container(
                color: Colors.white,

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Align(
                        alignment:Alignment.topLeft,
                        child: SingleChildScrollView(
                          child: Column(
                            children: PolicyAndPrivacyCubit.get(context).papList.map<Widget>((e) => Container(
                              child: Column(
                                children: [
                                Container(
                                  margin:const EdgeInsets.all(8),
                                  alignment: Alignment.centerRight,
                                  child: Text(PolicyAndPrivacyCubit.get(context).papList[0].title, style: TextStyle(fontSize:16 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.bold),),
                                ),
                                  Container(
                                    margin:const EdgeInsets.all(8),
                                    alignment: Alignment.centerRight,
                                    child: Text(PolicyAndPrivacyCubit.get(context).papList[0].body, style: TextStyle(fontSize:16 ,color: BlueGrey,fontFamily: 'Tajawal', fontWeight: FontWeight.normal),),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                        ) ,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
