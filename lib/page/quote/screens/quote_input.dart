import 'package:flutter/material.dart';
import 'package:mailbox/page/quote/screens/company_info/company_info_cart.dart';

import '../../../widgets/text_button.dart';
class QuoteInput extends StatefulWidget {
  const QuoteInput({super.key});

  @override
  State<QuoteInput> createState() => _QuoteInputState();
}

class _QuoteInputState extends State<QuoteInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InteractiveTextButton(
                onPressed: ()=>companyInfoAlertDialog(context),
                child:Text('Company Info',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade300
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
