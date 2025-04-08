import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nation_forge/utils/ad_helper.dart';
import 'package:nation_forge/widgets/create_nation_dialog.dart';
import 'package:nation_forge/widgets/nation_list.dart';

import '../blocs/nation_bloc.dart';
import '../blocs/nation_event.dart';
import '../blocs/nation_state.dart';

class NationsList extends StatefulWidget {
  const NationsList({super.key});

  @override
  State<NationsList> createState() => _NationsListState();
}

class _NationsListState extends State<NationsList> {
  InterstitialAd? _interstitialAd;

  Future<void> _refresh() async {
    context.read<NationBloc>().add(LoadNations());
  }
  
  @override
  void initState() {
    super.initState();
    
    // Crear opciones para el anuncio intersticial con márgenes de seguridad
    final adRequest = AdRequest();
    
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId, 
      request: adRequest, 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          
          // Configurar las opciones de presentación para incluir SafeArea
          ad.setImmersiveMode(true);
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('Interstitial ad showed.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd = null;
              
              // Cargar un nuevo anuncio para futuras interacciones
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              print('Interstitial ad failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      )
    );
  }
  
  // Método para cargar un nuevo anuncio intersticial
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          ad.setImmersiveMode(true);
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('Interstitial ad showed.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd = null;
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              print('Interstitial ad failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CreateNationDialog(interstitialAd: _interstitialAd);
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: const Icon(Icons.add),
      ),
      body: BlocListener<NationBloc, NationState>(
        listener: (context, state) {
          if (state is NationError) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: _refresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              NationList(),
            ],
          ),
        ),
      ),
    );
  }
}
