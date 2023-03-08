import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fpdart/fpdart.dart';

import '../connectivity.dart';
import '../resources/utils.dart';

typedef ErrorSearch<T> = Future<Either<ErrorResponse, T>>;

List INITITAL_FILTERS = ['name'];

enum FetchingState { loading, done, failed }

class SearchBloc extends Bloc<Map, Map> {
  String search = "";
  List filters = INITITAL_FILTERS;
  List donors = [];
  SearchBloc() : super({'data': [], 'filters': INITITAL_FILTERS, 'state': FetchingState.done}) {
    on<Map>((event, emit) async {
      if (event.containsKey('search')) {
        search = event['search'];
      }
      if (event.containsKey('filterKey')) {
        toggleFilterKey(event['filterKey']);
      }
      emit({'data': donors, 'filters': filters, 'state': FetchingState.loading});
      var donorsResponse = await getDonors();
      donorsResponse.fold((l) {
        emit({'data': donors, 'filters': filters, 'state': FetchingState.failed, 'errorResponse': l});
      }, (r) {
        emit({'data': r, 'filters': filters, 'state': FetchingState.done});
      });
    }, transformer: sequential());
  }

  toggleFilterKey(key) {
    if (!filters.contains(key)) {
      filters.add(key);
    } else if (!(filters.length == 1)) {
      filters.remove(key);
    }
  }

  ErrorSearch<List> getDonors() async {
    var api = await Auth.getAPI();
    try {
      var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.donor.donors_search', {'searchquery': search, 'filters': json.encode(filters)});
      var response = await http.get(
        url,
        headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
      );
      if (response.statusCode == 200) {
        return right(jsonDecode(response.body)['message']);
      } else {
        print(response.body);
        return left(ErrorResponse(t: jsonDecode(response.body)['exc_type'], m: jsonDecode(response.body)['exception']));
      }
    } catch (e) {
      print(e);
      return left(ErrorResponse(m: e.toString()));
    }
  }
}
