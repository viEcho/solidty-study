// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract MultilSignWallect {
    
    event Deposit(address indexed sender, uint amout);
    event Submit(uint indexed txId);
    event Approve(address indexed owner,uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    struct Transation{
        address to;
        uint value;
        bytes data; 
        bool executed;  
    }
    
    address[] public owners;
    mapping (address=>bool) public isOwner;
    uint public required;

    Transation [] public transactions;
    mapping(uint => mapping(address => bool)) public approved;

    modifier onlyOwner(){
        require(isOwner[msg.sender],"not owner");
        _;
    }

    modifier txExists(uint _txId){
        require(!approved[_txId][msg.sender], "tx does not exist");
        _;
    }

    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender],"tx allready approved");
        _;
    }

    modifier  notExecuted(uint _txId){
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required){
        require(_owners.length > 0,"owners require");
        require(_required > 0 && _required <= owners.length, "invalid required number");

        for(uint i = 0;i<_owners.length;i++){
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner],"owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }

    function submit(address _to,uint _value, bytes calldata _data) external onlyOwner{
        transactions.push(Transation({
            to:_to, 
            value:_value,  
            data:_data,
            executed: false
        }));
        emit Submit(transactions.length - 1);
    }

    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId){
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender,_txId);
    }

    function _getApprovalCount(uint _txId)private view returns (uint count){
        for(uint i;i< owners.length;i++){
            if(approved[_txId][owners[i]]) {
               count +=1;
            }
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(_getApprovalCount(_txId) >= required,"approvals < required");

        Transation storage transaction = transactions[_txId];
        (bool success,) = transaction.to.call{value:transaction.value}(transaction.data);
        require(success, "transacton failed!");
        emit Execute(_txId);
    }


    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId){
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke (msg.sender, _txId);
    }
}