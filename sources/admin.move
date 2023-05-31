module srv::admin {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct AdminCapability has key {
        id: UID
    }

    struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling: u8,
    }

    fun init(ctx: &mut TxContext) {
        transfer::transfer(
                           AdminCapability {id: object::new(ctx)}
                           ,tx_context::sender(ctx)
                           );
    }

    fun new(speed: u8,acceleration: u8,handling: u8,ctx: &mut TxContext): Car {
        Car {
            id: object::new(ctx),
            speed,
            acceleration,
            handling
        }
    }
    // This model support a security admin capability using AdminCapability Ownership
    public entry fun create(
                             _: &AdminCapability,
                                       speed: u8,
                                acceleration: u8,
                                    handling: u8,
                             ctx: &mut TxContext
                            ) {
        let car = new(speed,acceleration,handling,ctx);
        transfer::transfer(car,tx_context::sender(ctx));
    }

}