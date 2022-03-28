import ballerina/io;
import ballerina/sql;

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




