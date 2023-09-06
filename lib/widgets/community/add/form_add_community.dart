import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/common/loading_dialog.dart';
import 'package:workit/constant/business_category.dart';
import 'package:workit/controller/user_controller.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/community/communities_notifier.dart';
import 'package:workit/utils/form_add_business_helper.dart';
import 'package:workit/widgets/business/add/text_field_add_business.dart';

class FormAddCommunity extends ConsumerStatefulWidget {
  const FormAddCommunity(this.doScroll, {super.key});

  final Function doScroll;

  @override
  ConsumerState<FormAddCommunity> createState() {
    return _FormAddCommunityState();
  }
}

class _FormAddCommunityState extends ConsumerState<FormAddCommunity> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? _selectedCategory;
  LatLng? _location;
  String _name = '';
  String _description = '';
  String _address = '';

  TextEditingController addressController = TextEditingController();

  bool isReverse = false;
  AutovalidateMode autoValidate = AutovalidateMode.disabled;


  Future<void> onSave() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (_location == null) {
        CustomSnackBar.showSnackBar(context, "No Location");
        return;
      }

      startLoadingDialog(context);

      final communityId = const Uuid()
          .v4(); // maybe later change to user.id for have 1 business to 1 user.

      final Community community = Community(
          id: communityId,
          name: _name,
          description: _description,
          location: _location!,
          category: _selectedCategory!,
          address: _address);

      try {
        // send Community data.
        await ref.read(communityStateNotifierProvider.notifier).addCommunity(community);

        await ref
            .read(userControllerProvider)
            .updateUser({"communityId": communityId, 'role': 'Admin'});

        if (mounted) Navigator.pop(context); // remove loading screen
        if (mounted) CustomSnackBar.showSnackBar(context, "Community Upload");
        formkey.currentState!.reset();
      } catch (e) {
        if (mounted) {
          Navigator.pop(context); // remove loading screen
          startErrorDialog(context, title: 'Oh No', text: e.toString());
        }
      }
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formkey,
        autovalidateMode: autoValidate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _name = value!,
                hintText: "Community Name:",
                type: TextInputType.text,
                validate: FormAddBusinessHelper.validateName,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _address = value!,
                controller: addressController,
                getlocation: (location) => _location = location,
                hintText: "Address:",
                type: TextInputType.streetAddress,
                onScroll: widget.doScroll,
                validate: FormAddBusinessHelper.validateAddress,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, right: 10, left: 10),
              child: CategoryPicker(
                onSave: (category) => _selectedCategory = category,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _description = value!,
                hintText: 'Description:',
                type: TextInputType.multiline,
                onScroll: widget.doScroll,
                validate: FormAddBusinessHelper.validateDescription,
                lines: 7,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.blueGrey[400],
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    label: Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 22, color: Colors.blueGrey[400]),
                    )),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt),
                  onPressed: () async => await onSave(),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(140, 50)),
                  label: const Text(
                    "Save",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key, required this.onSave});

  final void Function(String? category) onSave;

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: _selectedCategory == null
          ? const TextStyle(fontSize: 18, color: Colors.black87)
          : const TextStyle(
              fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black87),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        prefixIcon: const Icon(Icons.category),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      hint: const Text(
        "Select",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      value: _selectedCategory,
      isExpanded: true,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
      onSaved: widget.onSave,
      validator: (value) => value == null ? "Select" : null,
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
