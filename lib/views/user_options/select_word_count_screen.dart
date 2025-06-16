
import 'package:fast/cubit/user_options_cubit.dart';
import 'package:fast/cubit/user_opotios_states.dart';
import 'package:fast/utlis/constant.dart';
import 'package:fast/views/user_options/select_ton_screen.dart';
import 'package:fast/views/widgets/custon_radio_button.dart';
import 'package:fast/views/widgets/functions.dart';
import 'package:fast/views/widgets/myWidgets.dart';
import 'package:fast/views/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_screen.dart';

class SelectWordCount extends StatelessWidget {
  final bool? isNotFirstTime;
  const SelectWordCount({Key? key, this.isNotFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserOptionsCubit(),
      child: BlocConsumer<UserOptionsCubit, SelectObjectStates>(
        listener: (context, state) {
          debugPrint(state.toString());

        },
        builder: (context, state) {
          List<int> list = [5, 10, 15];
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
                                'assets/images/indicator2.png',
                                fit: BoxFit.contain,
                                //   width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 35, left: 10),
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
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Text(
                          'اختر عدد الكلمات التي تريد تعلمها كل يوم',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Grey),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.width*0.1,
                        // ),
                        SizedBox(
                            height: 150,
                            child: GridView.count(
                              physics: const BouncingScrollPhysics(),
                              childAspectRatio: (1 / 1),
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 3,
                              children: List.generate(list.length, (index) {
                                return CustomRadio3(
                                  onChanged: (index) {
                                    UserOptionsCubit.get(context)
                                        .selectWordNumber(index);

                                    print(UserOptionsCubit.get(context)
                                        .word_groupvalue);
                                  },
                                  groupValue: UserOptionsCubit.get(context)
                                      .word_groupvalue,
                                  name: list[index].toString(),
                                  value: list[index],
                                );
                              }),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(
                          'أو اكتب عدد الكلمات ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Grey),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.09,
                        ),
                        SizedBox(
                          width: 213,
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 26,
                                color: Grey,
                                fontWeight: FontWeight.bold),
                            onSubmitted: (value) {
                              UserOptionsCubit.get(context)
                                  .selectWordNumber(int.parse(value));
                            },
                            onChanged: (value) {
                              UserOptionsCubit.get(context).selectWordNumber(int.parse(value));
                              print(
                                  UserOptionsCubit.get(context).word_groupvalue);
                            },

                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            textInputAction: TextInputAction.done,
                            maxLength: null,
                            maxLines: 1,

                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textAlign: TextAlign.center,

                            // controller: _controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Grey,
                          indent: 25,
                          endIndent: 25,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.22,
                        ),
                        Text(
                          'تستطيع تعديل عدد الكلمات في وقت لاحق',
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
                            if (state is SelectWordNumberSuccessState) {
                              if(isNotFirstTime!=null && isNotFirstTime!) {
                                goNext(context, const Loading());
                              }else{
                                goNext(context, SelectTon());
                              }
                            } else {
                              showToast(text: 'يجب تحديد عدد الكلمات', color: Colors.amber);
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
