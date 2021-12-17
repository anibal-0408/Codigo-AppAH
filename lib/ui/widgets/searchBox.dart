import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key, this.onChanged,
  }) : super(key: key);
  final ValueChanged onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon: Image.asset("icons/icon_search.png",width: ScreenUtil.getInstance().setWidth(20)),
          hintText: 'Buscar',
          hintStyle: TextStyle(color: Colors.black)
        ),
      ),
    );
  }
}