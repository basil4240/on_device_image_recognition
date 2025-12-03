import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'cataloged_item.g.dart';

@HiveType(typeId: 0)
class CatalogedItem extends Equatable {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String tag;

  @HiveField(2)
  final String? notes;

  @HiveField(3)
  final DateTime timestamp;

  const CatalogedItem({
    required this.imagePath,
    required this.tag,
    this.notes,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [imagePath, tag, notes, timestamp];
}
