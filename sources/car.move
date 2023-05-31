module srv::core {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    
    struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling: u8,
    }

    fun new(speed: u8,acceleration: u8,handling: u8,ctx: &mut TxContext): Car {
        Car {
            id: object::new(ctx),
            speed,
            acceleration,
            handling
        }
    }

    public entry fun create(speed: u8,acceleration: u8,handling: u8,ctx: &mut TxContext) {
        let car = new(speed,acceleration,handling,ctx);
        transfer::transfer(car,tx_context::sender(ctx));
    }
}