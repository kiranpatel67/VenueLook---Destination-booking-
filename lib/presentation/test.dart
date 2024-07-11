
import 'package:FoGraph/Data_model/HomeScreen_data_model.dart';
import 'package:flutter/material.dart';
class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getOffersStreamBuilder()
      ),
    );
  }


  Widget getOffersStreamBuilder() {
    return FutureBuilder<List<HomeDestinationData>>(
      future: getOffersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HomeDestinationData> offers = snapshot.data!;
          return ListView.builder(
            itemCount: offers.length,
            itemBuilder: (context, index) {
              HomeDestinationData offer = offers[index];
              return Card(
                child: ListTile(
                  title: Text(offer.city?? ''),
                  subtitle: Text(offer.propertyAddress?? ''),
                  leading: Image.network(offer.propertyImages?.first ?? ''),
                  trailing: Text('\$${offer.price}'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
