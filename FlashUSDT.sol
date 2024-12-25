// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Flash USDT ($Tether) Smart Contract
//
// Website: https://flashusdtokens.com/
// Telegram: https://t.me/FlashUSDTokens
//
// Flash USDT is a secure, fast, and efficient token for interacting with the Tether ecosystem. 
// Designed for developers, traders, and businesses seeking innovative USDT solutions.

// --- FAQs ---
// Q: What is Flash USDT?
// A: Flash USDT is a utility token optimized for fast and secure USDT transactions.
//
// Q: What makes Flash USDT unique?
// A: It features an auto-burn mechanism, dynamic fees, and decentralized admin roles.
//
// Q: Can Flash USDT be integrated into dApps?
// A: Absolutely! Flash USDT is compatible with any dApp on Ethereum.

// --- SEO Keywords ---
// "flash usdt secure token", "usdt transaction fee token", "crypto fee sharing token",
// "flash tether admin roles", "flash token auto burn", "buy usdt secure wallet", 
// "usdt smart contract solutions", "flashusdt modern defi", "flash usdt developers guide"

contract FlashUSDT {
    string public constant name = "Flash USDT";
    string public constant symbol = "$Tether";
    uint8 public constant decimals = 18;
    uint256 public totalSupply = 100_000_000 * 10 ** uint256(decimals);

    bool public isTransferPaused = false;
    bool public isMintPaused = false;

    uint256 public burnRate = 2; // 2% of each transaction is burned
    uint256 public feeRate = 1; // 1% of each transaction goes to the fee wallet
    address public owner;
    address public feeWallet;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public admins;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);
    event FeeCollected(address indexed from, uint256 amount);
    event AdminAdded(address indexed admin);
    event AdminRemoved(address indexed admin);
    event TransferPaused();
    event TransferUnpaused();
    event MintPaused();
    event MintUnpaused();
    event BurnRateUpdated(uint256 newRate);
    event FeeRateUpdated(uint256 newRate);

    modifier onlyOwner() {
        require(msg.sender == owner, "Access restricted to owner");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender] || msg.sender == owner, "Access restricted to admins");
        _;
    }

    modifier whenTransferNotPaused() {
        require(!isTransferPaused, "Transfers are currently paused");
        _;
    }

    modifier whenMintNotPaused() {
        require(!isMintPaused, "Minting is currently paused");
        _;
    }

    constructor(address _feeWallet) {
        require(_feeWallet != address(0), "Fee wallet address cannot be zero");
        owner = msg.sender;
        feeWallet = _feeWallet;
        balanceOf[msg.sender] = totalSupply;

        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // --- Core Functions ---
    function transfer(address to, uint256 value) public whenTransferNotPaused returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        require(to != address(0), "Cannot transfer to zero address");

        uint256 burnAmount = (value * burnRate) / 100;
        uint256 feeAmount = (value * feeRate) / 100;
        uint256 transferAmount = value - burnAmount - feeAmount;

        balanceOf[msg.sender] -= value;
        balanceOf[to] += transferAmount;
        totalSupply -= burnAmount;

        if (feeAmount > 0) {
            balanceOf[feeWallet] += feeAmount;
            emit FeeCollected(msg.sender, feeAmount);
        }

        emit Transfer(msg.sender, to, transferAmount);
        emit Burn(msg.sender, burnAmount);

        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public whenTransferNotPaused returns (bool) {
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance too low");
        require(to != address(0), "Cannot transfer to zero address");

        uint256 burnAmount = (value * burnRate) / 100;
        uint256 feeAmount = (value * feeRate) / 100;
        uint256 transferAmount = value - burnAmount - feeAmount;

        balanceOf[from] -= value;
        balanceOf[to] += transferAmount;
        allowance[from][msg.sender] -= value;
        totalSupply -= burnAmount;

        if (feeAmount > 0) {
            balanceOf[feeWallet] += feeAmount;
            emit FeeCollected(from, feeAmount);
        }

        emit Transfer(from, to, transferAmount);
        emit Burn(from, burnAmount);

        return true;
    }

    // --- Minting and Burning ---
    function mint(address to, uint256 amount) public onlyAdmin whenMintNotPaused {
        require(to != address(0), "Cannot mint to zero address");
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Mint(to, amount);
    }

    function burn(uint256 amount) public {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance to burn");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Burn(msg.sender, amount);
    }

    // --- Admin Management ---
    function addAdmin(address admin) public onlyOwner {
        require(admin != address(0), "Cannot add zero address as admin");
        admins[admin] = true;
        emit AdminAdded(admin);
    }

    function removeAdmin(address admin) public onlyOwner {
        require(admins[admin], "Address is not an admin");
        admins[admin] = false;
        emit AdminRemoved(admin);
    }

    // --- Pause Controls ---
    function pauseTransfers() public onlyOwner {
        isTransferPaused = true;
        emit TransferPaused();
    }

    function unpauseTransfers() public onlyOwner {
        isTransferPaused = false;
        emit TransferUnpaused();
    }

    function pauseMinting() public onlyOwner {
        isMintPaused = true;
        emit MintPaused();
    }

    function unpauseMinting() public onlyOwner {
        isMintPaused = false;
        emit MintUnpaused();
    }

    // --- Update Rates ---
    function updateBurnRate(uint256 newRate) public onlyOwner {
        require(newRate <= 10, "Burn rate cannot exceed 10%");
        burnRate = newRate;
        emit BurnRateUpdated(newRate);
    }

    function updateFeeRate(uint256 newRate) public onlyOwner {
        require(newRate <= 10, "Fee rate cannot exceed 10%");
        feeRate = newRate;
        emit FeeRateUpdated(newRate);
    }
}
