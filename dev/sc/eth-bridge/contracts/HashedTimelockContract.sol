pragma solidity ^0.5.0;

contract HashedTimelock {

    event LogHTLCNew(
        bytes32 indexed contractId,
        address indexed sender,
        address indexed receiver,
        uint amount,
        bytes32 hashlock,
        uint timelock
    );

    event LogHTLCWithdraw(bytes32 indexed contractId);

    event LogHTLCRefund(bytes32 indexed contractId);

    struct LockContract {
        address payable sender;
        address payable receiver;
        uint amount;
        bytes32 hashlock;
        uint timelock;
        bool withdrawn; 
        bool refunded; 
        bytes32 preimage; 
    }

    modifier fundsSent() {
        require(msg.value > 0, "msg.value must be > 0");
        _;
    }

    modifier futureTimelock(uint _time) {
        require(_time > now, "timelock time must be in the future");
        _;
    }

    modifier contractExists(bytes32 _contractId) {
        require(haveContract(_contractId), "contractId does not exist");
        _;
    }

    modifier hashlockMatches(bytes32 _contractId, bytes32 _x) {
        require(
            contracts[_contractId].hashlock == sha256(abi.encodePacked(_x)),
            "hashlock hash does not match"
        );
        _;
    }

    modifier withdrawable(bytes32 _contractId) {
        require(contracts[_contractId].receiver == msg.sender, "withdrawable: not receiver");
        require(contracts[_contractId].withdrawn == false, "withdrawable: already withdrawn");
        require(contracts[_contractId].timelock > now, "withdrawable: timelock time must be in the future");
        _;
    }

    modifier refundable(bytes32 _contractId) {
        require(contracts[_contractId].sender == msg.sender, "refundable: not sender");
        require(contracts[_contractId].refunded == false, "refundable: already refunded");
        require(contracts[_contractId].withdrawn == false, "refundable: already withdrawn");
        require(contracts[_contractId].timelock <= now, "refundable: timelock not yet passed");
        _;
    }

    mapping (bytes32 => LockContract) contracts;

    function newContract(address payable _receiver, bytes32 _hashlock, uint _timelock)
        external
        payable
        fundsSent
        futureTimelock(_timelock)
        returns (bytes32 contractId)
    {
        contractId = sha256(
            abi.encodePacked(
                msg.sender,
                _receiver,
                msg.value,
                _hashlock,
                _timelock
            )
        );

        if (haveContract(contractId))
            revert();

        contracts[contractId] = LockContract(
            msg.sender,
            _receiver,
            msg.value,
            _hashlock,
            _timelock,
            false,
            false,
            0x0
        );

        emit LogHTLCNew(
            contractId,
            msg.sender,
            _receiver,
            msg.value,
            _hashlock,
            _timelock
        );
    }

    function withdraw(bytes32 _contractId, bytes32 _preimage) external
        contractExists(_contractId)
        hashlockMatches(_contractId, _preimage)
        withdrawable(_contractId)
        returns (bool)
    {
        LockContract storage c = contracts[_contractId];
        c.preimage = _preimage;
        c.withdrawn = true;
        c.receiver.transfer(c.amount);
        emit LogHTLCWithdraw(_contractId);
        return true;
    }

    function refund(bytes32 _contractId) external contractExists(_contractId) refundable(_contractId) returns (bool)
    {
        LockContract storage c = contracts[_contractId];
        c.refunded = true;
        c.sender.transfer(c.amount);
        emit LogHTLCRefund(_contractId);
        return true;
    }

    function getContract(bytes32 _contractId) public view returns (
            address sender,
            address receiver,
            uint amount,
            bytes32 hashlock,
            uint timelock,
            bool withdrawn,
            bool refunded,
            bytes32 preimage
        )
    {
        if (haveContract(_contractId) == false)
            return (address(0), address(0), 0, 0, 0, false, false, 0);
        LockContract storage c = contracts[_contractId];
        return (c.sender, c.receiver, c.amount, c.hashlock, c.timelock,
                c.withdrawn, c.refunded, c.preimage);
    }

    function haveContract(bytes32 _contractId)
        internal
        view
        returns (bool exists)
    {
        exists = (contracts[_contractId].sender != address(0));
    }

}
