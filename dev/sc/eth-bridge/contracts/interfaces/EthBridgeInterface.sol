pragma solidity >=0.4.25 <0.6.0;

interface EthBridgeInterface {

    function setValue(uint256 _i) external;
    function getValue() external view returns(uint256);
    function setValueInEth(address fabricContract, uint256 _i) external;
    function getValueInEth(address fabricContract) external returns(uint256);
    function getInfo() external returns (bytes32);
}
