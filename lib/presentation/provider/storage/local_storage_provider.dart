import 'package:cinepolis/infrastructure/datasources/isar_datasource.dart';
import 'package:cinepolis/infrastructure/repositories/local_storage_repository_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider =Provider((ref){
  return LocalStorageRepositoryImpl(IsarDatasource());
  
});