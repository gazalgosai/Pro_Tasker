import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import '../home_page.dart';
import '../main_home_page.dart';
import '../theme.dart';


class Read_Page extends StatefulWidget {
  const Read_Page({Key? key}) : super(key: key);

  @override
  State<Read_Page> createState() => _Read_PageState();
}

class _Read_PageState extends State<Read_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            first_row(),
            SizedBox(height: 15,),
            second_row(),
            SizedBox(height: 15,),
            third_row(),
          ],
        ),
      ),
    ),
    );
  }
  first_row() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              _launchWebsite(context, 'https://medium.com/search?q=Task+management+');
            },
            child: Container(
                width: 160,
                height: 165,

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(

                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/blog.webp"),
                          height: 135,width: 130,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,)
                    ),
                    Align(alignment: Alignment.bottomCenter,
                        child: Text("BLOGS",
                            style: titleStyle.copyWith(color: Colors.black))),
                  ],
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
                     _launchWebsite(context,'https://www.brightpod.com/boost/6-incredible-ted-talks-about-time-management' );
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/video.webp"),
                            height: 130,width: 130,)),
                    Align(alignment: Alignment.bottomCenter,
                      child: Text("VIDEOS",
                          style: titleStyle.copyWith(color: Colors.black)),),
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
  second_row() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
               _launchWebsite(context, 'https://www.forbes.com/advisor/business/software/best-task-management-software/');
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/www.webp"),
                          height: 130,width: 130,
                          alignment: Alignment.center, fit: BoxFit.cover,)),
                    Align(alignment: Alignment.bottomCenter,
                        child: Text("TOOLS",
                            style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
               _launchWebsite(context, 'https://hbr.org/topic/subject/time-management');
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/artical.webp"),
                          height: 135,width: 130,
                          alignment: Alignment.center, fit: BoxFit.cover,)),
                    Align(alignment: Alignment.bottomCenter,
                        child: Text("ARTICLES",
                            style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
  third_row() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
               _launchWebsite(context, 'https://friday.app/p/task-management-tips');
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/did.webp"),
                          height: 135,width: 130,
                          alignment: Alignment.center, fit: BoxFit.cover,)),
                    Align(alignment: Alignment.bottomCenter,
                        child: Text("FACTS",
                            style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
                _launchWebsite(context, 'https://www.acuitytraining.co.uk/news-tips/time-management-statistics-2022-research/');
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,
                      strokeAlign: StrokeAlign.outside,
                      color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Align(alignment: Alignment.topCenter,
                        child: Image(image: AssetImage("images/idea.webp"),
                          height: 135,width: 130,
                          alignment: Alignment.center, fit: BoxFit.cover,)),
                    Align(alignment: Alignment.bottomCenter,
                        child: Text("NEWS",
                            style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
  _appbar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      title: Text("Reading Page",
        style: subHeadingStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black),
      ),
      elevation: 0,
      leading: InkWell(
        onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));},
        child: Icon(
          Icons.arrow_back,
          size: 28,
          color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
    );
  }
  void _launchWebsite(BuildContext context, String url) async {
    try {
      await launch(
        url,customTabsOption: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          // animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // Add package names of other browsers here if needed.
          ],
        ),
      );
    } catch (e) {
      // Handle exceptions if the website cannot be opened.
      print('Error launching website: $e');
    }
  }

}
