
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BannerWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*.25,
        color: Colors.cyan,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        'BOOKS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 45.0,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              FadeAnimatedText('Buy books'),
                              FadeAnimatedText('Every book is available'),
                              FadeAnimatedText('At low prices'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Neumorphic(

                    style: NeumorphicStyle(
                      color: Colors.white,
                      oppositeShadowLightSource: true,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network('https://firebasestorage.googleapis.com/v0/b/buyorsell-7527d.appspot.com/o/banner%2Ficons8-book-96.png?alt=media&token=1e089ef2-a742-494a-b5b7-ad7b9f0c03f1'),
                    ),
                  ),
                ],),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: NeumorphicButton(
                    onPressed: (){},
                    style: NeumorphicStyle(color: Colors.white),
                    child: Text('Buy Book',textAlign: TextAlign.center,),
                  )),
                  SizedBox(width: 20,),
                  Expanded(child: NeumorphicButton(
                    onPressed: (){},
                    style: NeumorphicStyle(color: Colors.white),
                    child: Text('Sell Book',textAlign: TextAlign.center,),
                  )),
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }
}