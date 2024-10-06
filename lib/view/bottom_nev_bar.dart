import 'package:flutter/material.dart';
import 'package:get_your_fashion/view/home/home_screen.dart';


class BottomNevBar extends StatefulWidget {
  final int? indexId;
  const BottomNevBar({super.key, this.indexId,});

  @override
  State<BottomNevBar> createState() => _BottomNevBarState();
}

class _BottomNevBarState extends State<BottomNevBar> {
  final pages = [
     const  HomeScreen(),
  //   const ViewOrderScreen(),
  //   const TabBarScreen(),
  //   const ChatScreen(),
  //   const AccountScreen(),
   ];

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageIndex=(widget.indexId ?? pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:Image.asset("assets/logo_bg.png"),
        titleSpacing: 0,
        title:  const Text(
          "Get your fashion",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,

          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10.0), // Adjust the right padding as needed
              child:InkWell(
                  // onTap: (){
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context)=> const HelpScreen(),),
                  //   );
                  // },
                  child: const Icon(Icons.help))
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          // gradient: LinearGradient(
          //     colors: [bgcolor, Colors.white],
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? Image.asset(
                    'assets/logo_bg.png',
                    height: 32,


                  )
                      :Image.asset(
                    'assets/logo_bg.png',
                    height: 30,


                  )
              ),
              pageIndex == 0
                  ? const Text(
                'Home',
                style: TextStyle(
                    fontSize: 12,
                    color:Color(0xffEC6736),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Home',
                style: TextStyle(
                    fontSize: 10,
                    color:Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: pageIndex == 1
                      ? const Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Color(0xffEC6736),
                  )
                      :const Icon(
                    Icons.shopping_cart,
                    size: 25,
                    color: Colors.grey,
                  )
              ),
              pageIndex == 1
                  ? const Text(
                'Order',
                style: TextStyle(
                    fontSize: 11,
                    color:Color(0xffEC6736),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Order',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: Color(0xffEC6736),
                )
                    : const Icon(
                  Icons.shopping_bag,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              pageIndex == 2
                  ? const Text(
                'Bag',
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xffEC6736),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Bag',
                style: TextStyle(
                    fontSize: 10,
                    color:  Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? const Icon(
                  Icons.chat,
                  color:Color(0xffEC6736),
                  size: 25,
                )
                    : const Icon(
                  Icons.chat,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              pageIndex == 3
                  ? const Text(
                'Chat',
                style: TextStyle(
                    fontSize: 10,
                    color:Color(0xffEC6736),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Chat',
                style: TextStyle(
                    fontSize: 10,
                    color:Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                icon: pageIndex == 4
                    ? const Icon(
                  Icons.account_box,
                  color: Color(0xffEC6736),
                  size: 25,
                )
                    : const Icon(
                  Icons.account_box,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              pageIndex == 4
                  ? const Text(
                'Account',
                style: TextStyle(
                    fontSize: 10,
                    color:Color(0xffEC6736),
                    fontWeight: FontWeight.bold),
              )
                  : const Text(
                'Account',
                style: TextStyle(
                    fontSize: 10,
                    color:Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

