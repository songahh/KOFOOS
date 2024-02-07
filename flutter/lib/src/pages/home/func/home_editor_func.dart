import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/search/search_detail_page.dart';

void homeEditorFunc(BuildContext context, int i) {
  String itemNo = '';
  if (i == 0) itemNo = '20114';
  else if (i == 1) itemNo = '15839';
  else if (i == 2) itemNo = '30078';
  else if (i == 3) itemNo = '60120';
  else if (i == 4) itemNo = '15054';
  else if (i == 5) itemNo = '35218';

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailView(
        itemNo: itemNo,
      ),
    ),
  );
}
