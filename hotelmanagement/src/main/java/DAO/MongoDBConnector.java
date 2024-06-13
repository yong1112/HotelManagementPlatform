package DAO;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.*;



public class MongoDBConnector extends MongoDB{
    
    private MongoClient client;
    private MongoDatabase dbs;
    
    public MongoDBConnector() {

    }
    public MongoDatabase DBConnect() {
        
        MongoClientURI uri = new MongoClientURI("mongodb://"+dbuser+":"+dbpass+"@hotelmanagement-shard-00-00.dauiz.mongodb.net:27017,hotelmanagement-shard-00-01.dauiz.mongodb.net:27017,hotelmanagement-shard-00-02.dauiz.mongodb.net:27017/myFirstDatabase"+db+"?ssl=true&replicaSet=atlas-tqg492-shard-0&authSource=admin&retryWrites=true&w=majority");
        
        client = new MongoClient(uri);
        dbs = client.getDatabase(db);
        return dbs;
    
    }
}
