module scm_contracts::Farmer {
    
    use std::string::String;

    public struct Farmer has key, store {
        id: UID,
        user: address,
        name: String,
        email: String,
        phone: String,
        farm_location: String,
        certification: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_farmer(
        name: String, 
        email: String, 
        phone: String, 
        farm_location: String, 
        certification: String, 
        ctx: &mut TxContext
    ) {
        transfer::public_transfer( Farmer {
            id: object::new(ctx),
            user: tx_context::sender(ctx),
            name,
            email,
            phone,
            farm_location,
            certification,
        }, tx_context::sender(ctx));
    }

    public fun edit_farmer(
        farmer: &mut Farmer,
        name: String, 
        email: String, 
        phone: String, 
        farm_location: String, 
        certification: String
    ) {
        farmer.name = name;
        farmer.email = email;
        farmer.phone = phone;
        farmer.farm_location = farm_location;
        farmer.certification = certification;
    }
}