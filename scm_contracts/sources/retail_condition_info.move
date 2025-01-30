module scm_contracts::RetailConditionInfo {

    use std::string::String;

    public struct RetailCondition has key, store {
        id: UID,
        produce_batch_id: UID,
        retailer_id: UID,
        produce_received_date: String,
        storage_condition: String,
        shelving_date: String,
        expiration_date: String,
        sale_date: String,
    }

    #[allow(lint(self_transfer))]
    public fun create_retail_condition(
        produce_batch_id: UID,
        retailer_id: UID,
        produce_received_date: String,
        storage_condition: String,
        expiration_date: String,
        ctx: &mut TxContext,
    ) {
        transfer::public_transfer(RetailCondition { 
            id: object::new(ctx), 
            produce_batch_id, 
            retailer_id, 
            produce_received_date, 
            storage_condition, 
            shelving_date: b" ".to_string(), 
            expiration_date,
            sale_date: b" ".to_string(), 
        }, tx_context::sender(ctx));
    }

    public fun update_retail_condition_optional(
        condition: &mut RetailCondition, 
        new_produce_received_date: String,
        new_storage_condition: String,
        new_shelving_date: String,
        new_expiration_date: String,
        new_sale_date: String,
    ) {
        condition.produce_received_date = new_produce_received_date;
        condition.storage_condition = new_storage_condition;
        condition.shelving_date = new_shelving_date;
        condition.expiration_date = new_expiration_date;
        condition.sale_date = new_sale_date;
    }

    public fun add_shelving_date(
        condition: &mut RetailCondition, 
        shelving_date: String
    ) {
        condition.shelving_date = shelving_date;
    }

    public fun add_expiration_date(
        condition: &mut RetailCondition, 
        expiration_date: String
    ) {
        condition.expiration_date = expiration_date;
    }

    public fun add_sale_date(
        condition: &mut RetailCondition, 
        sale_date: String
    ) {
        condition.sale_date = sale_date;
    }
}