

class Post{

  String date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude;

  Post(){this.quantity = 0;}

  String toString(){
    return 'Date: $date, ImageURL: $imageURL, Quantity: $quantity, Latitude: $latitude, Longitude: $longitude';
  }


}