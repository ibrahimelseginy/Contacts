import 'package:contacts/data_class_contact.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatefulWidget {
  const ContactCard(
      {super.key,
      required this.contact,
      required this.onDelete,
      required this.index});
  final Contact contact;
  final Function(int) onDelete;
  final int index;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainSize: true,
      maintainState: true,
      visible: widget.contact.visibility,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(30),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showMore = !showMore;
                      setState(() {});
                    },
                  ),
                  Text(
                    'Name: ${widget.contact.name}',
                    maxLines: showMore == false ? 1 : null,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Phone:${widget.contact.phone} ',
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  widget.onDelete(widget.index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
