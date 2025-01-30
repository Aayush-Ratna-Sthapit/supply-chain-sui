module scm_contracts::RetailerInfo {

    use std::string::String;

    public struct Retailer has key, store {
        id: UID,
        name: String,
        store_name: String,
        location: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_retailer(name: String, store_name: String, location: String, ctx: &mut TxContext) {
        transfer::public_transfer(Retailer {
            id: object::new(ctx),
            name,
            store_name,
            location,
        }, tx_context::sender(ctx));
    }

    public fun update_retailer(
        retailer: &mut Retailer, 
        new_name: String, 
        new_store_name: String, 
        new_location: String
    ) {
        retailer.name = new_name;
        retailer.store_name = new_store_name;
        retailer.location = new_location;
    }

}