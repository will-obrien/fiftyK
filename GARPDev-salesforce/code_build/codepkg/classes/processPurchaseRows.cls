public class processPurchaseRows implements Database.Batchable<string>{
  
  public string fileString;
  private boolean isFirstChunk;
  public processPurchaseRows(string s, boolean isFChunk ) {
    fileString = s ;
    isFirstChunk = isFChunk ;
  }

  public Iterable<string> start(Database.BatchableContext ctx ){ 
    integer chunksize = 100 ;
    list< string > chunks = new list< string > () ;
    string chunk ;
    integer endIndex = 0 ;
    integer startIndex = 0 ;
    integer tempIndex ;
    fileString.indexof( '\n' );
    boolean isFirstChunk = TRUE ;
    while ( endIndex < fileString.length() ) {
      for( integer i=0; i < chunksize ; i++ ) {
        tempIndex = fileString.indexof( '\n', endIndex );
        if( tempIndex == -1 ) {
          endIndex = fileString.length() ;
          break ;
        } else
          endIndex = tempIndex + 1 ;
      }
      chunks.add( fileString.substring(startIndex, endIndex) ) ; 
      isFirstChunk = FALSE ;
      startIndex = endIndex++ ;
    }

            //Code to split string into chunks so we can return an iterable list of strings 
           //
    return chunks;
    }     
    
    public void execute(Database.BatchableContext ctx, List<string> scope){
              //process rows in scope
      for( string s : scope )
        migrationUtil.processPurchaseChunk( s, isFirstChunk) ; 
      isFirstChunk = FALSE ;
    }     
    public void finish(Database.BatchableContext ctx){     
    } 

//  To invoke processPeopleRows 
//  jobId = Database.executeBatch(new processPeopleRows( 'string'), 2);

}