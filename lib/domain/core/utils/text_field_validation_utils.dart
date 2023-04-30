import 'package:app/domain/core/errors/user_input/text_field_error.dart';
import 'package:app/domain/core/extensions/string_extensions.dart';

abstract class TextFieldValidationUtils {
  const TextFieldValidationUtils._();

  static TextFieldError? notBlank(String input) {
    if (input.isBlank) return const BlankTextFieldError();
    return null;
  }

  static TextFieldError? noValidation(String _) => null;
}