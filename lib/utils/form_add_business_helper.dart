

class FormAddBusinessHelper
{

  static String? validateName(String? name)
  {
    if(name == null || name.isEmpty || name.trim().length < 3)
    {
      return 'Enter a valid business name';
    }

    return null;
  }

  static String? validateAddress(String? address)
  {
    if (address == null || address.isEmpty || address.trim().length < 5)
    {
      return 'Enter a valid Address';
    }

    return null;
  }

  static String? validatePhone(String? phoneNumner)
  {
    if(phoneNumner == null || phoneNumner.isEmpty || phoneNumner.trim().replaceAll('-', '').length < 10)
    {
      return 'Enter a valid phone Number';
    }

    return null;
  }

  static String? validatePrice(String? price)
  {
    if(price == null || price.isEmpty || price.length < 2)
    {
      return 'Enter a valid Price';
    }

    return null;
  }

  static String? validateDescription(String? desc)
  {
    if(desc == null || desc.isEmpty || desc.trim().length < 5)
    {
      return 'Enter a valid Description';
    }

    return null;
  }    
}