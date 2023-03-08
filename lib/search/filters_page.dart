import 'package:dhananjaya/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<SearchBloc, Map>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Select the fields to search:'),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: ['name', 'address', 'contact', 'email']
                        .map(
                          (e) => ChoiceChip(
                            label: Text(
                              toBeginningOfSentenceCase(e) ?? '',
                              style: TextStyle(color: colors.onPrimaryContainer, fontSize: 20),
                            ),
                            selectedColor: colors.primaryContainer,
                            onSelected: (val) {
                              context.read<SearchBloc>().add({'filterKey': e});
                            },
                            selected: state['filters'].contains(e) as bool,
                          ),
                        )
                        .toList(),
                  )
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
