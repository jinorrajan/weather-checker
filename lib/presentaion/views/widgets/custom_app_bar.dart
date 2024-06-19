import 'package:flutter/material.dart';
import 'package:weathe_checker/presentaion/views/widgets/search.dart';

class Cappbar extends StatelessWidget {
  const Cappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeigth = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: screenHeigth * 0.08,
          width: double.infinity,
          decoration:const BoxDecoration(
              color: Color.fromARGB(16, 56, 56, 56),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: screenHeigth*0.02, left: screenwidth*0.30),
                child: Image.asset('assets/images/Title.png'),
              ),
              Padding(
                padding:  EdgeInsets.only(top: screenHeigth*0.01, left: screenwidth*0.18),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SearchScreen.routName);
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: const Color.fromARGB(221, 176, 176, 176),
                  ),
                ),
              ),
            ],
          ),
        ),

        //search bar
        // searchBar()
      ],
    );
  }
}
