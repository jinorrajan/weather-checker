import 'package:flutter/material.dart';
import 'package:weathe_checker/presentaion/views/widgets/custom_app_bar.dart';

class CheckingScreen extends StatefulWidget {
  const CheckingScreen({super.key});

  @override
  State<CheckingScreen> createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {

  var hai= Indicator();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            
              Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Cappbar(),
                  Text("hello",style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            Column(
              children: [
                 Container(
                  height: double.infinity,
                  width: double.infinity,
                  
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Indicator(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }
}