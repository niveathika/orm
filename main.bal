import ballerina/io;

public function main() {
    io:println("Hello, World!");

    QueryBuilder query = new();
    query = query.'select("name", "age");


}




