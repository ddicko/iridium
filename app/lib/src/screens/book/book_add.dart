import 'package:app/src/models/book.dart';
import 'package:app/src/models/notifiers/book_notifier.dart';
import 'package:app/src/widgets/buttons/confirm_button.dart';
import 'package:app/src/widgets/inputs/book_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookAdd extends StatelessWidget {
  final Book book;

  const BookAdd({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book == null ? 'Add a book' : 'Update book'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: AddBookForm(book: book),
        ),
      ),
    );
  }
}

class AddBookForm extends StatefulWidget {
  final Book book;

  const AddBookForm({Key key, this.book}) : super(key: key);

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _author = '';
  var _description = '';
  var _rating = 0.0;
  var _coverUrl = '';
  var _category = '';

  @override
  void initState() {
    super.initState();
    _rating = widget.book?.rating ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    var bookNotifier = Provider.of<BookNotifier>(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          BookTextFormField(
            labelText: 'Title',
            errorText: 'Enter a book title',
            initialValue: widget.book?.title ?? "** title**",
            onSaved: (value) => _title = value ?? "** title**",
          ),
          BookTextFormField(
            labelText: 'Author',
            errorText: 'Enter an author',
            initialValue: widget.book?.author ?? "** author **",
            onSaved: (value) => _author = "** author **",
          ),
          BookTextFormField(
            labelText: 'Description',
            errorText: 'Enter a description',
            initialValue: widget.book?.description ?? "** description **",
            onSaved: (value) => _description = value ?? "** description **",
          ),
          BookTextFormField(
            labelText: 'Cover url',
            errorText: 'Enter a cover url',
            initialValue: widget.book?.coverUrl ?? "** coverUrl **",
            onSaved: (value) => _coverUrl = value ?? "** coverUrl **",
          ),
          BookTextFormField(
            labelText: 'Category',
            errorText: 'Enter a category',
            initialValue: widget.book?.category ?? "** category**",
            onSaved: (value) => _category = value ?? "** category **",
          ),
          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Rating',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: Chip(
                label: Text(_rating.toStringAsFixed(1)),
              ),
            ),
            child: Slider(
              value: _rating.roundToDouble(),
              min: 0.0,
              max: 10.0,
              divisions: 10,
              onChanged: (value) => setState(() => _rating = value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: ConfirmButton(
              text: widget.book == null ? 'Add Book' : 'Update Book',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState.save();
                  final book = Book(_title, _author, _description, _coverUrl,
                      _category, _rating);

                  if (widget.book == null) {
                    bookNotifier.addBook(book);
                    Navigator.pop(context);
                  } else {
                    bookNotifier.updateBook(widget.book, book);
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
