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

    /// # Parameters
    /// * `deposit_verifier`: The address of the deposit SNARK verifier for this contract.
    /// * `withdraw_verifier`: The address of the withdraw SNARK verifier for this contract.
    /// * `denomination`: Transfer amount for each deposit.
    /// * `merkle_tree_height`: The height of deposits' Merkle Tree.
    #[constructor]
    fn constructor(
        ref self: ContractState,
        deposit_verifier: ContractAddress,
        withdraw_verifier: ContractAddress,
        denomination: u128,
        merkle_tree_height: u128
    ) {
        self.initializer(deposit_verifier, withdraw_verifier, denomination, merkle_tree_height);
    }

    /// Let users delete a previously committed commitment hash and withdraw 1 ether they deposited alongside it.
    fn clear(ref self: ContractState) {}

    /// Lets users commit with 1 ether and a commitment hash which they can add into the tree whenever they want.
    /// # Parameters
    /// * `commitment`: Commitment hash of user's deposit.
    fn commit(ref self: ContractState, commitment: felt252) {}

    /// Lets users add their committed `commitmentHash` to the current merkle root.
    /// # Arguments
    /// * `proof` - Proof of correct chain addition of `pendingCommit[msg.sender]` to the current merkle root.
    /// * `new_root` - New root after adding `pendingCommit[msg.sender]` into current merkle root.
    fn deposit(ref self: ContractState, proof: Proof, new_root: felt252) {}

    /// Withdraw a deposit from the contract.
    /// `proof` is a zkSNARK proof data, and `input` is an array of circuit public inputs.
    /// `input` array consists of:
    ///   - merkle root of all deposits in the contract
    ///   - hash of unique deposit nullifier to prevent double spends
    ///   - the recipient of funds
    ///   - optional fee that goes to the transaction sender (usually a relay)
    fn withdraw(
        proof: Proof,
        root: felt252,
        nullifier_hashe: felt252,
        recipient: ContractAddress,
        relayer: ContractAddress,
        fee: u128
    ) {}

    #[generate_trait]
    impl Private of PrivateTrait {
        fn initializer(
            ref self: ContractState,
            deposit_verifier: ContractAddress,
            withdraw_verifier: ContractAddress,
            denomination: u128,
            merkle_tree_height: u128
        ) {}
    }

    /// This function is defined in a child contract.
    fn process_deposit(ref self: ContractState) {}

    /// This function is defined in a child contract.
    fn process_withdraw(
        ref self: ContractState, recipient: ContractAddress, relayer: ContractAddress, fee: u128
    ) {}

    fn is_known_root(ref self: ContractState, root: felt252) -> bool {
        false
    }
}
