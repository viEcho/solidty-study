// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {
    // 定义存款事件，记录账户地址和金额
    event Deposit(address indexed account, uint256 amount);
    // 定义取款事件，记录账户地址和金额
    event Withdraw(address indexed account, uint256 amount);

    // 构造函数，初始化代币名称为"Wrapped Ether"，符号为"WETH"
    constructor() ERC20("Wrapped Ether", "WETH") {}

    // receive函数，接收以太币的入口
    receive() external payable {
        // 默认执行存款操作
        deposit();
    }

    // fallback函数，当调用不存在的函数时执行
    fallback() external payable {
        // 默认执行存款操作
        deposit();
    }

    // 存款函数，将ETH兑换为WETH
    function deposit() public payable {
        // 铸造等量的WETH给发送者
        _mint(msg.sender, msg.value);
        // 触发存款事件
        emit Deposit(msg.sender, msg.value);
    }

    // 取款函数，将WETH兑换回ETH
    function withdraw(uint256 _amount) external {
        // 销毁发送者的WETH,_burn 是继承ERC20的一个标准方法 先burn再转账避免重入
        _burn(msg.sender, _amount);
        // 向发送者转账等量ETH
        payable(msg.sender).transfer(_amount);
        // 触发取款事件
        emit Withdraw(msg.sender, _amount);
    }
}
