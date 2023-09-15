

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';


final whatsAppProvider = Provider<WhatsAppApi>((ref) {
  return WhatsAppApi();
});

class WhatsAppApi {
  Future sendWhatsApp(String phoneNumber)
  async {
    String url = "whatsapp://send?$phoneNumber&text=Hello, Can i have more details?";    
    try 
    { 
      await launchUrl(Uri.parse(url));
    }
    catch (e)
    {
      throw Exception("No Whats app available");
      //throw Exception(e.toString());
    }
  }
}