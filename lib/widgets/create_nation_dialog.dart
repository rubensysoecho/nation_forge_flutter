import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nation_forge/blocs/nation_bloc.dart';
import 'package:nation_forge/blocs/nation_event.dart';
import '../app_theme.dart';

class CreateNationDialog extends StatefulWidget {
  final InterstitialAd? interstitialAd;
  const CreateNationDialog({super.key, this.interstitialAd});

  @override
  State<CreateNationDialog> createState() => _CreateNationDialogState();
}

class _CreateNationDialogState extends State<CreateNationDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _governmentTypeController =
      TextEditingController();
  final TextEditingController _eraController = TextEditingController();
  final TextEditingController _leaderNameController = TextEditingController();
  final TextEditingController _economicSystemController =
      TextEditingController();
  final TextEditingController _currencyNameController = TextEditingController();
  final TextEditingController _lifeExpectancyController =
      TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  bool _isAdvanced = false;
  bool _isAC = false;
  double _wealthDistribution = 50.0;
  double _populationGrowth = 1.0;
  double _politicalStability = 50.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: AppTheme.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Colors.white30,
            width: 1.5,
          ),
        ),
        elevation: 8,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Crear Nación',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            blurRadius: 3.0,
                            color: Colors.black26,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Simple',
                      style: TextStyle(
                        color: _isAdvanced ? Colors.white70 : Colors.white,
                        fontWeight:
                            _isAdvanced ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                      value: _isAdvanced,
                      onChanged: (bool value) {
                        setState(() {
                          _isAdvanced = value;
                        });
                      },
                      activeColor: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Avanzado',
                      style: TextStyle(
                        color: _isAdvanced ? Colors.white : Colors.white70,
                        fontWeight:
                            _isAdvanced ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildTextField(_nameController, 'Nombre de la Nación'),
                const SizedBox(height: 15),
                _buildTextField(_governmentTypeController, 'Tipo de Gobierno'),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _eraController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: AppTheme.primaryColor,
                        maxLength: _isAC ? 5 : 4,
                        decoration: InputDecoration(
                          labelText: 'Era',
                          labelStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white30),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                      value: _isAC,
                      onChanged: (bool value) {
                        setState(() {
                          _isAC = value;
                        });
                      },
                      activeColor: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _isAC ? 'a.C' : 'd.C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                if (_isAdvanced) ...[
                  _buildSectionTitle('Política'),
                  const SizedBox(height: 10),
                  _buildTextField(_leaderNameController, 'Nombre del Líder'),
                  const SizedBox(height: 15),
                  _buildSlider(
                    'Estabilidad Política',
                    _politicalStability,
                    (value) {
                      setState(() {
                        _politicalStability = value;
                      });
                    },
                    sections: [
                      'Inestable',
                      'Frágil',
                      'Estable',
                      'Muy Estable',
                      'Sólida'
                    ],
                  ),
                  _buildSectionTitle('Economía'),
                  const SizedBox(height: 10),
                  _buildTextField(
                      _economicSystemController, 'Sistema Económico'),
                  const SizedBox(height: 15),
                  _buildTextField(
                      _currencyNameController, 'Nombre de la Moneda'),
                  const SizedBox(height: 15),
                  _buildSlider(
                    'Distribución de la Riqueza',
                    _wealthDistribution,
                    (value) {
                      setState(() {
                        _wealthDistribution = value;
                      });
                    },
                    sections: [
                      'Concentrada',
                      'Desigual',
                      'Mixta',
                      'Equitativa',
                      'Igualitaria'
                    ],
                  ),
                  _buildSectionTitle('Demografía'),
                  const SizedBox(height: 10),
                  _buildTextField(
                      _lifeExpectancyController, 'Expectativa de Vida'),
                  const SizedBox(height: 15),
                  _buildSlider(
                    'Crecimiento Poblacional (% anual)',
                    _populationGrowth,
                    (value) {
                      setState(() {
                        _populationGrowth = value;
                      });
                    },
                  ),
                  Text(
                    _populationGrowth <= 0
                        ? 'Decrecimiento poblacional'
                        : _populationGrowth < 1
                            ? 'Crecimiento lento'
                            : _populationGrowth < 2
                                ? 'Crecimiento moderado'
                                : _populationGrowth < 3
                                    ? 'Crecimiento rápido'
                                    : _populationGrowth < 4
                                        ? 'Crecimiento muy rápido'
                                        : 'Auge poblacional',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  _buildSectionTitle('Otros'),
                  _buildTextField(_otherController, 'Otras características'),
                ],
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _governmentTypeController.text.isEmpty ||
                        _eraController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg:
                            "Por favor, rellene todos los campos obligatorios.",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else {
                      if (_isAdvanced) {
                        context.read<NationBloc>().add(
                              CreateNationAdvanced(
                                _nameController.text,
                                _governmentTypeController.text,
                                '${_eraController.text} ${_isAC ? 'a.C' : 'd.C'}',
                                _leaderNameController.text,
                                _politicalStability,
                                _economicSystemController.text,
                                _currencyNameController.text,
                                _wealthDistribution,
                                _lifeExpectancyController.text,
                                _populationGrowth,
                                _otherController.text,
                              ),
                            );
                      } else {
                        context.read<NationBloc>().add(
                              CreateNation(
                                _nameController.text,
                                _governmentTypeController.text,
                                '${_eraController.text} ${_isAC ? 'a.C' : 'd.C'}',
                              ),
                            );
                      }

                      if (widget.interstitialAd != null) {
                        try {
                          widget.interstitialAd!.show();
                        } catch (e) {
                          print('Error al mostrar anuncio intersticial: $e');
                        }
                      }
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    'Generar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black38,
                  ),
                  onPressed: () {
                    context.read<NationBloc>().add(CreateRandomNation());
                    if (widget.interstitialAd != null) {
                      try {
                        widget.interstitialAd!.show();
                      } catch (e) {
                        print('Error al mostrar anuncio intersticial: $e');
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shuffle, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Random',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      cursorColor: AppTheme.primaryColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white30),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: AppTheme.primaryColor.withOpacity(0.3),
      ),
    );
  }

  Widget _buildSlider(String label, double value, Function(double) onChange,
      {List<String>? sections}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Slider(
          value: value,
          min: 0.0,
          max: sections == null ? 5.0 : 100.0,
          divisions: sections == null ? 50 : 4,
          label: sections == null
              ? value.toStringAsFixed(1)
              : sections[(value ~/ 25).toInt()],
          activeColor: AppTheme.secondaryColor,
          inactiveColor: Colors.white30,
          onChanged: onChange,
        ),
        if (sections != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: sections
                .map((section) => Text(
                      section,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child:
                Divider(color: Colors.white.withOpacity(0.5), thickness: 1.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  const Shadow(
                    blurRadius: 2.0,
                    color: Colors.black26,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
                Divider(color: Colors.white.withOpacity(0.5), thickness: 1.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _governmentTypeController.dispose();
    _eraController.dispose();
    _leaderNameController.dispose();
    _economicSystemController.dispose();
    _currencyNameController.dispose();
    _lifeExpectancyController.dispose();
    super.dispose();
  }
}
