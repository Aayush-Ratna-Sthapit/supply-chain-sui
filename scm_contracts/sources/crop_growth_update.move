module scm_contracts::CropGrowthUpdate {

    use std::string::String;

    public struct CropGrowthUpdate has key, store {
        id: UID,
        produce_batch_id: UID,
        stage: String,
        days_in: u16,
        soil_condition: SoilCondition,
        weather_condition: WeatherCondition,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>,
    }

    public struct SoilCondition has store, copy, drop {
        ph_level: u8,
        moisture_level: u64,
        nutrients_level: u64,
    }

    public struct WeatherCondition has store, copy, drop {
        temperature: u16,
        humidity: u16,
        rainfall: u16,
    }

    #[allow(lint(self_transfer))]
    public fun create_crop_growth_update(
        ctx: &mut TxContext,
        produce_batch_id: UID,
        stage: String,
        days_in: u16,
        ph_level: u8,
        moisture_level: u64,
        nutrients_level: u64,
        temperature: u16,
        humidity: u16,
        rainfall: u16,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>
    ) {
        let soil_condition = SoilCondition {
            ph_level,
            moisture_level,
            nutrients_level,
        };
        let weather_condition = WeatherCondition {
            temperature,
            humidity,
            rainfall,
        };
        transfer::public_transfer( CropGrowthUpdate {
            id: object::new(ctx),
            produce_batch_id,
            stage,
            days_in,
            soil_condition,
            weather_condition,
            fertilizers_used,
            pesticides_used,
        }, tx_context::sender(ctx) );
    }

    public fun update_crop_growth_update(
        crop_growth_update: &mut CropGrowthUpdate,
        stage: String,
        days_in: u16,
        ph_level: u8,
        moisture_level: u64,
        nutrients_level: u64,
        temperature: u16,
        humidity: u16,
        rainfall: u16,
        fertilizers_used: vector<String>,
        pesticides_used: vector<String>
    ) {
        crop_growth_update.stage = stage;
        crop_growth_update.days_in = days_in;
        crop_growth_update.soil_condition = SoilCondition {
            ph_level,
            moisture_level,
            nutrients_level,
        };
        crop_growth_update.weather_condition = WeatherCondition {
            temperature,
            humidity,
            rainfall,
        };
        crop_growth_update.fertilizers_used = fertilizers_used;
        crop_growth_update.pesticides_used = pesticides_used;
    }
}