import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../api/translation_api.dart';
import '../../utlis/constant.dart';


class Translation extends StatefulWidget {
  final TabController tabController ;
  const Translation({Key? key,required this.tabController}) : super(key: key);

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
 late List toggleButtons;
 late TextEditingController _textFieldController;
 late TextEditingController _textFieldController2;
 String? errorText;

 late StreamController streamController;
 late Stream stream;


 @override
  void initState() {
    toggleButtons = List.generate(2, (index) => (index % 2 == 1) ? true : false);
    _textFieldController = TextEditingController();
    _textFieldController2 = TextEditingController();
    streamController = StreamController();
    stream = streamController.stream;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height-206,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text("البحث عن ترجمة كلمة أو جملة",style: TextStyle(fontWeight: FontWeight.bold , fontSize: 16 ,color: DarkBlue),),
                    ),
                    //icon button back
                    GestureDetector(
                        onTap: _backIconButtonCallback,
                        child: SvgPicture.asset("assets/icons/back.svg")
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: height-262,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){onPressedToggleButton(1);},
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              height: 56,
                              width: width/3,
                              decoration: BoxDecoration(
                                  color:(toggleButtons[1])?DarkBlue :Colors.white,
                                  border: Border.all(color:DarkBlue ),

                                  borderRadius: BorderRadius.circular(16)
                              ),

                              child: Center(child: Text('قاموس اكسفورد', style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ,color:(toggleButtons[1])?Colors.white:BlueGrey ,fontFamily: 'Tajawal'),)),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){onPressedToggleButton(0);},
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              height: 56,
                              width: width/3,
                              decoration: BoxDecoration(
                                  color:(toggleButtons[0])?DarkBlue :Colors.white,
                                  border: Border.all(color:DarkBlue ),

                                  borderRadius: BorderRadius.circular(16)
                              ),

                              child: Center(child: Text('مترجم جوجل', style: TextStyle(fontSize:14 ,fontWeight: FontWeight.bold,color:(toggleButtons[0])?Colors.white:BlueGrey,fontFamily: 'Tajawal'),)),
                            ),
                          ),

                        ],
                      ) ,
                    ),
                    SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _textFieldController,
                              //maxLength: 50,
                              maxLines: 1,

                              onChanged: onChangedTextFieldCallback,
                              onTap: (){

                                errorText =null;
                                _textFieldController.selection =
                                    TextSelection.collapsed(offset: _textFieldController.text.length);
                              },
                              onSubmitted: onSubmittedTextFieldCallback,
                              style:const TextStyle(fontSize: 20),
                              decoration:  InputDecoration(
                                errorText: errorText,
                                suffix: SizedBox(
                                  height: 50,
                                  width: 30,
                                  child: Center(
                                      child: Icon(Icons.search,color: Orange,)),
                                ),

                                border: OutlineInputBorder(
                                    borderSide:const BorderSide(width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:const BorderSide(width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 16,),
                    SizedBox(
                        height: 300,
                        child: Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 0),
                          child: StreamBuilder(
                            stream: stream,
                            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return const Center(
                                  child: Text("اكتب كلمة باللغة العربية لترجمتها"),
                                );
                              }

                              if (snapshot.data == "waiting") {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              _textFieldController2.text  = snapshot.data;
                              return  Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  readOnly: true,
                                  maxLines: 20,
                                  controller: _textFieldController2,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:const BorderSide(width: 2, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:const BorderSide(width: 2, color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _backIconButtonCallback() {
    widget.tabController.animateTo(3);
  }

  void onPressedToggleButton(int index) {
    setState((){
      if(index == 1){
        toggleButtons[1] = true;
        toggleButtons[0] = false;
      }else{
        toggleButtons[0] = true;
        toggleButtons[1] = false;
      }
    });


  }

  void onSubmittedTextFieldCallback(String value)async {
    if(value.isEmpty){
      streamController.add(null);
    return ;
    }

    streamController.add("waiting");
    print("search on api to $value");
    TranslationApi.translate3(value,"ar","en").then((data){
      print(data);
      if(data["error"] != null){
        if(data["error"].toString().contains("No entry found")){
          streamController.add("لم يتم العثور على الكلمة");
        }else{
          streamController.add(data["error"]);
        }
      }else{

        if(data["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["translations"] != null){
          streamController.add(
              data["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][0]["translations"][0]["text"]);
        }else{
          streamController.add(
              data["results"][0]["word"]);

        }
      }
    });


  }

  void onChangedTextFieldCallback(String value) {
   if(value.trim().contains(" ") ){
     errorText = "يجب ادخال كلمة واحدة فقط بدون فراغات ولا رموز او ارقام";
   }else{
     errorText = null;
   }

  }
}
