import 'package:fast/utlis/constant.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final Function onTapped;
  const StoryWidget({Key? key, this.image, this.title, required this.onTapped}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapped();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.09,

              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                            image: NetworkImage(
                                StoryImgUrl + image!
                            ),
                            fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: -0.2,
                      child: Container(
                        height: 11,
                        width: 18.63,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                            ),
                            color: Colors.grey[300]),
                        child: Center(
                          child: Text(
                            '6 د',
                            style: TextStyle(color: Orange, fontSize: 6),
                          ),
                        ),
                      )),
                  Positioned(
                      left: -15,
                      bottom: -15,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Card(
                          elevation: 5,
                          color: Orange,
                          shadowColor: DarkBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Icon(
                            Icons.play_arrow,
                            color: DarkBlue,
                          )),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // Text(
            //  supTitle!,
            //   style: TextStyle(color: Grey, fontSize: 10),
            // ),
            Text(
              title!,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
