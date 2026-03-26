import 'dart:io';
import '../entities/try_on_entity.dart';

abstract class TryRepository {
  Future<TryOnEntity> processTryOn(File image);
}
