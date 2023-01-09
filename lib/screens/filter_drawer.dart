import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/models/author.dart';
import 'package:shelf_mobil_frontend/services/api_service.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  late int pageIndex;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  _onChangePage(int index) {
    if (index != 0) {
      setState(() => pageIndex = index);
    }
    _controller.animateToPage(index.clamp(0, 1),
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return FirstDrawer(
            author: () => _onChangePage(1),
            shipmentType: () => _onChangePage(2),
          );
        }

        switch (pageIndex) {
          case 1:
            return AuthorFilter(goBack: () {
              _onChangePage(0);
            });
          case 2:
          default:
            return ShipmentTypeFilter(goBack: () => _onChangePage(0));
        }
      },
    ));
  }
}

class FirstDrawer extends StatelessWidget {
  final VoidCallback author;
  final VoidCallback shipmentType;

  const FirstDrawer(
      {super.key, required this.author, required this.shipmentType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Author'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: author,
          ),
          Divider(color: Colors.grey.shade300, thickness: 0.5),
          ListTile(
            title: const Text('Shipment Type'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: shipmentType,
          ),
          Divider(color: Colors.grey.shade300, thickness: 0.5),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        child: const Text("FILTER BOOKS"),
        onPressed: () {
          Scaffold.of(context).closeEndDrawer();
        },
      ),
    );
  }
}

class AuthorFilter extends StatefulWidget {
  const AuthorFilter({super.key, required this.goBack});
  final VoidCallback goBack;

  @override
  State<AuthorFilter> createState() => _AuthorFilterState();
}

class _AuthorFilterState extends State<AuthorFilter> {
  bool isSelectionMode = false;
  List<Author> _authorList = [];

  @override
  void initState() {
    super.initState();
    getAuthorList();
  }

   void getAuthorList() async {
    var response = await ApiService.getAuthors();
    _authorList = authorFromJson(response.body);
    _authorList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    setState(() {});
  }

  Map<int, bool> selectedFlag = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Author Filter",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        leading: BackButton(onPressed: widget.goBack, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          var title = _authorList[index];
          selectedFlag[index] = selectedFlag[index] ?? false;
          bool isSelected = selectedFlag[index]!;
          return Container(
            color: isSelected ? const Color.fromARGB(70, 76, 185, 252) : null,
            child: ListTile(
              onTap: () => onTap(isSelected, index),
              title: Text(title.name),
            ),
          );
        },
        itemCount: _authorList.length,
      ),
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }
}

class ShipmentTypeFilter extends StatefulWidget {
  const ShipmentTypeFilter({super.key, required this.goBack});
  final VoidCallback goBack;
  @override
  State<ShipmentTypeFilter> createState() => _ShipmentTypeFilterState();
}

class _ShipmentTypeFilterState extends State<ShipmentTypeFilter> {
  bool isSelectionMode = false;
  final List<String> shipmentTypeList = ["Sender", "Receiver"];
  Map<int, bool> selectedFlag = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipment Type Filter",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        leading: BackButton(onPressed: widget.goBack, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemBuilder: (builder, index) {
          var title = shipmentTypeList[index];
          selectedFlag[index] = selectedFlag[index] ?? false;
          bool isSelected = selectedFlag[index]!;
          return Container(
            color: isSelected ? const Color.fromARGB(70, 76, 185, 252) : null,
            child: ListTile(
              onTap: () => onTap(isSelected, index),
              title: Text(title),
            ),
          );
        },
        itemCount: shipmentTypeList.length,
      ),
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }
}
