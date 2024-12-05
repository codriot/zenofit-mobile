import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices{
  late final GetStorage box= GetStorage();
  var isLoaded = false.obs;

  static StorageServices? _instance;
  static StorageServices get instance => _instance ?? StorageServices(); 

  Future<void> initLocaleDataBase() async { 
    await GetStorage.init();
    // StorageServices.instance.box = GetStorage();
    isLoaded.value = true;
  }

  Future<void> saveData<T>(StorageItems key,T value) async {
    await box.write(key.name, value);
  }

  T? loadData<T>(StorageItems key){
    return box.read(key.name);
  }

  Future<void> clearStorage() async {
    await box.erase();
  }

  Future<void> clearData(StorageItems key) async {
    if(box.hasData(key.name)){
      await box.remove(key.name); 
    }
  }
}


enum StorageItems{
  theme,user,lastSearchedItems,language,notificationSettings,isUserRegistered
}