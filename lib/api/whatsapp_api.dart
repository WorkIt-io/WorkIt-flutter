

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

final whatsAppProvider = Provider<WhatsAppApi>((ref) {
  return WhatsAppApi();
});

class WhatsAppApi {
  Future sendWhatsApp(String phoneNumber)
  async {
    String url = "whatsapp://send?phone=$phoneNumber&text=Hello, Can i have more details?";
    bool canLaunch = await canLaunchUrlString(url);    
    if (canLaunch)
    { 
      await launchUrlString(url);
    }
    else
    {
      throw Exception("No Whats app available");
    }
  }
}