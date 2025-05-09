import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nation_forge/core/utils/ad_helper.dart';
import 'package:nation_forge/presentation/providers/viewmodels/nations_list_viewmodel.dart';
import 'package:nation_forge/presentation/providers/viewmodels/nations_sketch_list_viewmodel.dart';
import 'package:nation_forge/presentation/widgets/dashboard/create_nation_dialog.dart';
import 'package:nation_forge/presentation/widgets/nation/nation_list_widget.dart';

import '../providers/blocs/nation/nation_bloc.dart';
import '../providers/blocs/nation/nation_event.dart';
import '../providers/blocs/nation/nation_state.dart';

class NationsPage extends StatefulWidget {
  const NationsPage({super.key});

  @override
  State<NationsPage> createState() => _NationsPageState();
}

class _NationsPageState extends State<NationsPage> {
  InterstitialAd? _interstitialAd;

  Future<void> _refresh() async {
    context.read<NationBloc>().add(LoadNationSketches());
  }
  
  @override
  void initState() {
    super.initState();
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
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd = null;
              
              // Cargar un nuevo anuncio para futuras interacciones
              _loadInterstitialAd();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          Fluttertoast.showToast(msg: 'Interstitial ad failed to load: $error');
        },
      )
    );
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          ad.setImmersiveMode(true);
          
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              _interstitialAd = null;
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              Fluttertoast.showToast(msg: 'Interstitial ad failed to show: $error');
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          Fluttertoast.showToast(msg: 'Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NationsSketchListViewmodel viewModelSketch = NationsSketchListViewmodel(
      nationBloc: context.read<NationBloc>()
    );
    
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
              NationListWidget(viewModel: viewModelSketch),
            ],
          ),
        ),
      ),
    );
  }
}
