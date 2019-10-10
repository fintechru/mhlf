pragma solidity >=0.4.25 <0.6.0;

interface CommonBCBridgeInterface {

    function setValue(uint256 _i) external;
    function getValue() external view returns(uint256);
    function setValueInAnotherBC(address anotherBCContract, uint256 _i) external;
    function getValueInAnotherBC(address anotherBCContract) external returns(uint256);
    function getInfo() external returns (bytes32);
}
