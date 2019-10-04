pragma solidity >=0.4.25 <0.6.0;

interface FabricBridgeInterface {

    function setValue(uint256 _i) external;
    function getValue() external view returns (uint256);
    function setValueInMeth(address methContract, uint256 _i) external;
    function getValueInMeth(address methContract) external returns (uint256);
    function getInfo() external returns (bytes32);
}