
// `User` belongs to `Company`, `CompanyID` is the foreign key
type UserA1 record {
    @PrimaryKey
    @AutoIncrement
    int id = -1;
    
    string name;
    int companyID;

    @ForeignKey {
        key: "companyID",
        reference: "id",
        onUpdate: CASCADE,
        onDelete: NO_ACTION // or SET NULL   
    }

    Company company;
};

type Company record {
    @PrimaryKey
    @AutoIncrement
    int id;
    string name;
};

// CREATE TABLE Company (id int, name varchar(100), PRIMARY KEY(id));
// CREATE TABLE User1 (id int NOT NULL AUTOINCREMENT, name VARCHAR, companyID int, PRIMARY KEY(id), FOREIGN KEY (companyID) REFERENCES Company(id) ON UPDATE CASCADE ON DELETE NO ACTION)

// Has one
// `User` has one to `Creditcard`,
type UserA2 record {

    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;

    @ForeignKey {
        key: "userId",
        reference: "id",
        onUpdate: CASCADE,
        onDelete: CASCADE // or SET NULL   
    }
    CreditCard card;
};

type CreditCard record {
    @PrimaryKey
    int id;
    string number;
    int userId;
};

// CREATE TABLE User2 (id int NOT NULL AUTOINCREMENT, name VARCHAR, PRIMARY KEY(id)) 
// CREATE TABLE CreditCard (id int, name varchar(100), userId int, PRIMARY KEY(id), FOREIGN KEY (userId) REFERENCES User(id) ON UPDATE CASCADE ON DELETE NO ACTION);

// Has many
// Similar to has one on constraints except it contains an array
type User3 record {
    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;

    @ForeignKey {
        key: "userId",
        reference: "id",
        onUpdate: CASCADE,
        onDelete: CASCADE // or SET NULL   
    }
    CreditCard[] card;
};

type Name record {
    string firstName;
    string lastName;
};

// Many to Many
type User4 record {
    @PrimaryKey
    Name name;

    @ForeignKey {
        key: "name.lastName",
        reference: "id",
        onUpdate: CASCADE,
        onDelete: SET_NULL, // Cascade for user_lang table
        many2many: "user_lang"
    }
    Language[] language;
};

type Language record {
    int id;
    string name;
    @ForeignKey {
        key: "userId",
        reference: "id",
        onUpdate: CASCADE,
        onDelete: SET_NULL,
        many2many: "user_lang"
    }
    User4[] user;
};

