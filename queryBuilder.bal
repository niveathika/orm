import ballerina/sql;

enum Order {
    ASEC,
    DESC
}

public client class QueryBuilder {

    isolated function 'table(typedesc<record {}> 'table) returns QueryBuilder {
        return self;
    }

    isolated function 'select(string|sql:ParameterizedQuery... selectClauses) returns QueryBuilder {
        return self;
    }

    isolated function 'distinct(string columns) returns QueryBuilder {
        
        return self;
    }

    isolated function orderBy(Order 'order = ASEC, string... columns) returns QueryBuilder {
        
        return self;
    }

    isolated function 'where(sql:ParameterizedQuery condition) returns QueryBuilder {
        
        return self;
    }

    isolated function 'limit(int size) returns QueryBuilder {
        
        return self;
    }

    isolated function 'offset(int size) returns QueryBuilder {
        
        return self;
    }

    isolated function load(typedesc<record {}>... associations) returns QueryBuilder {
        return self;
    }
    

            // join
}

            // group by, having

            // OR
            // NOT
            // IN