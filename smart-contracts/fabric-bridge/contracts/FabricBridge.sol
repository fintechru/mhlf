pragma solidity >=0.4.25 <0.6.0;

import './interfaces/FabricBridgeInterface.sol';
import './interfaces/MethBridgeInterface.sol';

contract FabricBridge is FabricBridgeInterface {

    uint256 public i;
    string contractInformation = "FabricBridgeV1";

    event ChangeValue(address currentContract, uint256 value);
    event RequestForChangeValue(address contractSender, address _contractReceiver, bytes encodedData);

    function setValue(uint256 _i) public {
        i = _i;

        emit ChangeValue(address(this), i);
    }

    function getValue() public view returns (uint256) {
        return i;
    }

    function setValueInMeth(address methContract, uint256 _i) public {

        /// @dev 4byte сигнатуры метода, который вызываем
        bytes4 methodSelector = MethBridgeInterface(0).setValue.selector;

        /// @dev данные, которые передаем в метод
        i = _i;

        /// @dev кодируем данные для передачи в другую сеть
        bytes memory encodedData = abi.encodeWithSelector(methodSelector, _i);

        /// @dev вызываем событие, которое будет отловлено мостом
        emit RequestForChangeValue(msg.sender, methContract, encodedData);
    }

    function getValueInMeth(address methContract) public returns (uint256) {

        /// @dev 4byte сигнатуры метода, который вызываем
        bytes4 methodSelector = MethBridgeInterface(0).getValue.selector;
        bytes memory encodedData = abi.encodeWithSelector(methodSelector);
        emit RequestForChangeValue(msg.sender, methContract, encodedData);

        return i;
    }

    function stringToBytes32(string memory source) internal returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }

    function getInfo() public returns (bytes32) {
        bytes32 contractInfo = stringToBytes32(contractInformation);
        return contractInfo;
    }
}