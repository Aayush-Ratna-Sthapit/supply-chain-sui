module scm_contracts::DriverInfo {

    use std::string::String;

    public struct Driver has key, store {
        id: UID,
        name: String,
        license_number: String,
        delivery_count: u32,
    }

    #[allow(lint(self_transfer))]
    public fun create_driver(
        name: String,
        license_number: String,
        ctx: &mut TxContext
    ) {
        transfer::public_transfer(Driver {
            id: object::new(ctx),
            name,
            license_number,
            delivery_count: 0,
        }, tx_context::sender(ctx));
    }

    public fun update_driver_info(
        driver: &mut Driver,
        new_name: String,
        new_license_number: String,
        new_delivery_count: u32
    ) {
        driver.name = new_name;
        driver.license_number = new_license_number;
        driver.delivery_count = new_delivery_count;
    }

    public fun add_delivery(driver: &mut Driver) {
        driver.delivery_count = driver.delivery_count + 1;
    }

    public fun update_delivery_count(driver: &mut Driver, new_delivery_count: u32) {
        driver.delivery_count = new_delivery_count;
    }
}