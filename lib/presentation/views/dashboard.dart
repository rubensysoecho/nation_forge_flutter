import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nation_forge/app/app_theme.dart';
import 'package:nation_forge/presentation/providers/blocs/nation/nation_event.dart';
import 'package:nation_forge/core/l10n/app_localizations.dart';
import 'package:nation_forge/core/utils/ad_helper.dart';
import 'package:nation_forge/presentation/views/hub.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/blocs/nation/nation_bloc.dart';
import 'login.dart';
import 'nations_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Dashboard extends StatefulWidget {
  final Widget page;
  const Dashboard({super.key, required this.page});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _version = 'Cargando...';
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _initVersion();
    context.read<NationBloc>().add(LoadNationSketches());
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  Future<void> _initVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = 'v${packageInfo.version}';
      });
    } catch (e) {
      _version = 'Error';
    }
  }

  Future<void> _logOff() async {
    final localizations = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.primaryColor,
          title: Text(localizations.loginButton),
          content: Text(localizations.logoutConfirmation),
          actions: <Widget>[
            TextButton(
              child: Text(
                localizations.cancel,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                localizations.save,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('user_id', '');
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage() {
    final localizations = AppLocalizations.of(context);
    final provider = AppLocalizationsProvider.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.primaryColor,
          title: Text(localizations.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(localizations.spanish,
                    style: TextStyle(color: Colors.white)),
                trailing: provider.locale.languageCode == 'es'
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () {
                  provider.onChangeLocale(const Locale('es'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(localizations.english,
                    style: TextStyle(color: Colors.white)),
                trailing: provider.locale.languageCode == 'en'
                    ? Icon(Icons.check, color: Colors.white)
                    : null,
                onTap: () {
                  provider.onChangeLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Selector de idioma
          IconButton(
            onPressed: _changeLanguage,
            icon: Icon(Icons.language),
            tooltip: localizations.language,
          ),
          // Botón de cerrar sesión
          IconButton(
            onPressed: _logOff,
            icon: Icon(Icons.logout),
            tooltip: localizations.loginButton,
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          localizations.appTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                widget.page,
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                    child: Text(
                      _version,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_bannerAd != null)
            SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}
