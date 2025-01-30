module scm_contracts::Transportation {

    use std::string::String;

    public struct Transportation has key, store {
        id: UID,
        produce_batch_id: UID,
        driver_id: UID,
        vehicle_id: UID,
        distance: u64,
        load_date: String,
        unload_date: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_transportation(
        produce_batch_id: UID,
        driver_id: UID,
        vehicle_id: UID,
        load_date: String,
        ctx: &mut TxContext
    ) {
        transfer::public_transfer(Transportation {
            id: object::new(ctx),
            produce_batch_id,
            driver_id,
            vehicle_id,
            distance: 0,
            load_date,
            unload_date: b" ".to_string(),
        }, tx_context::sender(ctx));
    }

    public fun update_distance(transportation: &mut Transportation, new_distance: u64) {
        transportation.distance = new_distance;
    }

    public fun update_unload_date(transportation: &mut Transportation, new_unload_date: String) {
        transportation.unload_date = new_unload_date;
    }
}