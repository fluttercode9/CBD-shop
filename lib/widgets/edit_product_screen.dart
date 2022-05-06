import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final myController = TextEditingController();
  String _imageUrl = ''; // final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
      price: null, id: null, title: null, description: null, imageUrl: null);
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestVal);
  }

  void _printLatestVal() {
    print(myController.text);
  }

  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _saveForm() {
    final _isValid = _form.currentState.validate();
    print(_isValid);
    if (!_isValid) {
      return;
    }

    _form.currentState.save();
    print(
        '${_editedProduct.description}${_editedProduct.imageUrl}${_editedProduct.price}${_editedProduct.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edytuj produkt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nazwa'),
                    textInputAction: TextInputAction.next,
                    onSaved: (val) {
                      print(val);
                      _editedProduct = _editedProduct.copyWith(title: val);
                    },
                    validator: (title) {
                      switch (title) {
                        case "":
                          {
                            return 'Wpisz nazwę produktu';
                          }
                          break;
                        default:
                          {
                            return null;
                          }
                      }
                    },
                    // onFieldSubmitted: (_){
                    // FocusScope.of(context).requestFocus(_priceFocusNode);
                    // },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cena '),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (val) {
                      _editedProduct =
                          _editedProduct.copyWith(price: double.parse(val));
                    },
                    validator: (price) {
                      if (price.isEmpty) {
                        return "Wpisz cenę";
                      }
                      if (double.tryParse(price) == null) {
                        return ' Wpisz prawidłową wartość ';
                      }
                      if (double.parse(price) <= 0) {
                        return 'Wpisz liczbe wieksza od zera';
                      } else
                        return null;
                    },
                    // focusNode: _priceFocusNode,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(labelText: 'Opis '),
                    keyboardType: TextInputType.multiline,
                    onSaved: (val) {
                      print(val);
                      _editedProduct =
                          _editedProduct.copyWith(description: val);
                      print(_editedProduct.description);
                    },
                    validator: (opis) {
                      if (opis.isEmpty) {
                        return 'Wpisz opis';
                      } else
                        return null;
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: _imageUrl.isEmpty
                              ? Text('Wpisz url obrazka')
                              : Image.network(_imageUrl),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            setState(() {
                              if (!_imageUrl.startsWith('http')) {
                                return 'Wpisz prawidlowy adres';
                              } else
                                _imageUrl = value;
                            });
                          },
                          validator: (url) {
                            if (!url.startsWith('http')) {
                              return 'Wpisz prawidlowy adres';
                            } else
                              return null;
                          },
                          onSaved: (val) {
                            _editedProduct =
                                _editedProduct.copyWith(imageUrl: val);
                          },
                        ),
                      ),
                    ],
                  ),
                  // TextField(
                  //   controller: myController,
                  //   onChanged: (str) {
                  //     setState(() {});
                  //   },
                  // ),
                  // Text(
                  //   myController.text,
                  // )
                ]),
              ),
              ElevatedButton(onPressed: _saveForm, child: Text("Zapisz"))
            ],
          ),
        ),
      ),
    );
  }
}
