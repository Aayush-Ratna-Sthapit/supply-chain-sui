module scm_contracts::VehicleInfo {

    use std::string::String;

    public struct Vehicle has key, store {
        id: UID,
        owner_id: UID,
        make: String,
        model: String,
        year: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_vehicle(owner_id: UID, make: String, model: String, year: String, ctx: &mut TxContext) {
        transfer::public_transfer(Vehicle {
            id: object::new(ctx),
            owner_id,
            make,
            model,
            year,
        }, tx_context::sender(ctx));
    }

    public fun update_vehicle(vehicle: &mut Vehicle, new_make: String, new_model: String, new_year: String) {
        vehicle.make = new_make;
        vehicle.model = new_model;
        vehicle.year = new_year;
    }
}