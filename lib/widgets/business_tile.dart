import 'package:flutter/material.dart';
import 'package:workit/models/business.dart';

class BusinessTile extends StatelessWidget {
  final Business _business;

  BusinessTile(this._business);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.network(
                _business.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(_business.name),
            subtitle: Text(_business.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                SizedBox(width: 10),
                Text("${_business.distance} km away"),
              ]),
              Row(children: [
                Text(_business.rate.toString()),
                Icon(Icons.star_rate),
                SizedBox(width: 10),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
