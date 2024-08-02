import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: SvgPicture.asset(
                  'assets/z3klenjs3jlzcqv7ry.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
    
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: SvgPicture.asset(
                  'assets/und170d88alzcwdcbs.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),

        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: SvgPicture.asset(
              'assets/5wfkk60lmqdlzcwhaei.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),

      ],
    );
  }
}
