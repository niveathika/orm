import ballerina/sql;
import ballerina/jballerina.java;

public client class Client1 {

    // intit -> Connection details, batch size

    remote isolated function insert(record {} insertRecord) returns sql:ExecutionResult|error {
        // Should the records be updated for auto incremnt coloumns?

        //todo: Check performance of insert only specific coloumns and whether to support it if needed
        return error sql:Error("");
    }

    remote isolated function batchInsert(record {}[] records) returns sql:ExecutionResult|error? {
        // Should the records be updated for auto incremnt coloumns?
    }
    // todo: Support upsert?

    remote isolated function delete(typedesc<record {}> deleteTable, record {}? condition = ()) returns sql:ExecutionResult|error? {
        // Condition record will add where clause with and conditions
    }

    remote isolated function deleteWithCondition(typedesc<record {}> deleteTable, sql:ParameterizedQuery query) returns sql:ExecutionResult|error? {
        // Since it is only where clause do we need to support QueryBuilder in delete function for completeion sake?
    }

    remote isolated function update(record {} updateValues, record {}? condition = ()) returns sql:ExecutionResult|error? {

    }

    remote isolated function updatesWithCondition(record {} updateValues, sql:ParameterizedQuery query) returns sql:ExecutionResult|error? {
        // Should update only one column with a condition be allowed here.?

    }

    remote isolated function query(typedesc<record {}> tableType = <>, record {}? condition = ()) returns stream<tableType, error?> = @java:Method {
        'class: "",
        name: ""
    } external;

    // remote isolated function queryWithcondition( sql:ParameterizedQuery query, typedesc<record {}> tableType = <>) returns stream<tableType, error?> = @java:Method {
    //         'class: "",
    //         name: ""
    //     } external;

    // remote isolated function queryWithBuilder(QueryBuilder query, typedesc<record {}> tableType = <>) returns stream<tableType, error?> = @java:Method {
    //         'class: "",
    //         name: ""
    //     } external;

    remote isolated function count(typedesc<record {}> countTable) returns int|error? {
    }

    remote isolated function countWithQueryBuilder(typedesc<record {}> countTable, QueryBuilder queryBuilder) returns int|error? {
        // Select any other coloumns,
        // Count is of distinct
        // Order by
        // group by
        // where
    }

}
