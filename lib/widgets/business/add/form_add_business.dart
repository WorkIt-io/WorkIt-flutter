import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/constant/categories.dart';
import 'package:workit/controller/user_controller.dart';
import 'package:workit/models/business.dart';
import 'package:workit/providers/business/businesses_notifier.dart';
import 'package:workit/utils/form_add_business_helper.dart';
import 'package:workit/widgets/business/add/text_field_add_business.dart';

class FormAddBusiness extends ConsumerStatefulWidget {
  const FormAddBusiness(this.doScroll, {super.key});

  final Function doScroll; 

  @override
  ConsumerState<FormAddBusiness> createState() {
    return _FormAddBusinessState();
  }
}

class _FormAddBusinessState extends ConsumerState<FormAddBusiness> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? _selectedCategory;
  LatLng? _location;
  double _price = 0;
  String _name = '';
  String _phoneNumber = '';
  String _description = '';
  String _address = '';

  TextEditingController addressController = TextEditingController();
  
  AutovalidateMode autoValidate = AutovalidateMode.disabled;


  Future<void> onSave() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (_location == null) {
        CustomSnackBar.showSnackBar(context, "No Location");
        return;
      }

      showDialog(
        context: context,
        barrierColor: Colors.white70,
        builder: (context) => const Center(
          widthFactor: 100,
          heightFactor: 100,
          child: CircularProgressIndicator(),
        ),
      );

      final businessId = const Uuid().v4(); // maybe later change to user.id for have 1 business to 1 user.

      final business = BusinessModel(
          id: businessId,
          name: _name,
          phoneNumber: _phoneNumber,
          price: _price,
          description: _description,
          rate: 0,
          location: _location!,
          category: _selectedCategory!,
          address: _address);

      try {
        await ref
            .read(businessesStateNotifierProvider.notifier)
            .addBusiness(business);

        await ref.read(userControllerProvider).updateUser({"businessId": businessId, 'role': 'Admin'});

        if (mounted) Navigator.pop(context);
        if (mounted) CustomSnackBar.showSnackBar(context, "Business Upload");
        formkey.currentState!.reset();
      } catch (e) {
        if (mounted) {
          Navigator.pop(context);
          CustomSnackBar.showSnackBar(context, e.toString());
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
                hintText: "Business Name:",                
                type: TextInputType.text,
                validate: FormAddBusinessHelper.validateName,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _phoneNumber = value!,
                hintText: "Phone Number:",
                type: TextInputType.phone,
                validate: FormAddBusinessHelper.validatePhone,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _address = value!,
                controller: addressController,
                getlocation: (location) => _location = location,
                hintText: "Address:",
                onScroll: widget.doScroll,
                type: TextInputType.streetAddress,
                validate: FormAddBusinessHelper.validateAddress,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFieldAddBussines(
                      onSave: (value) => _price = double.parse(value!),
                      hintText: 'Price:',
                      type: TextInputType.number,
                      validate: FormAddBusinessHelper.validatePrice),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, right: 10),
                    child: CategoryPicker(
                      onSave: (category) => _selectedCategory = category,
                    ),
                  ),
                )
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              child: TextFieldAddBussines(
                onSave: (value) => _description = value!,
                hintText: 'Description:',
                type: TextInputType.multiline,
                validate: FormAddBusinessHelper.validateDescription,
                onScroll: widget.doScroll,
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
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      style: const TextStyle(fontSize: 18, color: Colors.black87),
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black87),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isValid ? Colors.green : Colors.white, width: 2)),
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
      onChanged: (String? value) {
        if (value == null) {
          setState(() {
            isValid = false;
            _selectedCategory = value;
          });
        } else {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            isValid = true;
            _selectedCategory = value;
          });
        }
      },
      onSaved: widget.onSave,
      validator: (value) => value == null ? 'Select' : null,
      items: businessCategories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
