
class CloudStorageException implements Exception{
  //instance of class
  const CloudStorageException();
}

//inherit, C-R-U-D
class CouldNotCreateNoteException extends CloudStorageException{}

class CouldNotGetAllNotesException extends CloudStorageException{}

class CouldNotUpdateNoteException extends CloudStorageException{}

class CouldNotDeleteNoteException extends CloudStorageException{}