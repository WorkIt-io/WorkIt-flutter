import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/whatsapp_api.dart';
import 'package:workit/common/loading_dialog.dart';

class WhatsAppButton extends ConsumerWidget {
  final String phoneNumber;

  const WhatsAppButton(this.phoneNumber, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () async {
            try {
              await ref.read(whatsAppProvider).sendWhatsApp(phoneNumber);
            } on Exception catch (e) {
              if (context.mounted) {
                startErrorDialog(context, title: 'Oh No', text: e.toString());
              }
            }
          },
        child: Container(          
          height: 60,
          margin:  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 110, 59, 228),
          ),       
          child: Row(            
            children: [
              const SizedBox(width: 10,),
              Image.asset(
                'assets/images/whatsapp.png',
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                height: 45,
                width: 45,
              ),
              const SizedBox(width: 20,),              
              const Text(
                'Contact via WhatsApp',
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
              ),              
            ],
          ),
        ),
      ),
    );
  }
}
