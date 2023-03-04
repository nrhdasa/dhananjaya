import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

enum FetchState { loading, done }

class Data {
  late FetchState state;
  late Map data;
  Data({required this.state, required this.data});
}

class DonorCubit extends Cubit<Data> {
  final String donorId;
  DonorCubit({required this.donorId}) : super(Data(state: FetchState.loading, data: {})) {
    getDonorDetails(donorId);
  }

  getDonorDetails(String id) async {
    var api = await Auth.getAPI();
    var url = Uri.https(api['domain'], 'api/resource/Donor/$id');
    var response = await http.get(
      url,
      headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
    );
    print("sending from Bloc");
    var data = Data(data: jsonDecode(response.body)['data'], state: FetchState.done);
    emit(data);
  }

  updateLocation(String addressId) async {
    emit(Data(state: FetchState.loading, data: {}));
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
    var api = await Auth.getAPI();
    Uri url = Uri.https(
      api['domain'],
      '/api/resource/Donor Address/$addressId',
    );
    await http.put(url,
        headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'}, body: {'longitude': (locationData.longitude ?? 0.0).toString(), 'latitude': (locationData.latitude ?? 0.0).toString()});
    this.getDonorDetails(this.donorId);
  }
}
