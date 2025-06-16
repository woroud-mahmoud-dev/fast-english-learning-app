
import 'package:fast/cubit/user_options_cubit.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/user_options/select_time_screen.dart';
import 'package:fast/views/widgets/custon_radio_button.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_screen.dart';

class SelectTon extends StatelessWidget {
  final bool? isNotFirstTime;
  const SelectTon({Key? key, this.isNotFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserOptionsCubit(),
      child: BlocConsumer<UserOptionsCubit, SelectObjectStates>(
        listener: (context, state) {
          debugPrint(state.toString());

        },
        builder: (context, state) {
          List<Map<String, dynamic>> list = [
            {
              'id': 1,
              'image': 'assets/icons/falg1.svg',
              'name': 'الاثنين معاً',
            },
            {'id': 2, 'image': 'assets/icons/flag2.svg', 'name': 'البريطانية'},
            {'id': 3, 'image': 'assets/icons/falg3.svg', 'name': 'الأمريكية'},
          ];
          return WillPopScope(
            onWillPop: () async {
              showToast(text: 'عذرا يجب عليك إكمال هذه الخطوة قبل الخروج من التطبيق', color: Colors.red);
              return false;
            },
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/backgroung1.png',
                        ),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/images/indicator3.png',
                                fit: BoxFit.contain,
                                //   width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 30, left: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/arrow_back_icon.svg',
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width * 0.08),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.07,
                        ),
                        Text(
                          'ماهي اللهجة التي تفضلها ؟',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Grey),
                        ),

                        SizedBox(
                            height: 150,
                            child: GridView.count(
                              physics: const BouncingScrollPhysics(),
                              childAspectRatio: (1 / 1),
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 3,
                              children: List.generate(list.length, (index) {
                                return CustomRadio4(
                                  image: list[index]['image'],
                                  onChanged: (index) {
                                    UserOptionsCubit.get(context)
                                        .selectTon(index);

                                    print(UserOptionsCubit.get(context)
                                        .ton_groupvalue);
                                  },
                                  groupValue: UserOptionsCubit.get(context)
                                      .ton_groupvalue,
                                  name: list[index]['name'],
                                  value: list[index]['id'],
                                );
                              }),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.5,
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.25,
                        ),
                        Text(
                          'تستطيع التعديل  في وقت لاحق',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Grey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),

                        GestureDetector(
                          onTap: () {
                            if (state is SelectTonSuccessState) {

                              UserOptionsCubit.get(context).saveAcentINSherd(
                                  UserOptionsCubit.get(context).ton_groupvalue!);
                              if(isNotFirstTime!=null && isNotFirstTime!) {
                                goNext(context, const Loading());
                              }else{
                                goNext(context, const SelectTime());
                              }
                            } else {
                              showToast(text: 'يجب اختيار لهجة ', color: Colors.amber);
                            }
                          },
                          child: customButton2('استمرار', Orange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
