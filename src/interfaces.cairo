use starknet::ContractAddress;

use tatsumaki::Proof;

#[starknet::interface]
trait IWithdrawVerifier<TState> {
    fn verify_proof(
        self: @TState,
        a: Array<felt252>,
        b: Array<Array<felt252>>,
        c: Array<felt252>,
        input: Array<felt252>
    );
}

#[starknet::interface]
trait IDepositVerifier<TState> {
    fn verify_proof(
        self: @TState,
        a: Array<felt252>,
        b: Array<Array<felt252>>,
        c: Array<felt252>,
        input: Array<felt252>
    );
}

#[starknet::interface]
trait ITatsumaki<TState> {
    fn clear(ref self: TState);
    fn commit(ref self: TState, commitment: felt252);
    fn deposit(ref self: TState, proof: felt252, new_root: felt252);
    fn withdraw(
        ref self: TState,
        proof: Proof,
        root: felt252,
        nullifier_hash: felt252,
        recipient: ContractAddress,
        relayer: ContractAddress,
        fee: u128
    );
    fn current_root_index(self: @TState) -> usize;
    fn netx_index(self: @TState) -> usize;
    fn roots(self: @TState, n: usize) -> felt252;
}
