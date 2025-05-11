// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract TimeLocak {
    // not owner
    error NotOwnerError();
    // queued exist
    error AlreadyQueuedError(bytes32 txId);
    // timestamp not in range
    error TimestampNotInRangeError(uint256 blockTimestamp, uint256 timestamp);
    // queued not exist
    error NotQueuedError(bytes32 txId);
    // timestamp not passed
    error TimestampNotPassedError(uint256 blockTimestamp, uint256 timestamp);
    // timestamp expired
    error TimestampExpiredError(uint256 blockTimestamp, uint256 expiredAt);
    // call fail
    error TxFailedError();

    // 入队事件
    event Queue(
        bytes32 indexed txId,
        address indexed target,
        uint256 value,
        string func,
        bytes data,
        uint256 timestamp
    );
    // 执行事件
    event Execute(
        bytes32 indexed txId,
        address indexed target,
        uint256 value,
        string func,
        bytes data,
        uint256 timestamp
    );
    // 取消事件
    event Cancel(bytes32 indexed txId);

    // 最小延时100s
    uint256 public constant MIN_DELAY = 100;
    // 最大延时300s
    uint256 public constant MAX_DELAY = 300;
    // 过期期限1000s
    uint256 public constant GRACE_PREIOD = 1000;

    address public owner;
    mapping(bytes32 => bool) public queued;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwnerError();
        }
        _;
    }

    // 获取调用者id
    function getTxId(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) public pure returns (bytes32 txId) {
        return keccak256(abi.encode(_target, _value, _func, _data, _timestamp));
    }

    // 入队
    function queue(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) external onlyOwner {
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        if (queued[txId]) {
            revert AlreadyQueuedError(txId);
        }
        //----|----------|------------|------
        //   block    block+min      block+max
        if (
            _timestamp < block.timestamp + MIN_DELAY ||
            _timestamp > block.timestamp + MAX_DELAY
        ) {
            revert TimestampNotInRangeError(block.timestamp, _timestamp);
        }
        // 入队
        queued[txId] = true;
        // 记录入队日志
        emit Queue(txId, _target, _value, _func, _data, _timestamp);
    }

    // 执行
    function execute(
        address _target,
        uint256 _value,
        string calldata _func,
        bytes calldata _data,
        uint256 _timestamp
    ) external payable onlyOwner returns (bytes memory) {
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        if (!queued[txId]) {
            revert NotQueuedError(txId);
        }
        // 还未到区块上的执行时间
        if (block.timestamp < _timestamp) {
            revert TimestampNotPassedError(block.timestamp, _timestamp);
        }
        // -------------|----------------------------------|-----------------
        //           timestamp                      timestamp + grace period
        // 已过期
        if (block.timestamp > _timestamp + GRACE_PREIOD) {
            revert TimestampExpiredError(
                block.timestamp,
                _timestamp + GRACE_PREIOD
            );
        }
        // 将队列中的调用id置为false 代表已执行
        queued[txId] = false;
        bytes memory data;
        if (bytes(_func).length > 0) {
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else {
            data = _data;
        }
        // 调用目标方法
        (bool ok, bytes memory res) = _target.call{value: _value}(data);
        if (!ok) {
            revert TxFailedError();
        }
        // 记录执行日志
        emit Execute(txId, _target, _value, _func, _data, _timestamp);
        return res;
    }

    // 取消执行
    function cancel(bytes32 _txId) external onlyOwner {
        // 检查是否在队列里
        if (!queued[_txId]) {
            revert NotQueuedError(_txId);
        }
        // 在队列里直接改为false 代表已执行
        queued[_txId] = false;
        // 记录取消日志
        emit Cancel(_txId);
    }
}

contract TestTimeLock {
    address public timelock;

    constructor(address _timelock) {
        timelock = _timelock;
    }

    function test() view external {
        require(msg.sender == timelock);
        // more code such as
        // -升级合约
        // -转移资产
        // -修改预言机
    }

    function getTimestamp() external view returns (uint256) {
        return block.timestamp + 100;
    }
}
