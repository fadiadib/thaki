import 'package:thaki/globals/index.dart';

const String kInfoFieldTypeDelimiter = '.';
const String kDefaultInfoFieldTypeIdx = '1' + kInfoFieldTypeDelimiter + '0';

/// Info fields types enum
enum TkInfoFieldType {
  NationalId, // 0
  AlphaNum, // 1
  Double, // 2
  Password, // 3
  Email, // 4
  Phone, // 5
  Date, // 6
  Time, // 7
  DateTime, // 8
  Boolean, // 9
  Radio, // 10
  DropDown, // 11
  ConfirmPassword, // 12
  OTP,
}

/// Info fields subtype enum
enum TkInfoFieldSubType { String, Numeric }

class TkInfoFieldValueOption {
  TkInfoFieldValueOption({Map<String, dynamic> data}) {
    id = data[kIFValueId];
    title = data[kIFValueTitle];
  }

  String id;
  String title;
}

/// Info field class, holds a single info field: name, label,
/// required, value, visible, type, subtype and value options
class TkInfoField {
  String name;
  String label;
  bool required;
  dynamic value;
  bool visible;
  int numLines;
  TkInfoFieldType type;
  TkInfoFieldSubType subType;
  List<TkInfoFieldValueOption> valueOptions;

  TkInfoField.fromJson({Map<String, dynamic> data}) {
    name = data[kIFName]?.toString();
    label = data[kIFTitle]?.toString();
    required = data[kIFRequired] ?? false;
    value = data[kIFValue]?.toString();
    visible = data[kIFVisible] ?? true;
    numLines = 1;
    if (data[kIFLines] != null &&
        int.tryParse(data[kIFLines].toString()) != null)
      numLines = int.tryParse(data[kIFLines].toString());
    valueOptions = [];
    if (data[kIFValues] != null) {
      for (Map<String, dynamic> option in data[kIFValues]) {
        valueOptions.add(new TkInfoFieldValueOption(data: option));
      }
    }

    // Parse the info field type
    String infoFieldType = data[kIFType].toString() ?? kDefaultInfoFieldTypeIdx;
    List<String> infoFieldTypeList =
        infoFieldType.split(kInfoFieldTypeDelimiter);

    int first = infoFieldTypeList.length > 0
        ? int.tryParse(infoFieldTypeList[0].toString())
        : 1;
    type = first != null && first >= 0 && first < TkInfoFieldType.values.length
        ? TkInfoFieldType.values[first]
        : TkInfoFieldType.AlphaNum;

    int second = infoFieldTypeList.length > 1
        ? int.tryParse(infoFieldTypeList[1].toString())
        : 0;
    subType = second != null &&
            second >= 0 &&
            second < TkInfoFieldSubType.values.length
        ? TkInfoFieldSubType.values[second]
        : TkInfoFieldSubType.String;
  }
}

class TkInfoFieldsList {
  List<TkInfoField> _fields = [];
  List<TkInfoField> get fields => _fields;

  TkInfoFieldsList.fromJson({Map<String, dynamic> data}) {
    // Info fields
    _fields.clear();
    if (data[kInfoFieldsTag] != null) {
      for (Map<String, dynamic> infoFieldJson in data[kInfoFieldsTag])
        _fields.add(new TkInfoField.fromJson(data: infoFieldJson));
    }
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> infoFieldsJsonList = [];
    if (_fields != null && _fields.isNotEmpty) {
      for (TkInfoField field in _fields) {
        if (field.valueOptions != null && field.valueOptions.isNotEmpty) {
          field.value = field.valueOptions
              .firstWhere((item) => item.title == field.value)
              .id;
        }

        infoFieldsJsonList.add({
          kIFName: field.name,
          kIFValue: field.value,
        });
      }
    }

    return infoFieldsJsonList;
  }

  bool shouldRender() {
    if (_fields != null && _fields.isNotEmpty)
      for (TkInfoField field in _fields) if (field.visible) return true;

    return false;
  }
}
