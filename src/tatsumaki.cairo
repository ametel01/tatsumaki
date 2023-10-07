#[starknet::contract]
mod Tatsumaki {
    use starknet::ContractAddress;

    use tatsumaki::{Proof, interfaces::{IWithdrawVerifierDispatcher, IDepositVerifierDispatcher}};

    const FIELD_SIZE: felt252 =
        684007589744977643812317022363560833416048810751841086817548514795957780480;
    const ROOT_HISTORY_SIZE: u8 = 30;
    const initialRootZero: felt252 =
        0x1587b7e00bcfcd0000000000000000000000000000000000000000000000000;

    #[storage]
    struct Storage {
        denomination: u128,
        levels: u128,
        withdraw_verifier: IWithdrawVerifierDispatcher,
        deposit_verifier: IDepositVerifierDispatcher,
        current_root_index: usize,
        next_index: usize,
        roots_len: usize,
        roots: LegacyMap::<usize, felt252>,
        nullifier_hashes: LegacyMap::<felt252, bool>,
        pending_commit: LegacyMap::<ContractAddress, felt252>
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Deposit: Deposit,
        Withdrawal: Withdrawal
    }

    #[derive(Drop, starknet::Event)]
    struct Deposit {
        commitment: felt252,
        leaf_index: usize,
        timestamp: u64
    }

    #[derive(Drop, starknet::Event)]
    struct Withdrawal {
        to: ContractAddress,
        nullifier_hash: felt252,
        relayer: ContractAddress,
        fee: u128
    }
}
