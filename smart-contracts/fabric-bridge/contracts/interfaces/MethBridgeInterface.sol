pragma solidity >=0.4.25 <0.6.0;

interface MethBridgeInterface {

    function setValue(uint256 _i) external;
    function getValue() external view returns(uint256);
    function setValueInFabric(address fabricContract, uint256 _i) external;
    function getValueInFabric(address fabricContract) external returns(uint256);
    function getInfo() external returns (bytes32);
}
