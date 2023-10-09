import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/models/note/note_model.dart';
import 'package:note_app/utils/date_time_utils.dart';

class NoteItem extends StatelessWidget {
  final NoteModel item;
  final VoidCallback onTap;

  const NoteItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(),
                const SizedBox(height: 6.0),
                _createDate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDate() {
    final createDate = DateTime.tryParse(item.createdAt ?? '');
    if (createDate != null) {
      final displayStr = DateTimeUtils().formatDate(createDate);
      return Text(
        displayStr,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: CupertinoColors.inactiveGray,
        ),
      );
    }
    return const SizedBox();
  }

  Text _title() {
    return Text(
      item.title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
