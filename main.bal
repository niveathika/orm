import ballerina/io;
import ballerina/sql;

public function main() returns error? {
    io:println("Hello, World!");

    User1 user = {
        id: -1,
        dob: {
            year: 1990,
            month: 9,
            day: 1
        },
        home: {
            number: "",
            street: "",
            city: "",
            zipcode: 0
        },
        office: {
            number: "",
            street: "",
            city: "",
            zipcode: 0
        }
    };

    QueryBuilder query = new ();
    query = query.'select("name", "age");

    Client1 db = new ();
    sql:ExecutionResult result = check db->insert(user);

    //stream<User1, error?> resultStream = db->query(condition = {id: 14});

}

