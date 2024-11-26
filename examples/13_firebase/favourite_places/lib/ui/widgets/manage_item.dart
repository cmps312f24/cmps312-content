import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/ui/screens/edit_place.dart';
import 'package:favourite_places/utils/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageItem extends ConsumerStatefulWidget {
  const ManageItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ManageItemState();
  }
}

class _ManageItemState extends ConsumerState<ManageItem> {
  bool _isDeleting = false;

  Future<void> _removePlace() async {
    setState(() {
      _isDeleting = true;
    });

    await ref
        .read(userPlacesProvider.notifier)
        .removePlace(widget.place.id, context);

    setState(() {
      _isDeleting = false;
    });

    ErrorHandler.showMessage(context, 'Place Removed Successfully.');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ExpansionTile(
        key: Key(widget.place.id),
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.surface,
        iconColor: Theme.of(context).colorScheme.surface,
        childrenPadding: const EdgeInsets.all(
          12,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.place.image),
        ),
        title: Text(
          widget.place.placeName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
        children: [
          Column(
            children: [
              Text(
                widget.place.location.address,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPlace(place: widget.place),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    label: const Text('Edit'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  TextButton.icon(
                    onPressed: _isDeleting ? null : _removePlace,
                    icon: _isDeleting
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.delete),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    label: _isDeleting ? const Text('') : const Text('Delete'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
