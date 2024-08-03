import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundAddDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: SvgPicture.asset(
                    'assets/add_details_page_bg_2.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: SvgPicture.asset(
                    'assets/add_details_page_bg_1.svg',
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
      ),
    );
  }
}
