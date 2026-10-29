import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget{
  int? productId;
   ShareProductButton({required this.productId});
  @override
  Widget build(BuildContext context) {
  return IconButton(onPressed: ()async{
    final productLink = 'https://ecommercehumavolve.web.app/products/$productId';
    final String shareMessage = "Look at this product $productLink";
    await SharePlus.instance.share(
      ShareParams(text: shareMessage, subject: "Chek out")
    );
  }, icon: Icon(Icons.share,));
  }

}