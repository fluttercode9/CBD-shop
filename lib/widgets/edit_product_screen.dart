import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/products_overwiew_screen.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final myController = TextEditingController();
  String _imageUrl = ''; // final _priceFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  Product _passedProd = null;
  Product _editedProduct = Product(
      price: null,
      id: DateTime.now().toString(),
      title: null,
      description: null,
      imageUrl: null);
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestVal);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _passedProd = ModalRoute.of(context).settings.arguments as Product;
      if (_passedProd != null) {
        _editedProduct = _passedProd;
        _imageUrl = _editedProduct.imageUrl;
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
    if (_passedProd != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pushReplacementNamed(UserProductsScreen.route);
    
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
                    initialValue: _editedProduct.title,
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
                    initialValue: _editedProduct.price == null
                        ? ""
                        : _editedProduct.price.toString(),
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
                    initialValue: _editedProduct.description,
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
                          initialValue: _editedProduct.imageUrl,
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            setState(() {
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
