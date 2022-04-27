
import 'package:firebase_auth/firebase_auth.dart';
import '../models/direction_details_info.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAA1nV8Hw0:APA91bH0J7trIgocYmOkp7BZdwZFezCC-hHqNPZ5o-8arzND_T9RV7Vtoj9L1wwEPiOVITwoh-DdqWTn9tunuNlrT92ul1nbWvPmjoR0qBN9Yw1YJ2C5kf9G-fdu1SrEHveK6oRmwGxb";
String userDropOffAddress = "";
String driverCarDetails = "";
String driverPhone = "";
String driverName = "";
double countRatingStars = 0.0;
String titleStarsRating="";