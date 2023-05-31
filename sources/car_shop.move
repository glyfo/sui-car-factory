module srv::shop {

     use sui::transfer;
     use sui::sui::SUI;
     use sui::coin::{Self, Coin};
     use sui::object::{Self, UID};
     use sui::balance::{Self, Balance};
     use sui::tx_context::{Self, TxContext};

     const EInsufficientBalance: u64 = 0;

     struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling:     u8
     }

     struct CarShop has key {
        id: UID,
        price: u64,
        balance: Balance<SUI>
     }

     struct ShopOwnerCap has key { id: UID }

    fun init(ctx: &mut TxContext) {
        transfer::transfer(CarShop {id: object::new(ctx),
                                    price: 100,
                                     balance: balance::zero() 
                                   }
                           ,tx_context::sender(ctx));
        transfer::share_object(CarShop {
                               id: object::new(ctx),
                               price: 100,
                               balance: balance::zero()
        });

 
    }

    public entry fun buy_car(shop: &mut CarShop, payment : &mut Coin<SUI>,ctx: &mut TxContext){
       
           assert!(coin::value(payment) >= show.price, EInsufficientBalance);
           let coin_balance = coin::balance_mut(payment);
           let paid = balance::split(coin_balance,shop.price);

           balance::join(&mut shop.balance,paid);

            transfer::transfer(Car {
                               id: object::new(ctx),
                               speed: 50,
                               acceleration:50,
                               handling:50},tx_context::sender(ctx));

    }

}