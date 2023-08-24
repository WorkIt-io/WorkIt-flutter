import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:workit/controller/location_controller.dart';

class TextFieldAddBussines extends ConsumerStatefulWidget {
  const TextFieldAddBussines(
      {Key? key,
      this.controller,
      this.getlocation,
      this.lines,
      required this.changeReverse,
      required this.onSave,
      required this.hintText,
      required this.type,
      required this.validate})
      : super(key: key);

  final TextEditingController? controller;
  final int? lines;

  final void Function(String? value) onSave;
  final TextInputType type;
  final String hintText;
  final String? Function(String? param) validate;
  final Function(bool param) changeReverse;
  final Function(LatLng location)? getlocation;

  @override
  ConsumerState<TextFieldAddBussines> createState() =>
      _TextFiledAddBussinesState();
}

class _TextFiledAddBussinesState extends ConsumerState<TextFieldAddBussines> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  String? sessionToken;
  List predictions = [];
  bool isValid = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller != null) {
      widget.controller!.dispose();
    }
    super.dispose();
  }

  getAutoComplete(String input) async {
    sessionToken ??= const Uuid().v4();
    predictions = [];
    
    predictions = await ref
        .read(locationControllerProvider)
        .getAutoCompletePlaces(input, sessionToken!, 'il');

    setState(() => isValid = false);
  }

  void clearPredictions() {
    setState(() {
      predictions = [];
    });
  }

  Future<void> selectPlace(String placeId) async {
    final result =
        await ref.read(locationControllerProvider).selectPlaceFromAuto(placeId);
    widget.controller!.text = result['formatted_address'];
    widget.getlocation!(LatLng(result['geometry']['location']['lat'],
        result['geometry']['location']['lng']));

    clearPredictions();
    _focusNode.unfocus();
    sessionToken = null;
    setState(() {
      isValid = true;
    });
  }

  onChange(String value) {
    if (widget.type == TextInputType.streetAddress) // only for address
    {
      if (_timer?.isActive ?? false) _timer!.cancel();
      _timer = Timer(const Duration(milliseconds: 800), () {
        if (value.isNotEmpty) {
          getAutoComplete(value);
        } else {
          clearPredictions();
        }        
      });
    } else {
      // all the others Text Fields
      if (widget.validate(value) == null) {
        setState(() => isValid = true);
      } else {
        if (isValid) {
          setState(() => isValid = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: TextStyle(
                fontSize: 24,
                color: _isFocused
                    ? Colors.blueGrey
                    : Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          TextFormField(            
            controller: widget.controller,
            style: const TextStyle(fontSize: 18),
            maxLines: widget.lines ?? 1,
            focusNode: _focusNode,            
            onTap: () => widget.changeReverse(
                widget.type == TextInputType.streetAddress ||
                    widget.type == TextInputType.multiline),
            onChanged: onChange,
            decoration: InputDecoration(
              suffixIcon: isValid
                  ? const Icon(Icons.check_circle_outline, color: Colors.green)
                  : null,
              enabledBorder:  OutlineInputBorder(
                  borderSide: BorderSide(color: isValid ? Colors.green :Colors.white, width: 2)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 2)),
              hintText: widget.hintText,
            ),
            keyboardType: widget.type,
            validator: widget.validate,
            onSaved: widget.onSave,
          ),
          if (widget.type == TextInputType.streetAddress &&
              predictions.isNotEmpty && _isFocused)
            ListView.builder(
              shrinkWrap: true,
              itemCount: predictions.length,
              itemBuilder: (context, index) => InkWell(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.pin_drop_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(predictions[index]['description']),
                ),
                onTap: () async =>
                    await selectPlace(predictions[index]['place_id']),
              ),
            ),
        ],
      ),
    );
  }
}
