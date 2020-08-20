import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPc;

  ChartBar(this.label, this.spendingAmount, this.spendingPc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(ctx,constraints){ return Column(
        children: <Widget>[
          Container(height: constraints.maxHeight*0.15,child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(
            height: constraints.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(

                    decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey, width: 1.0))),
                FractionallySizedBox(
                  heightFactor: spendingPc,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height:constraints.maxHeight*0.05,
          ),
          Container(height: constraints.maxHeight*0.15,child: FittedBox(child: Text(label)))
        ],
      );}
    );
  }
}
