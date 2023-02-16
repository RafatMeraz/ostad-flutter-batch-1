import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyMapApp());
}

class MyMapApp extends StatelessWidget {
  const MyMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  Position? currentLocationLatLng;

  void getCurrentLocation() async {
    LocationPermission permissionStatus = await Geolocator.checkPermission();
    print(permissionStatus);
    if (permissionStatus == LocationPermission.denied) {
      LocationPermission requestedPermission = await Geolocator.requestPermission();
      print(requestedPermission);
    }
    final locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    print(locationServiceEnable);
    currentLocationLatLng = await Geolocator.getCurrentPosition();
    print(currentLocationLatLng);
    print(currentLocationLatLng?.isMocked);
    print(currentLocationLatLng?.heading);
    print(currentLocationLatLng?.speed);
    print(currentLocationLatLng?.speedAccuracy);
    print(currentLocationLatLng?.accuracy);
    setState(() {

    });
  }

  listenToUpdatedLocation() {
    LocationSettings settings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
        timeLimit: Duration(seconds: 3));
    Geolocator.getPositionStream(locationSettings: settings).listen((location) {
      currentLocationLatLng = location;
      setState(() {});
    });
  }

  listenToLocationServiceStatus() {
    Geolocator.getServiceStatusStream().listen((status) {
      print(status);
    });
  }

  @override
  void initState() {
    super.initState();
    listenToUpdatedLocation();
    listenToLocationServiceStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Location : $currentLocationLatLng',
              textAlign: TextAlign.center,
            ),
            TextButton(onPressed: () {
              getCurrentLocation();
            }, child: const Text('Get location'))
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController googleMapController;

  Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    markers = {
      Marker(
        onTap: () {
          print('Marker tapped');
        },
        flat: false,
        draggable: true,
        onDrag: (location) {
          print(location);
        },
        onDragStart: (location) {
          print(location);
        },
        onDragEnd: (location) {
          print(location);
        },
        rotation: 50,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
            title: 'BRTA',
            onTap: () {
              print('Info window tapped');
            }),
        markerId: MarkerId('abc'),
        position: LatLng(23.80560326575505, 90.3745761108481),
      ),
      Marker(
        onTap: () {
          print('Marker tapped');
        },
        flat: false,
        draggable: true,
        onDrag: (location) {
          print(location);
        },
        onDragStart: (location) {
          print(location);
        },
        onDragEnd: (location) {
          print(location);
        },
        rotation: 50,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        infoWindow: InfoWindow(
            title: 'Scholastica',
            onTap: () {
              print('Info window tapped');
            }),
        markerId: MarkerId('lksfk'),
        position: LatLng(23.80472443775955, 90.3774966942303),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapview'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                zoom: 17,
                target: LatLng(23.809296231228714, 90.41996958386494),
              ),
            ),
          );
        },
        child: const Icon(Icons.location_on_outlined),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: GoogleMap(
        mapType: MapType.normal,
        liteModeEnabled: true,
        myLocationEnabled: true,
        trafficEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        markers: markers,
        polylines: <Polyline>{
          Polyline(
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            visible: true,
            color: Colors.blueAccent,
            width: 6,
            polylineId: PolylineId('sfd'),
            points: [
              LatLng(23.80560326575505, 90.3745761108481),
              LatLng(23.80472443775955, 90.3774966942303),
              LatLng(23.802806379193132, 90.37997359405793),
            ],
          ),
          Polyline(
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            visible: true,
            color: Colors.red,
            width: 12,
            polylineId: PolylineId('sdsad'),
            onTap: () {
              print('Tapped polyline');
            },
            points: [
              LatLng(23.802806379193132, 90.37997359405793),
              LatLng(23.80273514001151, 90.37519285964767),
            ],
          ),
        },
        // polygons: <Polygon> {
        //   Polygon(
        //     polygonId: PolygonId('sfdsdf'),
        //     points: [
        //       LatLng(23.80560326575505, 90.3745761108481),
        //       LatLng(23.80472443775955, 90.3774966942303),
        //       LatLng(23.802806379193132, 90.37997359405793),
        //       LatLng(23.80273514001151, 90.37519285964767),
        //     ]
        //   )
        // },
        circles: <Circle>{
          Circle(
              circleId: CircleId('sfdf'),
              center: LatLng(23.80273514001151, 90.37519285964767),
              radius: 200,
              strokeColor: Colors.blue,
              strokeWidth: 2,
              fillColor: Colors.transparent)
        },
        onMapCreated: (GoogleMapController? controller) {
          googleMapController = controller!;
        },
        initialCameraPosition: const CameraPosition(
          zoom: 16,
          target: LatLng(23.80560326575505, 90.3745761108481),
        ),
      ),
    );
  }
}
