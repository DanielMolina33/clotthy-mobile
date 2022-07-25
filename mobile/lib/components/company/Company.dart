// Flutter
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../../providers/CompanyProvider.dart';

// Components
import '../appBar/appBar.dart';
import '../button/Button.dart';
import './AddCompany.dart';
import 'EditCompany.dart';

class Company extends StatefulWidget {
  const Company({Key? key}) : super(key: key);

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  LocalStorage storage = LocalStorage("session");

  @override
  void initState() {
    super.initState();
    Provider.of<CompanyProvider>(context, listen: false).getCompanies(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final companies = Provider.of<CompanyProvider>(context).companies;

    List<Widget> itemMap = companies!.map((e) => Card(
            shadowColor: Color.fromARGB(255, 36, 91, 189),
            elevation: 5,
            shape:
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                )
            ),
            margin: const EdgeInsets.only(bottom: 30),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Text(
                    e.nombreempresa!,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),                
                  const SizedBox(height: 3),
									e.nitempresa!.isEmpty
									? const Text("Sin datos")
                  : Text("Nit #${e.nitempresa!}"),
                  const Divider(
                    indent: 3.5,
                  ),
                  // iconos botones para redireccionar la card
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () => {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditCompany(e.id!)))
                                  .then((value) => setState((){
                                    Provider.of<CompanyProvider>(context, listen: false).getCompanies(context);
                                  },)
                                ),
                              },
                            icon: Icon(
                              FontAwesomeIcons.penToSquare,
                              color: Color.fromARGB(255, 36, 91, 189),
                            )),
                      ],
                    ),
                  ),
                ]))))
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: const Color.fromARGB(250, 252, 255, 253),
        floatingActionButton: const ButtonDesp(),
        body: companies.isEmpty ? const Loading() : Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
               Container(
                     padding: const EdgeInsets.only(
                      right: 20,
                      bottom: 20,
                      left: 20,
                     ),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Empresas',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400
                            )
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 36, 91, 189))),
                            onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AddCompany()))
                                .then((value) => setState((){
																	Provider.of<CompanyProvider>(context, listen: false).getCompanies(context);
																},)
                              );
                            },
                            child: const Icon(FontAwesomeIcons.plus)
                          )
                        ],
                      )
                    ),
              SizedBox(
                height: size.height * 0.65,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: itemMap,
                ),
              ),
              // const SizedBox(height: 30),
              // Container(
              //   width: double.infinity,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       IconButton(
              //         highlightColor: const Color.fromARGB(255, 36, 91, 189),
              //         onPressed: () {},
              //         icon: const Icon(
              //           FontAwesomeIcons.arrowLeft,
              //           color: Colors.black,
              //           size: 30,
              //         ),                      
              //       ),
              //      const SizedBox(width: 40),
              //       IconButton(
              //         highlightColor:const Color.fromARGB(255, 36, 91, 189),
              //         onPressed: () {},
              //         icon: const Icon(
              //           FontAwesomeIcons.arrowRight,
              //           color: Colors.black,
              //           size: 30,
              //         ),                      
              //       ),
              //     ]
              //   )
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Cargando...",
        style: TextStyle(
          fontSize: 20
        )
      ),
    );
  }
}
