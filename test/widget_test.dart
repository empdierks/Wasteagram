
import 'package:flutter_test/flutter_test.dart';
import '../lib/models/post.dart';

void main() {
  group('Post Model', (){
    test('Quantity should start at 0', () {
      expect(Post().quantity, 0);
    });
    test('Values Added by Direct Insertion', (){
      String day ='Monday, Feb 4';
      String url = 'http://image.com';
      int quant = 5;
      double lat = 25.7617;
      double long = 80.1918;

      final post = Post();
      post.date = day;
      post.imageURL = url;
      post.quantity = quant;
      post.latitude = lat;
      post.longitude = long;

      expect(post.date, day);
      expect(post.imageURL, url);
      expect(post.quantity, quant);
      expect(post.latitude, lat);
      expect(post.longitude, long);

    });
  });
}
