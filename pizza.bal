type Recipe record {|

    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;

    @ForeignKey {
        key: "recipe_id",
        reference: "worker_id",
        many2many: "worker_recipe"
    }
    Worker[] workers?;

    @ForeignKey {
        'key: "recipe_id",
        reference: "topping_id",
        many2many: "recipe_topping"
    }
    Topping[] toppings?;
|};

type Topping record {|

    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;

    @ForeignKey {
        'key: "topping_id",
        reference: "recipe_id",
        many2many: "recipe_topping"
    }
    Recipe[] recipes?;
|};

type Size record {|
    @PrimaryKey
    @AutoIncrement
    int id = -1;

    string name;
|};

type Pizza record {|
    @PrimaryKey
    @AutoIncrement
    int id = -1;

    int recipe_id = -1;
    @ForeignKey {
        key: "recipe_id",
        reference: "id"
    }
    Recipe recipe?;

    int size_id = -1;
    @ForeignKey {
        'key: "size_id",
        reference: "id"
    }
    Size size?;

    @Column {dataType: "DECIMAL (10, 2)"}
    decimal price;
|};

function seed() returns error? {
    Topping cheese = {name: "cheese"};
    Topping tomato = {name: "tomato"};
    Topping onions = {name: "onions"};

    Recipe boring = {
        id: -1,
        name: "boring",
        toppings: [cheese]
    };

    Recipe deluxe = {
        id: -1,
        name: "deluxe",
        toppings: [cheese, tomato, onions]
    };

    Size small = {name: "small"};
    Size medium = {name: "medium"};
    Size large = {name: "large"};

    Pizza pizza1 = {
        size: small,
        price: 10.02,
        recipe: boring
    };

    Pizza pizza2 = {
        size: medium,
        price: 15.02,
        recipe: deluxe
    };

    Pizza pizza3 = {
        size: large,
        price: 25.02,
        recipe: deluxe
    };

    Client db = check new ();
    _ = check db->insert(pizza1);
    _ = check db->insert(pizza2);
    _ = check db->insert(pizza3);
}

function getPizza() returns Pizza|error? {
    Client db = check new ();

    // Option 1
    Pizza pizza1 = check db->getRecord(Pizza, id = 1); // Only price is loaded
    pizza1.recipe = check db->getRecord(Recipe, {"id": pizza1.recipe_id});
    pizza1.size = check db->getRecord(Size, {"id": pizza1.size_id});

    // Option 2
    Pizza pizza2 = check db->getRecordWithAssociation(Pizza, {"id": 1}); // All fields are loaded

    return pizza2;
}

function getRecipe() returns Recipe|error? {
    Client db = check new ();

    // Option 1 - will not work
    // Issue:
    Recipe deluxe = check db->getRecord(Recipe, {"name": "deluxe"}); // Only name is loaded
    stream<Topping, Error?> toppingsStream = db->get(Topping, {"id": "how to get this?"});
    Topping[] toppings = [];
    check from Topping topping in toppingsStream
        do {
            toppings.push(topping);
        };
    deluxe.toppings = toppings;

    // Option 2
    Recipe cheese = check db->getRecordWithAssociation(Recipe, {"name": "cheese"}); // All fields are loaded

    return cheese;

}
