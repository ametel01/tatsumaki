#[starknet::contrac]
mod Tatsumaki {
    use starknet::ContractAddress;

    use tatsumaki::{Proof, interfaces::{IWithdrawVerifier, IDepositVerifier}};

    const FIELD_SIZE: felt252 =
        684007589744977643812317022363560833416048810751841086817548514795957780480;
    const ROOT_HISTORY_SIZE: u8 = 30;
    const initialRootZero: felt252 =
        0x1587b7e00bcfcd0000000000000000000000000000000000000000000000000;
}
