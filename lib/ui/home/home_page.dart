import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_flutter/ui/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(create: 
    (_) {
      final controller =  HomeController();
      controller.onMarkerTap.listen((String id) {
        print(id);
      });
      return controller;
    },
    child:Scaffold(
      
      body: Selector<HomeController, bool>(
        selector: (_, controller) => controller.loading,
        builder: (context, loagind, loagindWidget)
        {
          if(loagind){
            return loagindWidget!;
          }
         return Consumer<HomeController>(
        builder: (_, controller, gpsMessageWidget) {

          if(
            !controller.gpsEnable){
            return gpsMessageWidget!;
          } 

          

          return SafeArea(
        child: Column(
          children: [
            Expanded(
              child: 
              GoogleMap(
                markers:  controller.markers,
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: controller.initialCameraPosition,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: controller.onTap,
              )
            ),
          ],
        ),
        
      );
        },
        child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Cuando use la App habilite el GPS",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed:(){
                      final controller = context.read<HomeController>();
                      controller.turnOnGPS();
                    }, 
                    child: const Text("Encender el GPS"))
                ],
              ),
            ),
      );
        },
      child: const Center(
              child: CircularProgressIndicator()),
      ),
      floatingActionButton: 
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             FloatingActionButton(
                onPressed: (){
                  
                },
                child: const Icon(Icons.pinch),
              ),
              const SizedBox(width: 8,),
              FloatingActionButton(
                onPressed: (){
                  
                },
                child: const Icon(Icons.location_on),
            ),
           ],
         ),
    ));
  }
}