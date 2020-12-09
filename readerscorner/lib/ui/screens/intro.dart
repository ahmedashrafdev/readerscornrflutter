import 'package:flutter/material.dart';
import 'package:readerscorner/ui/screens/intro_auth.dart';
import 'package:readerscorner/ui/widgets/text.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      height: isActive ? 12.0 : 10.0,
      width: isActive ? 12.0 : 10.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isActive
            ? BorderRadius.all(Radius.circular(0))
            : BorderRadius.all(Radius.circular(120)),
      ),
    );
  }
  Widget _getStarted(){
    return AnimatedSize(
          curve: Curves.fastOutSlowIn,
          vsync: this,
          duration: new Duration(seconds: 1),
          child: Container(
            height: _currentPage == _numPages - 1 ? 50.0 : 0,
            width: double.infinity,
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/introAuth'),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Center(
                  child: Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.transparent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
  Widget _buildPage(String message, String image) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 10.0),
            appText(
                text: 'READERSCORNER',
                isBold: true,
                color: Colors.white,
                fontSize: 22.0),
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 100.0, top: 12.0),
              height: 2.5,
              color: Colors.white,
            ),
            SizedBox(height: 15.0),
            appText(
              text: message,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPages() {
    List<Widget> list = [];
    var data = [
      {
        "msg": "A book is a dream that toy hold in your hand",
        'image': 'images/1.png'
      },
      {
        "msg":
            "If you only rad the books  that everyone else is reading , you can only think what everyone else is thinking",
        'image': 'images/2.png'
      },
      {
        "msg": "A book is a dream that toy hold in your hand",
        'image': 'images/3.png'
      },
    ];
    for (int i = 0; i < data.length; i++) {
      list.add(_buildPage(data[i]['msg'], data[i]['image']));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.transparent,
          // padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: _buildPages(),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: FlatButton(
                  onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => IntroAuthScreen()
            ),
          ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildPageIndicator(),
                ),
              ),
              Container(alignment: Alignment.bottomCenter,child:_getStarted())
            ],
          ),
        ),
        // bottomSheet: _getStarted()
        );
  }
}
