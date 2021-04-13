import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:thaki/globals/index.dart';

class TkCarousel extends StatefulWidget {
  TkCarousel({
    key,
    this.children,
    this.onClick,
    this.onChanged,
    this.emptyMessage = '',
    this.infiniteScroll = false,
    this.showDots = true,
    this.initialPage = 0,
    this.animationDuration = kAnimationInterval,
    this.selectedDotColor = kCarouselSelectedDotColor,
    this.dotColor = kCarouselUnselectedDotColor,
    this.aspectRatio = 2.5,
  }) : super(key: key);
  final bool infiniteScroll;
  final bool showDots;
  final int initialPage;
  final String emptyMessage;
  final Function onChanged;
  final Function onClick;
  final List<Widget> children;
  final int animationDuration;
  final Color selectedDotColor;
  final Color dotColor;
  final double aspectRatio;

  @override
  _TkCarouselState createState() => _TkCarouselState();
}

class _TkCarouselState extends State<TkCarousel> {
  int _currentSlide = 0;
  CarouselSlider _slider;
  List<Widget> _widgets = [];

  /// Create circular navigation indicators
  List<Widget> _createDots() {
    // Returns a list of circular indicators, one for each slide
    List<Widget> indicators = [];

    // Create a dot for each slide
    for (int slide = 0; slide < _widgets.length; slide++) {
      indicators.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            height: 8,
            width: _currentSlide == slide ? 24 : 8,
            decoration: BoxDecoration(
              color: _currentSlide == slide
                  ? widget.selectedDotColor
                  : widget.dotColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      );
    }

    return indicators;
  }

  /// Creates the slider
  void _createSlider() {
    _slider = CarouselSlider.builder(
      itemCount: _widgets.length,
      itemBuilder: (context, idx, _) => _widgets[idx],
      options: CarouselOptions(
        // height: 400,
        aspectRatio: widget.aspectRatio,
        viewportFraction: 1.0,
        initialPage: widget.initialPage,
        enableInfiniteScroll: widget.infiniteScroll,
        onPageChanged: (index, _) {
          setState(() => _currentSlide = index);
          if (widget.onChanged != null) widget.onChanged(index);
        },
      ),
    );
  }

  /// Initializes the _widgets variable
  void _initializeWidgets() {
    if (widget.children == null || widget.children.isEmpty) {
      // No widgets found, add a message
      _widgets.add(
        Center(
          child: Text(
            widget.emptyMessage,
            textAlign: TextAlign.center,
            style: kHintStyle,
          ),
        ),
      );
    } else {
      _widgets = widget.children;
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the _widgets variable
    _initializeWidgets();

    // Create the slider
    _createSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _slider,
          if (widget.showDots)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _createDots(),
              ),
            ),
        ],
      ),
    );
  }
}
