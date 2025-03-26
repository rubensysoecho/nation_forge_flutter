# Nation Forge: Historia Alternativa 🌍

## Descripción

Este proyecto genera relatos detallados e inmersivos sobre naciones ficticias en contextos históricos alternativos. Está diseñado para crear narrativas coherentes y realistas que exploran cómo las naciones ficticias interactúan y se ven influenciadas por la historia real.

## Características

* Generación de narrativas históricas detalladas 📜.
* Contexto histórico, geopolítico y político de las naciones ficticias 🗺️.
* Descripción de la población, curiosidades históricas y personajes importantes 👨‍👩‍👧‍👦.
* Integración creíble de naciones ficticias en la historia real 🤝.

###   Parámetros de Entrada

La IA toma los siguientes parámetros para generar la narrativa:

* **Nombre de la nación:** El nombre de la nación ficticia.
* **Tipo de gobierno:** El gobierno que rige esa nación
* **Año:** El año en el que se debe representar la nación.

###   Formato de Salida

La IA genera el relato en formato JSON, incluyendo los siguientes campos:

    {
        "name": "Nombre de la nación",
        "historicalContext": "",
        "politics": "",
        "geopoliticalContext": "",
        "population": "",
        "historicalCuriosities": ["", ""],
        "importantCharacters": ["", ""],
        "events": [
            {
                "type": "fundacion",
                "date": "Fecha de fundación (ISO 8601)",
                "title": "Fundación de la Nación",
                "description": "Descripción del contexto histórico de la fundación"
            },
        ]
    }

## Estructura del Proyecto

El proyecto se compone de los siguientes directorios y archivos:

* `blocs`:

    * `nation_bloc.dart`
    * `nation_event.dart`
    * `nation_state.dart`
    * `war_bloc.dart`
    * `war_event.dart`
    * `war_state.dart`
* `core`:

    * `nation_api_service.dart`
    * `war_api_service.dart`
* `models`:

    * `event.dart`
    * `nation.dart`
    * `war.dart`
* `repos`:

    * `auth_repository.dart`
    * `nation_repository.dart`
    * `war_repository.dart`
* `screens`:

    * `dashboard.dart`
    * `login.dart`
    * `nation_detail.dart`
    * `nations_list.dart`
    * `timeline.dart`
    * `war_detail.dart`
    * `wars_list.dart`
* `widgets`:

    * `app_theme.dart`
* `main.dart`
* `README.md`
* `nation_data.dart`: Define la estructura de datos de la nación y sus eventos 🗂️.
* `nation_timeline_screen.dart`: Implementa la pantalla de la línea de tiempo de la nación en Flutter 📱.

## Contribución

Las contribuciones son bienvenidas 🎉. Por favor, abre un "issue" 💬 para discutir los cambios propuestos antes de enviar un "pull request" 📤.

## Licencia

Este proyecto está licenciado bajo la [Licencia MIT](https://opensource.org/licenses/MIT) 📄.

