import ballerina/time;

type Workplace record {|
    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;
    string address;
    string phone;
|};

type Worker record {|

    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;
    time:Date dob;
    int workplaceId = -1; 

    @ForeignKey {
        key: "workplaceId",
        reference: "id",
        onDelete: "DELETE"
    }
    Workplace workplace?;

    @ForeignKey {
        key: "workerId",
        reference: "id",
        many2many: "worker_recipe"
    }
    Recipe[] recipes?;
|};

function insertWorker() returns error? {
    Client db = check new();

    Worker john = {
        name: "John",
        dob: {
            year: 1996,
            month: 12,
            day: 15
        },
        workplace: {
            name: "WSO2",
            address: "Colombo",
            phone: "011-271-9938"
        }
    };

    _ = check db->insert(john);
    // If the associations primary id is valid, the association will not be persisted
}


function insertWorkplace() returns error? {
    Client db = check new();

    Workplace wso2 = {
        name: "WSO2",
        address: "Colombo",
        phone: "011-273-2222"
    };

    Worker tom = {
        name: "Tom", 
        dob: {
            year: 1993,
            month: 1,
            day: 3
        },
        workplace: wso2
    };

    Worker alice = {
        name: "Tom", 
        dob: {
            year: 1993,
            month: 1,
            day: 3
        },
        workplace: {
            name: "S0W2",
            address: "Colombo",
            phone: "011-1234567"
        }
    };

    _ = check db->insert(wso2);
    _ = check db->insert(tom);


    _ = check db->insert(alice);

}
function getAll() returns error? {
    Client db = check new();
    stream<Workplace, Error?> _ = db->get(Workplace);
    stream<Worker, Error?> _ = db->get(Worker);
}

function deleteAll() returns error? {
    Client db = check new();

    // Note: this should delete the child workers as well
    _ = check db->delete(Workplace);
}

function getWorker() returns Worker|error {
    Client db = check new();

    // Note: this would not fetch the workplace details
    // Issues: can we check whether the `worker` record contains the fields mentioned in the filter at compile time?
    Worker john = check db->getRecord(name = "john", age = 324);
    return john;
}

function getWorkerWithAssociation() returns Worker|error {
    Client db = check new();

    // New: API to fetch a single record with association
    // Issues: how should we handle chaining and cycles? - only one level down
    // Issues: should be able to specify which fields to eagerly load?
    // Suggestion:
    //      john.workplace = check db->getRecord(Workplace, {"id", "workplace_id"});
    Worker john = check db->getRecordWithAssociation(Worker, name = "john");
    return john;
}

function deleteWorker() returns error? {
    Client db = check new();
    Worker john = check getWorker();

    _ = check db->delete(Worker, name = "john", age = 34);

    // Note: in this case, we should not delete the parent workplace
}
