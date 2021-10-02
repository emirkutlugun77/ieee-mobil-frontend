import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:my_app/Functions/auth_functions.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart';

class NewRegister extends StatefulWidget {
  NewRegister({
    Key? key,
  }) : super(key: key);

  @override
  _NewRegisterState createState() => _NewRegisterState();
}

String name = 'name';
String phone = 'phone';
String email = '';
int serialNumber = 0;
int receiptNumber = 0;
DateTime birthDate = new DateTime(2001);
String department = '';
String field = '';
TextEditingController c1 = TextEditingController();
TextEditingController c2 = TextEditingController();
TextEditingController c3 = TextEditingController();
TextEditingController c4 = TextEditingController();
TextEditingController c5 = TextEditingController();
TextEditingController c6 = TextEditingController();
TextEditingController c7 = TextEditingController();

class _NewRegisterState extends State<NewRegister> {
  PanelController _panelController = PanelController();
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      birthDate = args.value;
    });
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Kayıt'),
      ),
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.all(width / 30),
            children: [
              Text('Genel',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: width / 15)),
              SizedBox(
                height: height / 30,
              ),
              serialNumberBox(context),
              SizedBox(
                height: height / 30,
              ),
              TextField(
                controller: c7,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    receiptNumber = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyText1,
                  hintText: 'Makbuz Numarası',
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: MediaQuery.of(context).size.width / 25),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              nameBox(context),
              SizedBox(
                height: height / 30,
              ),
              emailBox(context),
              SizedBox(
                height: height / 30,
              ),
              phoneBox(context),
              SizedBox(
                height: height / 30,
              ),
              Text('Doğum Tarihi',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: width / 25,
                      color: Theme.of(context).primaryColor)),
              SfDateRangePicker(
                startRangeSelectionColor:
                    Theme.of(context).textTheme.bodyText1!.color,
                minDate: DateTime(1990),
                maxDate: DateTime(2006),
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
              ),
              SizedBox(
                height: height / 30,
              ),
              Text('Eğitim',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: width / 15)),
              SizedBox(
                height: height / 30,
              ),
              uniBox(context),
              SizedBox(
                height: height / 30,
              ),
              fieldPicker(context),
              SizedBox(
                height: height / 60,
              ),
              SizedBox(
                height: height / 120,
              ),
              checkbox(width, context),
              SizedBox(
                height: height / 120,
              ),
              kvkk(context, width),
              registerButton(width, height, context),
              SizedBox(
                height: height / 60,
              ),
            ],
          )),
    );
  }

  TextField emailBox(BuildContext context) {
    return TextField(
      controller: c1,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'E-mail',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  TextField serialNumberBox(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: c2,
      onChanged: (value) {
        setState(() {
          serialNumber = int.parse(value);
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Seri Numarası',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  Padding registerButton(double width, double height, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width / 30),
      child: GestureDetector(
        onTap: () async {
          if (phone.length == 10) {
            var statusCode = await registerUserToClub(
                serialNumber,
                name,
                birthDate,
                email,
                field,
                department,
                phone.toString(),
                isChecked,
                receiptNumber);

            if (statusCode == 200) {
              setState(() {
                phone = '';
                name = '';
                email = '';
                field = '';
                department = '';
                serialNumber = 0;
                receiptNumber = 0;
                isChecked = false;
              });
              c1.clear();
              c2.clear();
              c3.clear();
              c4.clear();
              c5.clear();
              c6.clear();
              c7.clear();
              Get.snackbar('', '',
                  titleText: Center(
                    child: Text('Kayıt Başarılı',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontSize: width / 20)),
                  ),
                  padding: EdgeInsets.all(width / 20),
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.BOTTOM);
            } else {
              Get.snackbar('', '',
                  titleText: Center(
                    child: Text('Kayıt Başarısız',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white, fontSize: width / 20)),
                  ),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Theme.of(context).errorColor);
            }
          } else {
            Get.snackbar('', '',
                titleText: Center(
                  child: Text('Yanlış Telefon Numarası',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: Colors.white, fontSize: width / 20)),
                ),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Theme.of(context).errorColor);
          }
        },
        child: Container(
            height: height / 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 20),
                color: Theme.of(context).primaryColorDark),
            child: Center(
              child: Text('Kaydı Tamamla!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: width / 25)),
            )),
      ),
    );
  }

  Column kvkk(BuildContext context, double width) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kaydı Tamamla! butonuna basarak ',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: width / 30,
                  ),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      if (Platform.isIOS) {
                        return CupertinoAlertDialog(
                          content: Text(
                              'Yukarıda verdiğim bilgilerin doğruluğunu taahhğt ediyorum. Üye olduğum kulübün tüzüğünnü okudum ve üyelik ile ilgili gerekli sorumlulukları almayı kabul ediyorum'),
                        );
                      } else {
                        return AlertDialog(
                          content: Text(
                              'Yukarıda verdiğim bilgilerin doğruluğunu taahhğt ediyorum. Üye olduğum kulübün tüzüğünnü okudum ve üyelik ile ilgili gerekli sorumlulukları almayı kabul ediyorum'),
                        );
                      }
                    });
              },
              child: Text(
                'ŞARTLARI',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: width / 30,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Text(
          'kabul etmiş olursunuz',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: width / 30,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row checkbox(double width, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GFCheckbox(
          size: GFSize.SMALL,
          activeBgColor: GFColors.SUCCESS,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          },
          value: isChecked,
        ),
        SizedBox(width: width / 40),
        Text('E-mail ile bilgilendirilmek istiyorum',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w200, fontSize: width / 30))
      ],
    );
  }

  TextField fieldPicker(BuildContext context) {
    return TextField(
      controller: c3,
      onChanged: (value) {
        setState(() {
          field = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Bölüm',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  TextField uniBox(BuildContext context) {
    return TextField(
      controller: c4,
      onChanged: (value) {
        setState(() {
          department = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Fakülte',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  GestureDetector pickCountry(
    context,
    double height,
    double width,
    List listForCountry,
  ) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: height / 3,
                  child: CupertinoPicker(
                    selectionOverlay: Container(
                      color: Colors.transparent,
                    ),
                    onSelectedItemChanged: (value) {
                      setState(() {});
                    },
                    itemExtent: 50.0,
                    children: listForCountry.map((e) => Text(e)).toList(),
                  ),
                );
              });
        },
        child: Container(
          width: width,
          height: height / 17,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5)),
        ));
  }

  TextField phoneBox(BuildContext context) {
    return TextField(
      controller: c5,
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        setState(() {
          phone = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Telefon Numarası',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }

  TextField nameBox(BuildContext context) {
    return TextField(
      controller: c6,
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodyText1,
        hintText: 'Ad Soyad',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        labelStyle: Theme.of(context).textTheme.headline2!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.width / 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
