import 'package:flutter/material.dart';

import 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String location;
  final bool hasActions;

  // ignore: use_super_parameters
  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Sk-Modernist',
                fontWeight: FontWeight.w800,
                fontSize: 32,
              )),
          Text(location,
              style: TextStyle(
                color: Colors.grey,
                fontFamily: 'Sk-Modernist',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
        ],
      ),
      actions: hasActions
          ? [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE8E6EA)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.tune,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    onPressed: () => _showFiltersModal(context),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  void _showFiltersModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => SizedBox(
              // Set a maximum height to avoid exceeding device bounds
              height: MediaQuery.of(context).size.height * 0.85,

              child: FiltersScreen(),
            ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ));
  }
}
