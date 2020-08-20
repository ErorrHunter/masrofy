import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
 final Function deletetran;
  TransactionList(this.transaction,this.deletetran);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 350,
      child: ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx, index) {
          return Card(  
            child: ListTile(
              leading:CircleAvatar(
                radius: 30,
                child: Padding(
                  padding:  EdgeInsets.all(6.0),
                  child: Text('\$${transaction[index].amount}'),
                ),
              ),
              title: FittedBox(child: Text(transaction[index].title,style: TextStyle(fontSize: 5),
              ),
              ),
              subtitle: Text('${DateFormat.yMMMd().format(transaction[index].date)}'),
              trailing: IconButton(icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: ()=>deletetran(transaction[index].id),),
            ),
          );
        },

      ),
    );
  }
}
