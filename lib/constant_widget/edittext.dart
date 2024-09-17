import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/app_colors.dart';

class EditTextView extends StatefulWidget {
  EditTextView({
    required this.label,
    this.controller,
    this.errorLabel,
    this.focusNode,
    this.inputType,
    this.inputFormatter,
    this.editable,
    this.isSearch = false,
    this.maxLength = 100,
    this.minLine = 1,
    this.maxLine = 1,
    this.onClick,
    this.onChanged
  });


  FocusNode? focusNode =  FocusNode();
  TextInputType? inputType = TextInputType.text;

  bool? editable = true;
  bool isSearch = false;
  int maxLength = 100;
  int maxLine = 1;
  int minLine = 1;
  String? label, errorLabel;
  TextEditingController? controller;
  Function? onClick;
  Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatter;

  @override
  State<StatefulWidget> createState() {
    return EditTextViewState();
  }
}

class EditTextViewState extends State<EditTextView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
        child: Container(
          color: Colors.white,
          child: InkWell(
              child: TextFormField(
                onChanged: widget.onChanged,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) =>
                      (widget.maxLine == 1 || widget.minLine == 1)
                          ? FocusScope.of(context).nextFocus()
                          : FocusScope.of(context).unfocus(),
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 15,
                      // backgroundColor: Colors.white,
                      color: Colors.black),
                  maxLength: widget.maxLength * widget.maxLine,
                  minLines: widget.minLine,
                  maxLines: (widget.maxLine < widget.minLine)
                      ? widget.minLine
                      : widget.maxLine,
                  cursorColor: AppColors.green,
                  enabled: widget.editable,
                  inputFormatters: widget.inputType == TextInputType.phone
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ]
                      : widget.inputFormatter,
                  controller: widget.controller,
                  keyboardType: widget.inputType,
                  
                  decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: const TextStyle(
                          color: Colors.red, backgroundColor: Colors.white),
                      label: Container(
                        color: (widget.editable ?? true) ? null : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: (widget.editable ?? true) ? 0 : 0,
                              right: (widget.editable ?? true) ? 0 : 0),
                          child: RichText(
                              text: TextSpan(
                                  text: widget.errorLabel == null ? '' : '* ',
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                  children: [
                                TextSpan(
                                    text: widget.label,
                                    style: TextStyle(
                                      color: AppColors.hintTextColor,
                                    ))
                              ])),
                        ),
                      ),
                      isDense: true,
                      counterText: '',
                      errorBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.green, width: 1),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.green, width: 1),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.green, width: 1),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.green, width: 1),
                      ),
                      border: const OutlineInputBorder(
                        borderSide:  BorderSide(color: AppColors.green, width: 1),
                      ),
                      suffixIcon: widget.isSearch
                          ? const Icon(
                                  Icons.search,
                                  color: Colors.black38,
                                ):null
                              )),
              onTap: () {
                if (widget.editable == false) {
                  widget.onClick?.call();
                }
              }),
        ));
  }


}
