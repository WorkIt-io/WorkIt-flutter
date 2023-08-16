import 'package:flutter/material.dart';
import 'package:workit/models/business.dart';
import 'package:workit/screens/businesses_detail_screen.dart';

import '../../providers/business.dart';

class BusinessTile extends StatelessWidget {
  final Business _business;

  const BusinessTile(this._business, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () {
              selectedBusiness = _business;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => BusinessDeatilScreen(business: _business,)));},
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
                const SizedBox(width: 10),
                Text("${_business.distance} km away"),
              ]),
              Row(children: [
                Text(_business.rate.toString()),
                const Icon(Icons.star_rate),
                const SizedBox(width: 10),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
