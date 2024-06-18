{
    { }
    function abi_encode_tuple_t_uint256__to_t_uint256__fromStack_reversed(headStart, value0) -> tail
    {
        tail := add(headStart, 32)
        mstore(headStart, value0)
    }
    function abi_decode_tuple_t_uint256(headStart, dataEnd) -> value0
    {
        if slt(sub(dataEnd, headStart), 32) { revert(0, 0) }
        value0 := calldataload(headStart)
    }
    function panic_error_0x32()
    {
        mstore(0, shl(224, 0x4e487b71))
        mstore(4, 0x32)
        revert(0, 0x24)
    }
    function panic_error_0x11()
    {
        mstore(0, shl(224, 0x4e487b71))
        mstore(4, 0x11)
        revert(0, 0x24)
    }
    function checked_add_t_uint256(x, y) -> sum
    {
        sum := add(x, y)
        if gt(x, sum) { panic_error_0x11() }
    }
    function checked_sub_t_uint256(x, y) -> diff
    {
        diff := sub(x, y)
        if gt(diff, x) { panic_error_0x11() }
    }
}