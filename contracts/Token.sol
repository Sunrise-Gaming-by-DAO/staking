
// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/BEP20.sol";

// Token with Governance
contract Token is BEP20 {

    uint256 public maxSupply;

    constructor(string memory _name, string memory _symbol, uint256 _maxSupply, uint256 _initialSupply, address _holder)
        BEP20(_name, _symbol)
        public
    {
        require(_initialSupply <= _maxSupply, "Token: cap exceeded");

        maxSupply = _maxSupply;

        _mint(_holder, _initialSupply);
    }

    /// @dev Creates `_amount` token to `_to`. Must only be called by the owner (MasterChef).
    function mint(address _to, uint256 _amount)
        public
        onlyOwner
    {
        require(totalSupply() + _amount <= maxSupply, "Token: cap exceeded");

        _mint(_to, _amount);
    }

}