import ballerina/io;
import ballerina/sql;


type Table record {|
    @PrimaryKey
    @Column {
        isUnique: true, // do we need a unique index for auto incremnet?
        autoIncrement: true
    }
    int id = 1;

    // time:Utc created_at;
    // time:Utc modified_at;

    // This is used for soft delete functionality. To preserve data in order to recover if needed
    // time:Utc? deleted_at;
    
|};




type Address record {|
    string? number;
    string? street;
    string? city;
|};

type User record {|
    *Table;
    
    string name;
    @Column {
        name: "name_test",
        isUnique: true,
        autoIncrement: false
    }
    sql:VarcharValue username;

    // @Index {
    //     id: "index1",
    //     order: ASEC
    // }
    int age;

    // @Index {
    //     id: "index1",
    //     order: ASEC
    // }
    @Embed {
        prefix: "home_"
    }
    Address homeAddress;
    @Embed
    Address officeAddress;
|};


//todo Check if we can incoporate size and precision data in the type itself? size->varchar, precision and scale->decimal
//todo index -> need a sub record, composite index, composite index priority

// Composition is tested by seeing if the type is inherited from Table record or does not have a primary key annotation
// Todo indicate struct? field in Column annotation type field -> VARCHAR (255) / STRUCT / DECIMAL (10, 2)


public function main() {
    io:println("Hello, World!");

    User user = {
        name: "Alice",
        age: 100, 
        username: new ("Alice100"),
        homeAddress: {
            number: (),
            street: (),
            city: ()
        },
        officeAddress: {
            number: (),
            street: (),
            city: ()
        }
    };

    io:println(user);

    sql:DecimalValue decimalVal = new();


    QueryBuilder query = new();
    query = query.'select("name", "age");


}




