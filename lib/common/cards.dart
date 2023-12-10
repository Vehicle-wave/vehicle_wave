import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class HorizontalCarousel extends StatefulWidget {
  @override
  _VerticalCarouselState createState() => _VerticalCarouselState();
}

class _VerticalCarouselState extends State<HorizontalCarousel> {
  List<Widget> _cards = [
    Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),

              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          color: HexColor('#FEAAAA'),
          image: DecorationImage(
              image: AssetImage('assets/doorshipment.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover)),
      height: 200,
      width: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Door-to-Door Shipment',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              ReadMoreText(
                'At Vehicle Wave, we offer convenient and reliable door-to-door shipment services for all your transport needs. From pickup at your the origin address to delivery right to your door, we make the shipping process seamless and hassle-free. Our team of experienced drivers and customer support specialists are committed to ensuring your package arrives on time and in perfect condition. Trust us to handle your shipment from start to finish with the utmost care and professionalism.',
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),

              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          color: HexColor('#8CB8D1'),
          image: DecorationImage(
              image: AssetImage('assets/Insurance.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover)),
      height: 200,
      width: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bumper-to-Bumper Insurance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              ReadMoreText(
                'At Vehicle Wave, we offer convenient and reliable door-to-door shipment services for all your transport needs. From pickup at your the origin address to delivery right to your door, we make the shipping process seamless and hassle-free. Our team of experienced drivers and customer support specialists are committed to ensuring your package arrives on time and in perfect condition. Trust us to handle your shipment from start to finish with the utmost care and professionalism.',
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),

              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          color: HexColor('#A7BEAE'),
          image: DecorationImage(
              image: AssetImage('assets/Closed.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover)),
      height: 200,
      width: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Open Enclusure',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              ReadMoreText(
                'At Vehicle Wave, we offer convenient and reliable door-to-door shipment services for all your transport needs. From pickup at your the origin address to delivery right to your door, we make the shipping process seamless and hassle-free. Our team of experienced drivers and customer support specialists are committed to ensuring your package arrives on time and in perfect condition. Trust us to handle your shipment from start to finish with the utmost care and professionalism.',
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),

              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
          color: HexColor('#F6F0E2'),
          image: DecorationImage(
              image: AssetImage('assets/Open.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop,
              ),
              fit: BoxFit.cover)),
      height: 200,
      width: 300,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Closed Enclosure',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              ReadMoreText(
                'At Vehicle Wave, we offer convenient and reliable door-to-door shipment services for all your transport needs. From pickup at your the origin address to delivery right to your door, we make the shipping process seamless and hassle-free. Our team of experienced drivers and customer support specialists are committed to ensuring your package arrives on time and in perfect condition. Trust us to handle your shipment from start to finish with the utmost care and professionalism.',
                trimLines: 2,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlay: true,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
      ),
      items: _cards.map((card) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: card,
            );
          },
        );
      }).toList(),
    );
  }
}
