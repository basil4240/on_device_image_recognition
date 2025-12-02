import 'package:equatable/equatable.dart';

class ClassificationResult extends Equatable {
  final String label;
  final double confidence;

  const ClassificationResult({required this.label, required this.confidence});

  @override
  List<Object?> get props => [label, confidence];
}
