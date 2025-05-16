import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation_buttons/donationButtons/ko-fiButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/data/models/nation/nation_sketch.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_bloc.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_event.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_state.dart'; // Asegúrate que esta importación es correcta y contiene los estados
import 'package:nation_forge/presentation/views/dashboard.dart';
import 'package:nation_forge/presentation/views/nations_page.dart';
import 'package:nation_forge/presentation/widgets/hub/monthly_nation_container.dart'; // Asegúrate que la ruta sea correcta
// import '../pages/nation_page.dart'; // Descomenta y ajusta si tienes NationPage para la navegación

class HubPage extends StatefulWidget {
  final User? user;
  HubPage({super.key, required this.user});

  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  NationSketch? monthlyNation;
  String? creatorId;

  @override
  void initState() {
    super.initState();
    context.read<NationBloc>().add(LoadMonthlyNation());
  }

  @override
  Widget build(BuildContext context) {
    final List<String> infoMessages = [
      "Crea tu nación fácilmente, introduciendo nombre, tipo de gobierno y época.",
      "Desarrolla tu civilización mediante decisiones estratégicas.",
      "Gestiona recursos, investiga tecnologías y expande tu influencia.",
      "Enfréntate a desafíos y compite o colabora con otras naciones."
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  'Bienvenido ${widget.user?.displayName ?? 'Usuario'}!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Nación Destacada',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            BlocConsumer<NationBloc, NationState>(
              listener: (context, state) {
                if (state is MonthlyNationLoaded) {
                  monthlyNation = state.nation;
                  creatorId = state.creatorName;
                }
              },
              builder: (context, state) {
                if (state is NationLoading) {
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                }
                if (state is MonthlyNationLoaded) {
                  return Center(
                    child: MonthlyNationContainer(
                      nation: state
                          .nation, // Usa directamente state.nation en lugar de monthlyNation
                      creatorId: state
                          .creatorName, // Usa directamente state.creatorName
                    ),
                  );
                }

                return monthlyNation != null && creatorId != null
                    ? Center(
                      child: MonthlyNationContainer(
                          nation: monthlyNation!,
                          creatorId: creatorId!,
                        ),
                    )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
              },
            ),
            SizedBox(height: 30),

            // Informational Carousel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Descubre NationForge',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            CarouselSlider.builder(
              itemCount: infoMessages.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.5))),
                  child: Center(
                    child: Text(
                      infoMessages[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 150,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.85,
              ),
            ),
            SizedBox(height: 30),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.public),
                    label: Text('Mis Naciones'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(page: NationsPage()),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        textStyle: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.shield),
                        label: Text('Mis Guerras'),
                        onPressed: null, // Deshabilitar el botón
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            textStyle: TextStyle(fontSize: 16)),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(
                                8.0), // Opcional: para que coincida con el radio del botón si lo tiene
                          ),
                          child: Center(
                            child: Text(
                              'Próximamente...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  KofiButton(
                    kofiName: 'rubenbitubi',
                    kofiColor: KofiColor.Orange,
                    onDonation: () {
                      Fluttertoast.showToast(
                          msg: 'Gracias por tu apoyo!',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
