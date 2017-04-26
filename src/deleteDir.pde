void deleteFile(String path){
  Table table = loadTable("folders.csv");
  int rows = table.getRowCount();
  for(int i=0; i<rows; i++){
    if(table.getString(i,0).equals(path)){
      table.removeRow(i);
      saveTable(table,"data\\folders.csv");
      break;
    }
  }
  String toDelete = dataPath(path);
  deleteDirectory(new File (toDelete));
  //println("delete ", path);
  println(deleteDirectory(new File (toDelete)));
}
    
  


public static boolean deleteDirectory(File directory) {
    if(directory.exists()){
        println("exists");
        File[] files = directory.listFiles();
        if(null!=files){
            println("innn");
            for(int i=0; i<files.length; i++) {  
                if(files[i].isDirectory()) {
                    deleteDirectory(files[i]);
                }
                else {
                    files[i].delete();
                }
            }
        }
    }
    return(directory.delete());
}