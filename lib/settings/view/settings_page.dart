import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_client/movies_client.dart';
import 'package:very_good_movies/l10n/l10n.dart';
import 'package:very_good_movies/settings/cubit/settings_cubit.dart';

class ViewSettings extends StatefulWidget {
  const ViewSettings({
    super.key,
    required this.languages,
  });

  final List<Language> languages;

  static const name = 'settings';

  @override
  State<ViewSettings> createState() => _ViewSettingsState();
}

class _ViewSettingsState extends State<ViewSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        elevation: 4,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(
                  context.l10n.darkMode,
                  style: Theme.of(context).textTheme.caption,
                ),
                trailing: Switch(
                  value: state.isDarkMode,
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleDarkMode();
                  },
                ),
              ),
              ListTile(
                title: Text(
                  context.l10n.language,
                  style: Theme.of(context).textTheme.caption,
                ),
                trailing: DropdownButton<String>(
                  dropdownColor: Theme.of(context).cardColor,
                  style: Theme.of(context).textTheme.caption,
                  iconEnabledColor: Theme.of(context).indicatorColor,
                  value: state.language.iso,
                  onChanged: (value) {
                    final selectedLanguage = widget.languages.firstWhere(
                      (language) => language.iso == value,
                    );
                    setState(() {
                      context.read<SettingsCubit>().changeLanguage(
                            selectedLanguage,
                          );
                    });
                  },
                  items: widget.languages
                      .map(
                        (language) => DropdownMenuItem<String>(
                          value: language.iso,
                          child: Text(
                            language.englishName,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
