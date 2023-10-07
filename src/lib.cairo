mod tatsumaki;
mod interfaces;

#[derive(Drop, Serde)]
struct Proof {
    a: Array<felt252>,
    b: Array<Array<felt252>>,
    c: Array<felt252>
}
