part of 'widgets.dart';

AppBar AppBarWidget({src, action}) {
  return (AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      height: 30,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(src),
        fit: BoxFit.contain,
        alignment: Alignment.center,
      )),
    ),
    shadowColor: Color(0xFF023047).withOpacity(0.1),
    centerTitle: true,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF023047),
    elevation: 8,
    // // actions: [
    // //   GestureDetector(
    // //     onTap: () => {action()},
    // //     child: Icon(
    // //       Icons.search,
    // //       color: accentColor[1],
    // //       size: 30.0,
    // //     ),
    // //   ),
    // //   SizedBox(
    // //     width: 10,
    // //   ),
    // ],
  ));
}
