import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/providers/business/review_notifier.dart';


import '../../../utils/review_widget_helper.dart';

class ReviewDialog extends ConsumerStatefulWidget {
  const ReviewDialog(
      {super.key, this.isUpdate = false, this.title, this.text, this.rate});

  final bool isUpdate;
  final String? title;
  final String? text;
  final int? rate;

  @override
  ConsumerState<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends ConsumerState<ReviewDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showError = false;
  late String titleText;
  late String reviewText;
  late int selectedRate;

  @override
  void initState() {
    super.initState();
    titleText = widget.title ?? '';
    reviewText = widget.text ?? '';
    selectedRate = widget.rate ?? 0;
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate() && selectedRate != 0) {
      formKey.currentState!.save();

      try {
        !widget.isUpdate
            ? await ref
                .read(reviewStateNotifierProvider.notifier)
                .postReview(titleText, reviewText, selectedRate)
            : await ref
                .read(reviewStateNotifierProvider.notifier)
                .updateReview(titleText, reviewText, selectedRate);
                
        if (context.mounted) {
          CustomSnackBar.showSnackBar(
              context, widget.isUpdate ? "Review Updated" : "Review Upload");          
        }
        formKey.currentState!.reset();
      } catch (error) {
        if(context.mounted) CustomSnackBar.showSnackBar(context, error.toString());
      } finally {
        if(context.mounted) Navigator.of(context).pop();
      }
    } else {
      if (selectedRate == 0) {
        setState(() {
        showError = true;
      });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Rate:",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent),
                ),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ...List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () => setState(() => selectedRate = index + 1),
                      icon: const Icon(Icons.star, size: 30),
                      color: index < selectedRate
                          ? Colors.yellow
                          : Colors.grey[400],
                    ),
                  ),
                  if (showError)
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    )
                ]),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: titleText,
                  validator: ReviewWidgetHelper.validateTitle,
                  decoration: const InputDecoration(
                      hintText: 'Title', border: UnderlineInputBorder()),
                  onSaved: (newValue) => titleText = newValue!,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: reviewText,
                  validator: ReviewWidgetHelper.validateTitle,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Review here.',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (newValue) => reviewText = newValue!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: submitForm,
                    child: Text(widget.isUpdate == false ? 'Save' : 'Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
