enum PropertyTypes {
  stringSingle,
  StringMulti,
  integer,
  list,
  listDropdown,
}

extension PropertyTypeEnumExt on PropertyTypes {
  get value {
    switch (this) {
      case PropertyTypes.stringSingle:
        return 'string_single';
      case PropertyTypes.StringMulti:
        return 'string_multi';
      case PropertyTypes.integer:
        return 'integer';
      case PropertyTypes.list:
        return 'list';
      case PropertyTypes.listDropdown:
        return 'list_dropdown';
    }
  }
}
