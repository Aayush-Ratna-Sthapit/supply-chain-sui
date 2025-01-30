module scm_contracts::BatchHarvestInfo {

    use std::string::String;

    public struct BatchHarvestInfo has key, store {
        id: UID,
        produce_batch_id: UID,
        harvest_date: String,
        harvest_time: String,
        total_weight: u16,
        weight_unit: String,
        packaging_details: PackagingDetails,
    }

    public struct PackagingDetails has store, copy, drop {
        packaging_date: String,
        packaging_time: String,
        packaging_material: String,
        packaging_weight: u16,
        packaging_weight_unit: String,
        packaging_location: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_batch_harvest_info(
        produce_batch_id: UID,
        harvest_date: String,
        harvest_time: String,
        total_weight: u16,
        weight_unit: String,
        packaging_date: String,
        packaging_time: String,
        packaging_material: String,
        packaging_weight: u16,
        packaging_weight_unit: String,
        packaging_location: String,
        ctx: &mut TxContext,
    ) {
        let packaging_details = PackagingDetails {
            packaging_date,
            packaging_time,
            packaging_material,
            packaging_weight,
            packaging_weight_unit,
            packaging_location,
        };
        transfer::public_transfer(BatchHarvestInfo {
            id: object::new(ctx),
            produce_batch_id,
            harvest_date,
            harvest_time,
            total_weight,
            weight_unit,
            packaging_details
        }, tx_context::sender(ctx));
    }

    // Function to update the data
    public fun update_batch_harvest_info(
        harvest_info: &mut BatchHarvestInfo,
        new_harvest_date: String,
        new_harvest_time: String,
        new_total_weight: u16,
        new_weight_unit: String,
    ) {
        harvest_info.harvest_date = new_harvest_date;
        harvest_info.harvest_time = new_harvest_time;
        harvest_info.total_weight = new_total_weight;
        harvest_info.weight_unit = new_weight_unit;
    }

    public fun update_packaging_details(
        harvest_info: &mut BatchHarvestInfo,
        packaging_date: String,
        packaging_time: String,
        packaging_material: String,
        packaging_weight: u16,
        packaging_weight_unit: String,
        packaging_location: String,
    ) {
        harvest_info.packaging_details.packaging_date = packaging_date;
        harvest_info.packaging_details.packaging_time = packaging_time;
        harvest_info.packaging_details.packaging_material = packaging_material;
        harvest_info.packaging_details.packaging_weight = packaging_weight;
        harvest_info.packaging_details.packaging_weight_unit = packaging_weight_unit;
        harvest_info.packaging_details.packaging_location = packaging_location;
    }

}