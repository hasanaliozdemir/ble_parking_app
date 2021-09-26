import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class ValidationService{

  emailValidation(String email){
    return EmailValidator.validate(email);
  }

  passwordValidaton(String password){
    if (password==null&& password == "") {
      return false;
    }else{
      if (password.length<8) {
      return false;
    }else{
      return true;
    }
    }
  }

  phoneValidator(String phone){
    if(phone.length != 13){
      return false;
    }else{
      return true;
    }
  }

  nameValidator(String name){
    if (name.length == null && name=="") {
      return false;
    }else{
      return true;
    }
  }

  String emailError(String email){
    if (email=="") {
      return "E-mail boş bırakılamaz";
    }else if(EmailValidator.validate(email)){
      return "Lütfen geçerli bir E-mail adresi girin.";
    }else{
      return "";
    }
  }

  String passwordError(String password){
    if (password=="") {
      return "Şifre boş bırakılamaz";
    }else if(password.length<8){
      return "Şifre 8 karakterden kısa olamaz";
    }else{
      return "";
    }
  }

  String phoneError(String phone){
    if (phone == "") {
      return "Telefon numarası boş bırakılamaz";
    }else if(phone.length != 13){
      return "Lütfen geçerli bir telefon numarası girin.";
    }else{
      return "";
    }
  }
  String nameError(String name){
    if (name =="") {
      return "Ad soyad kısmı boş bırakılamaz";
    }else{
      return "";
    }
  }

}