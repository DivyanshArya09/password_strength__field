import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password_strength__field/strenght_validator.dart';
import 'package:password_strength__field/text_field_enums.dart';

enum BorderType {
  underline,
  filled,
}

class CustomTextField extends StatefulWidget {
  final String? errorText;
  final FocusNode? nextFocus;
  final TextStyle? inputStyle;
  final bool enableBorder;
  final TextEditingController controller;
  final double? height;
  final Color? titleColor;
  final bool? readOnly;
  final double? borderRadius;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final BorderType? borderType;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool? isPasswordField;
  final String? hint;
  final String? label;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final bool disabled;
  final Color? fillColor;
  final EdgeInsets? scrollPadding;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onSubmitted;
  final String? title;
  final String? prefixText;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Function(PasswordValidationStatus?)? onPasswordChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    this.validator,
    this.focusNode,
    this.inputStyle,
    this.prefix,
    this.onPasswordChanged,
    this.isPasswordField = false,
    this.nextFocus,
    this.suffix,
    this.readOnly,
    this.borderColor,
    this.textInputAction,
    this.maxLength,
    this.keyboardType,
    this.borderType = BorderType.filled,
    this.hint,
    this.label,
    this.maxLines,
    this.minLines,
    this.height = 50,
    this.borderRadius = 20,
    this.errorText,
    this.onTap,
    this.onChanged,
    this.autoFocus = false,
    this.disabled = false,
    this.fillColor = Colors.white,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding,
    this.onSubmitted,
    this.titleColor = Colors.black,
    this.title,
    this.prefixText,
    this.prefixIcon,
    this.enableBorder = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late StreamController<bool> _obscureTextController;
  late StreamController<PasswordValidationStatus> _passwordStrengthController;

  @override
  void initState() {
    _obscureTextController = StreamController<bool>.broadcast();
    _passwordStrengthController =
        StreamController<PasswordValidationStatus>.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    _obscureTextController.close();
    _passwordStrengthController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPasswordField! && widget.validator != null) {
      throw ArgumentError(
          'isPasswordField can\'t be true if validator is not null because the password strength indicator will not work properly ');
    }
    return widget.isPasswordField! ? _buildPasswordField() : _buildTextField();
  }

  Widget _buildPasswordField() {
    return StreamBuilder<bool>(
      stream: _obscureTextController.stream,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(obscureText: snapshot.data ?? false),
            const SizedBox(
              height: 10,
            ),
            _buildPasswordStrengthIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return StreamBuilder<PasswordValidationStatus>(
      stream: _passwordStrengthController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && widget.controller.text.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 5,
                    width: MediaQuery.of(context).size.width * .35,
                    child: LinearProgressIndicator(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: snapshot.data!.score,
                      color: snapshot.data!.color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    snapshot.data!.value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: snapshot.data!.color,
                        ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                height: 22,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      snapshot.data!.icon,
                      const SizedBox(width: 5),
                      Text(
                        snapshot.data!.message,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: snapshot.data ==
                                      PasswordValidationStatus.MEDIUM
                                  ? Colors.purple
                                  : snapshot.data!.color,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTextField({bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(widget.title!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: widget.titleColor)),
          const SizedBox(
            height: 10,
          ),
        ],
        InkWell(
          onTap: widget.onTap,
          child: TextFormField(
            style: widget.inputStyle,
            controller: widget.controller,
            obscuringCharacter: '*',
            obscureText: obscureText,
            validator: widget.validator,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) {
              return null;
            },
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly ?? false,
            maxLines: widget.isPasswordField! ? 1 : widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            onChanged: (value) {
              if (widget.isPasswordField!) {
                var status = Validators.checkStrength(value);
                widget.onPasswordChanged!(status);
                _passwordStrengthController.sink.add(status);
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onFieldSubmitted: (val) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(val);
              }
              if (widget.nextFocus == null) {
                widget.focusNode?.unfocus();
              } else {
                print(
                    '===========Requesting for focus========================');
                widget.nextFocus?.requestFocus();
              }
            },
            textCapitalization: widget.textCapitalization,
            scrollPadding: widget.scrollPadding ?? EdgeInsets.zero,
            autofocus: widget.autoFocus,
            enabled: !widget.disabled,
            decoration: InputDecoration(
              contentPadding: widget.borderType! == BorderType.underline
                  ? const EdgeInsets.symmetric(horizontal: 0)
                  : null,
              border: widget.borderType! == BorderType.underline
                  ? _buildUnderLineBorder()
                  : null,
              disabledBorder: widget.borderType! == BorderType.underline
                  ? _buildUnderLineBorder()
                  : null,
              enabledBorder: widget.borderType! == BorderType.underline
                  ? _buildUnderLineBorder()
                  : null,
              focusedBorder: widget.borderType! == BorderType.underline
                  ? _buildUnderLineBorder(
                      color: Colors.purple,
                    )
                  : null,
              prefixIcon:
                  widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              fillColor: widget.borderType! == BorderType.underline
                  ? Colors.transparent
                  : null,
              prefixText: widget.prefixText,
              labelText: widget.label,
              hintText: widget.hint,
              errorText: widget.errorText,
              suffixIcon: widget.isPasswordField!
                  ? _buildPassWordSuffix(obscureText)
                  : widget.suffix,
              errorStyle: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  _buildUnderLineBorder({Color? color = Colors.grey}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color!,
      ),
    );
  }

  Widget _buildPassWordSuffix(bool obscureText) {
    return GestureDetector(
      onTap: () {
        _obscureTextController.sink.add(!obscureText);
      },
      child: Icon(
        obscureText ? Icons.remove_red_eye : Icons.visibility_off,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}
