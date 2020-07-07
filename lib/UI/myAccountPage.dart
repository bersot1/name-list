import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneWidht = MediaQuery.of(context).size.width;
    final phoneHeigth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFf1f1f1),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Criar Lista",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 13,
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Color(0xff4f5b66),
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: phoneWidht,
            height: 220,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: Container(
                    height: phoneHeigth * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                      ),
                      color: Color(0xff4f5b66),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: ListTile(
                            leading: CircleAvatar(
                              maxRadius: 40,
                              child: Image.network(
                                "https://gravatar.com/avatar/cda5c2ee0420f687b65630c0eea69381?s=400&d=robohash&r=x",
                              ),
                            ),
                            title: Text(
                              "Lucas Bersot",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "lucasbmarinho9@gmail.com",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 270,
                  top: 155,
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[200],
                    ),
                    child: FlatButton(
                      child: Text("Sair"),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Todas suas Listas",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  "Total: ${10}",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Nome da Lista",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            index.toString(),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//  Container(
//                       width: 90,
//                       height: 90,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         image: DecorationImage(
//                           image: NetworkImage(
//                             "https://gravatar.com/avatar/cda5c2ee0420f687b65630c0eea69381?s=400&d=robohash&r=x",
//                           ),
//                         ),
//                       ),
//                     ),
