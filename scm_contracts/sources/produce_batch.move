module scm_contracts::ProduceBatch {

    use std::string::String;

    public struct ProduceBatch has key, store {
        id: UID,
        farmer_id: address,
        seed_source: String,
        planting_date: String,
        harvest_date: String,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>,
        irrigation_type: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_produce_batch(
        ctx: &mut TxContext,
        farmer_id: address,
        seed_source: String,
        planting_date: String,
        harvest_date: String,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>,
        irrigation_type: String
    ) {
        transfer::public_transfer(ProduceBatch {
            id: object::new(ctx),
            farmer_id,
            seed_source,
            planting_date,
            harvest_date,
            fertilizers_used,
            pesticides_used,
            irrigation_type,
        }, tx_context::sender(ctx));
    }

    public fun add_fertilizer(batch: &mut ProduceBatch, item: String) {
        batch.fertilizers_used.push_back(item);
    }

    public fun add_pesticide(batch: &mut ProduceBatch, item: String) {
        batch.pesticides_used.push_back(item);
    }

    public fun add_harvest_date(batch: &mut ProduceBatch, date: String) {
        batch.harvest_date = date;
    }

    public fun edit_batch(
        batch: &mut ProduceBatch,
        farmer_id: address,
        seed_source: String,
        planting_date: String,
        harvest_date: String,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>,
        irrigation_type: String
    ) {
        batch.farmer_id = farmer_id;
        batch.seed_source = seed_source;
        batch.planting_date = planting_date;
        batch.harvest_date = harvest_date;
        batch.fertilizers_used = fertilizers_used;
        batch.pesticides_used = pesticides_used;
        batch.irrigation_type = irrigation_type;
    }
}