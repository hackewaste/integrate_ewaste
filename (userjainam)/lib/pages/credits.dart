import 'dart:collection';

// Mapping of detected e-waste items to their assigned credit values
final Map<String, int> ewasteCredits = {
  'Air-Conditioner': 500,
  'Bar-Phone': 100,
  'Battery': 50,
  'Blood-Pressure-Monitor': 150,
  'Boiler': 300,
  'CRT-Monitor': 400,
  'CRT-TV': 400,
  'Calculator': 80,
  'Camera': 200,
  'Ceiling-Fan': 250,
  'Christmas-Lights': 100,
  'Clothes-Iron': 120,
  'Coffee-Machine': 180,
  'Compact-Fluorescent-Lamps': 90,
  'Computer-Keyboard': 130,
  'Computer-Mouse': 90,
  'Cooled-Dispenser': 350,
  'Cooling-Display': 400,
  'Dehumidifier': 300,
  'Desktop-PC': 500,
  'Digital-Oscilloscope': 400,
  'Dishwasher': 350,
  'Drone': 250,
  'Electric-Bicycle': 600,
  'Electric-Guitar': 300,
  'Electrocardiograph-Machine': 500,
  'Electronic-Keyboard': 250,
  'Exhaust-Fan': 180,
  'Flashlight': 60,
  'Flat-Panel-Monitor': 300,
  'Flat-Panel-TV': 400,
  'Floor-Fan': 200,
  'Freezer': 500,
  'Glucose-Meter': 150,
  'HDD': 120,
  'Hair-Dryer': 100,
  'Headphone': 80,
  'LED-Bulb': 50,
  'Laptop': 600,
  'Microwave': 400,
  'Music-Player': 150,
  'Neon-Sign': 200,
  'Network-Switch': 250,
  'Non-Cooled-Dispenser': 300,
  'Oven': 350,
  'PCB': 100,
  'Patient-Monitoring-System': 500,
  'Photovoltaic-Panel': 450,
  'PlayStation-5': 700,
  'Power-Adapter': 90,
  'Printer': 250,
  'Projector': 350,
  'Pulse-Oximeter': 120,
  'Range-Hood': 200,
  'Refrigerator': 600,
  'Rotary-Mower': 350,
  'Router': 150,
  'SSD': 150,
  'Server': 700,
  'Smart-Watch': 200,
  'Smartphone': 500,
  'Smoke-Detector': 120,
  'Soldering-Iron': 150,
  'Speaker': 200,
  'Stove': 300,
  'Straight-Tube-Fluorescent-Lamp': 100,
  'Street-Lamp': 250,
  'TV-Remote-Control': 80,
  'Table-Lamp': 120,
  'Tablet': 400,
  'Telephone-Set': 150,
  'Toaster': 180,
  'Tumble-Dryer': 350,
  'USB-Flash-Drive': 60,
  'Vacuum-Cleaner': 300,
  'Washing-Machine': 600,
  'Xbox-Series-X': 700,
};

// Function to calculate total credits based on detected items and quantities
int calculateTotalCredits(Map<String, int> detectedItems) {
  int totalCredits = 0;
  
  detectedItems.forEach((item, quantity) {
    int itemCredits = ewasteCredits[item] ?? 0;
    totalCredits += itemCredits * quantity;
  });

  return totalCredits;
}
