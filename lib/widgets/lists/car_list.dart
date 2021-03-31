import 'package:flutter/material.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/car_tile.dart';

class TkCarList extends StatelessWidget {
  TkCarList({this.cars, this.onTap});
  final List<TkCar> cars;
  final Function onTap;

  List<Widget> _getCarTiles() {
    List<Widget> tiles = [];

    for (TkCar car in cars) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: TkCarTile(car: car, onTap: onTap),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _getCarTiles());
  }
}
