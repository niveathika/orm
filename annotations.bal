import ballerina/time;


// Table Representation

public type TableConfig record {|
    string name?;
|};

public annotation TableConfig Table on type;

@Table {
    name: "students"
}
type Student1 record {|
    int id;
    string name;
    time:Date dob;
|};

public type ColumnConfig record {|
    string name?; // Default value will be the field name
    string dataType?; // Default type will be inferred from basic Ballerina types and sql:TypedValue.
    // Any size or precision details can be given here. VARCHAR(255), DECIMAL(13, 0)
|};

public annotation ColumnConfig Column on record field;

type Student2 record {|
    @PrimaryKey
    @Column {
        name: "student_id",
        dataType: "BIGINT"
    }
    int id;
    string name;
    time:Date dob;
|};

// Embedding Fields

public type EmbedConfig record {|
    string prefix?; // Default value would be field name
|};

public annotation EmbedConfig Embed on record field;

type Address1 record {|
    string number;
    string street;
    string city;
    int zipcode;
|};

type User1 record {|
    int id;
    time:Date dob;

    @Embed
    Address1 home;
    // Fields in table would correspond to home_number, home_street, home_city, and
    // home_zipcode

    @Embed
    Address1 office;
    // Fields in table would correspond to office_number, office_street, office_city, and 
    // office_zipcode

|};

// Primary Key Constraint

public annotation true PrimaryKey on record field;

type StudentKey record {|
    int yearJoined;
    int id;
|};

type Student3 record {|
    @PrimaryKey
    StudentKey key;

    string name;
    time:Date dob;
|};

type Student4 record {|
    @PrimaryKey
    int yearJoined;

    @PrimaryKey
    int id;

    string name;
    time:Date dob;
|};

// Auto Increment Property

public type AutoIncrementConfig record {|
    int interval = 1; // Default value will be 1
|};

public annotation AutoIncrementConfig AutoIncrement on record field;

type Student5 record {|
    @PrimaryKey
    @AutoIncrement {interval: 2}
    int id = -1; // Go with default value, and ignore it at insertion as it is auto-increment

    string name;
    time:Date dob;
|};

// Unique Index

public annotation true Unique on record field;

type Student6 record {|
    @PrimaryKey
    int id;

    @Unique
    int nic;

    string name;
    time:Date dob;
|};


// Transient fields

public annotation true Transient on record field;

type Student record {|
    @PrimaryKey
    int id;
    string name;
    time:Date dob;

    @Transient
    int age;
|};

// Associations

public enum ReferenceOption {
   NO_ACTION,
   SET_NULL,
   CASCADE,
   DELETE
}

public type ForeignKeyConfig record {|
    string key?;        // Default value will be the `id` field
    string reference?;  // 
    ReferenceOption onUpdate?; // GORM default behaviour is these constraints are not set. However when deleting one record, the association can be selected 
    ReferenceOption onDelete?;
    string many2many?;
|};

public annotation ForeignKeyConfig ForeignKey on record field;

// TODO
type Table record {|
    @PrimaryKey
    @Unique
    @AutoIncrement
    int id = -1;

    time:Utc created_at;
    time:Utc last_modified_at;

    // This is used for soft delete functionality. To preserve data in order to recover 
    // if needed
    time:Utc? deleted_at;
|};

type User2 record {|
    *Table;
    string name;
|};
