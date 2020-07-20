// Total no of farms
final int noOfFarms = 5;

// Data for Wind Speed
List<List<String>> dateTime = new List.generate(noOfFarms, (i) => []);
List<List<String>> values = new List.generate(noOfFarms, (i) => []);
bool isLoaded = false;

// Data for Prediction API
List<List<String>> dateTimePrediction = new List.generate(noOfFarms, (i) => []);
List<List<String>> valuesPrediction = new List.generate(noOfFarms, (i) => []);
bool isLoadedPrediction = false;

// Farm Weather Table data
List<String> key = [];
List<String> value = [];

// Best Time Table data
List<String> keyForAllGraphTable = [];
List<String> valueForAllGraphTable = [];
