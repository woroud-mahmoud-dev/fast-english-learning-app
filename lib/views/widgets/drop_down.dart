import 'package:fast/cubit/drop_down_cubit.dart';
import 'package:fast/cubit/drop_down_states.dart';
import 'package:fast/network/local/chach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DropDownCubit(),
      child: BlocConsumer<DropDownCubit,DropDownStates>(
        listener: (context,state){},
        builder:(context,state){
          return  Container(
            alignment: Alignment.topLeft,
            // height: 100,
            child: DropdownButton(
              elevation: 0,
              items: [
                DropdownMenuItem(
                  value: "en-UK",
                  child: SvgPicture.asset("assets/icons/UK.svg"),
                ),
                DropdownMenuItem(
                  value: "en-US",
                  child: SvgPicture.asset("assets/icons/US.svg"),
                ),
                DropdownMenuItem(
                  value: "US-UK",
                  child: SvgPicture.asset("assets/icons/US-UK.svg"),
                ),
              ],
              value: DropDownCubit.get(context).dropDownLanguageValue,
              onChanged: DropDownCubit.get(context).dropDownLanguageCallBack,
            ),
          );

      },
      ),
    );
  }
}
