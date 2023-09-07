
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:workit/widgets/business/add/form_add_business.dart';
import 'package:workit/widgets/community/add/form_add_community.dart';




class AddBusinessScreen extends ConsumerStatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  ConsumerState<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends ConsumerState<AddBusinessScreen> {
  bool isBusinessForm = true;

  void changeForm() {
    setState(() => isBusinessForm = !isBusinessForm);
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    
    super.dispose();
    _scrollController.dispose();    
  }

   void doScroll()
  {
    
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {

    //var theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Your Business"),
          backgroundColor: Colors.blueGrey[500],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(   
          controller: _scrollController,       
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(
                "Welcome To Work-It",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.blue.withOpacity(0.9),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Start Your Business Today",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                ),
              ),
              Lottie.asset('assets/images/animation/business_animation.json',
                  height: 250, width: double.infinity),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.grey[200]!,
                            Colors.blue.withOpacity(0.9),
                            Colors.grey[200]!
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Column(
                      children: [
                        const Text(
                          "Join over 1000+ businesses",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ).animate().moveX(
                            duration: const Duration(seconds: 1),
                            begin: -70,
                            end: 0),
                        const SizedBox(height: 20),
                        const Text(
                          "Expose yourself to 1M+ users",
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ).animate().moveX(
                            duration: const Duration(seconds: 1),
                            begin: MediaQuery.of(context).size.width + 70,
                            end: 0),                        
                      ],
                    ),
                  ),
                ],
              ),              
              Animate(effects: const [FadeEffect(duration: Duration(seconds: 4))] ,child: Lottie.asset('assets/images/animation/down_arrow_animation.json', height: 120, width: double.infinity)),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(                
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Get Started:",
                      style: TextStyle(fontSize: 30),
                    ),
                    TextButton(
                        onPressed: changeForm,
                        child: Text(
                          isBusinessForm ? "Change To Community" : "Change To Business",
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (isBusinessForm) FormAddBusiness(doScroll),
              if (!isBusinessForm) FormAddCommunity(doScroll),
            ],
          ),
        ));
  }
}
