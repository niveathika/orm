import ballerina/time;

public type ForeignKeyConfig record {|
    string key?;
    string reference?;
    //todo change below to enums
    string onUpdate?; // GORM default behaviour is these constraints are not set. However when deleting one record, the association can be selected 
    string onDelete?;
    string many2many?;
|};

// delete user's CreditCards relations when deleting user
// db.Select("CreditCards").Delete(&user)

public annotation true PrimaryKey on record field;

public annotation ForeignKeyConfig ForeignKey on record field;

public type ColumnConfig record {|
    string name?; // Default value will be the field name
    string dataType?; // Default type will be inferred from basic balleirna types and sql TypedValues
    boolean isUnique = false;
    boolean autoIncrement = false;
    int incrementInterval = 1;
    boolean isPrimaryKey = false;
|};

public annotation ColumnConfig Column on record field;

public type TableConfig record {|
    string name?;
|};

public annotation TableConfig Table on record field;

public type EmbedConfig record {|
    string prefix?;
|};

public annotation EmbedConfig Embed on record field;

type Student record {|
    @PrimaryKey
    @Column {
        autoIncrement: true
    }
    int id;
    string name;
    time:Date dob;
|};


