import 'package:cinema_booker/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const String mapBoxApiKey =
    'pk.eyJ1IjoibXVzdGFwaGFib3Vkb3VjaCIsImEiOiJjbHlsa3poeDAxYmtqMm1xeTRpdHdwcnc3In0.q0QYbXdKgNbPzx9z1RFFug';

class MapView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            widget.latitude,
            widget.longitude,
          ),
          initialZoom: 15.0,
          minZoom: 5.0,
          maxZoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$mapBoxApiKey',
            fallbackUrl:
                'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=$mapBoxApiKey',
            additionalOptions: const {
              'id': 'mapbox/dark-v11',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  widget.latitude,
                  widget.longitude,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: ThemeColor.yellow,
                  size: 30,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
