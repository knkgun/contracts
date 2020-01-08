
// File: openzeppelin-solidity/contracts/token/ERC721/IERC721Receiver.sol

pragma solidity ^0.5.2;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return bytes4 `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
    public returns (bytes4);
}

// File: openzeppelin-solidity/contracts/token/ERC20/IERC20.sol

pragma solidity ^0.5.2;

/**
 * @title ERC20 interface
 * @dev see https://eips.ethereum.org/EIPS/eip-20
 */
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address who) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: openzeppelin-solidity/contracts/introspection/IERC165.sol

pragma solidity ^0.5.2;

/**
 * @title IERC165
 * @dev https://eips.ethereum.org/EIPS/eip-165
 */
interface IERC165 {
    /**
     * @notice Query if a contract implements an interface
     * @param interfaceId The interface identifier, as specified in ERC-165
     * @dev Interface identification is specified in ERC-165. This function
     * uses less than 30,000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: openzeppelin-solidity/contracts/token/ERC721/IERC721.sol

pragma solidity ^0.5.2;


/**
 * @title ERC721 Non-Fungible Token Standard basic interface
 * @dev see https://eips.ethereum.org/EIPS/eip-721
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) public view returns (uint256 balance);
    function ownerOf(uint256 tokenId) public view returns (address owner);

    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);

    function transferFrom(address from, address to, uint256 tokenId) public;
    function safeTransferFrom(address from, address to, uint256 tokenId) public;

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: openzeppelin-solidity/contracts/math/SafeMath.sol

pragma solidity ^0.5.2;

/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

// File: contracts/common/misc/ContractReceiver.sol

pragma solidity ^0.5.2;

 /*
 * Contract that is working with ERC223 tokens
 */


/// @title ContractReceiver - Standard contract implementation for compatibility with ERC 223 tokens.
contract ContractReceiver {
  /// @dev Function that is called when a user or another contract wants to transfer funds.
  /// @param _from Transaction initiator, analogue of msg.sender
  /// @param _value Number of tokens to transfer.
  /// @param _data Data containig a function signature and/or parameters
  function tokenFallback(address _from, uint256 _value, bytes memory _data) public;
}

// File: openzeppelin-solidity/contracts/ownership/Ownable.sol

pragma solidity ^0.5.2;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    constructor () internal {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @return the address of the owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner());
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Allows the current owner to relinquish control of the contract.
     * It will not be possible to call the functions with the `onlyOwner`
     * modifier anymore.
     * @notice Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: contracts/root/withdrawManager/IWithdrawManager.sol

pragma solidity ^0.5.2;

contract IWithdrawManager {
  function createExitQueue(address token) external;

  function verifyInclusion(bytes calldata data, uint8 offset, bool verifyTxInclusion) external view returns (uint256 age);

  function addExitToQueue(
      address exitor,
      address childToken,
      address rootToken,
      uint256 exitAmountOrTokenId,
      bytes32 txHash,
      bool isRegularExit,
      uint256 priority)
    external;

  function addInput(uint256 exitId, uint256 age, address utxoOwner, address token) external;

  function challengeExit(uint256 exitId, uint256 inputId, bytes calldata challengeData, address adjudicatorPredicate) external;
}

// File: contracts/common/Registry.sol

pragma solidity ^0.5.2;



contract Registry is Ownable {
  // @todo hardcode constants
  bytes32 constant private WETH_TOKEN = keccak256("wethToken");
  bytes32 constant private DEPOSIT_MANAGER = keccak256("depositManager");
  bytes32 constant private STAKE_MANAGER = keccak256("stakeManager");
  bytes32 constant private DELEGATION_MANAGER = keccak256("delegationManager");
  bytes32 constant private WITHDRAW_MANAGER = keccak256("withdrawManager");
  bytes32 constant private CHILD_CHAIN = keccak256("childChain");
  bytes32 constant private STATE_SENDER = keccak256("stateSender");
  bytes32 constant private SLASHING_MANAGER = keccak256("slashingManager");

  address public erc20Predicate;
  address public erc721Predicate;

  mapping(bytes32 => address) contractMap;
  mapping(address => address) public rootToChildToken;
  mapping(address => address) public childToRootToken;
  // @todo we can think of one function from the registry which returns both (childToken,isERC721) if we are using it frequently together.
  mapping(address => bool) public proofValidatorContracts;
  mapping(address => bool) public isERC721;

  enum Type { Invalid, ERC20, ERC721, Custom }
  struct Predicate {
    Type _type;
  }
  mapping(address => Predicate) public predicates;

  event TokenMapped(address indexed rootToken, address indexed childToken);
  event ProofValidatorAdded(address indexed validator, address indexed from);
  event ProofValidatorRemoved(address indexed validator, address indexed from);
  event PredicateAdded(address indexed predicate, address indexed from);
  event PredicateRemoved(address indexed predicate, address indexed from);
  event ContractMapUpdated(
   bytes32 indexed key,
   address indexed previousContract,
   address indexed newContract
  );

  function updateContractMap(bytes32 _key, address _address)
    external
    onlyOwner
  {
    emit ContractMapUpdated(_key, contractMap[_key], _address);
    contractMap[_key] = _address;
  }

  /**
   * @dev Map root token to child token
   * @param _rootToken Token address on the root chain
   * @param _childToken Token address on the child chain
   * @param _isERC721 Is the token being mapped ERC721
   */
  function mapToken(address _rootToken, address _childToken, bool _isERC721)
    external
    onlyOwner
  {
    require(
      _rootToken != address(0x0) && _childToken != address(0x0),
      "INVALID_TOKEN_ADDRESS"
    );
    rootToChildToken[_rootToken] = _childToken;
    childToRootToken[_childToken] = _rootToken;
    isERC721[_rootToken] = _isERC721;
    IWithdrawManager(contractMap[WITHDRAW_MANAGER]).createExitQueue(_rootToken);
    emit TokenMapped(_rootToken, _childToken);
  }

  function addProofValidator(address _validator) public onlyOwner {
    require(_validator != address(0) && proofValidatorContracts[_validator] != true);
    emit ProofValidatorAdded(_validator, msg.sender);
    proofValidatorContracts[_validator] = true;
  }

  function addErc20Predicate(address predicate) public onlyOwner {
    erc20Predicate = predicate;
    addPredicate(predicate, Type.ERC20);
  }

  function addErc721Predicate(address predicate) public onlyOwner {
    erc721Predicate = predicate;
    addPredicate(predicate, Type.ERC721);
  }

  function addPredicate(address predicate, Type _type) public onlyOwner
  {
    require(predicates[predicate]._type == Type.Invalid, "Predicate already added");
    predicates[predicate]._type = _type;
    emit PredicateAdded(predicate, msg.sender);
  }

  function removePredicate(address predicate) public onlyOwner
  {
    delete predicates[predicate];
    emit PredicateRemoved(predicate, msg.sender);
  }

  function removeProofValidator(address _validator) public onlyOwner {
    require(proofValidatorContracts[_validator] == true);
    emit ProofValidatorRemoved(_validator, msg.sender);
    delete proofValidatorContracts[_validator];
  }

  function getDelegationManagerAddress() public view returns(address) {
    return contractMap[DELEGATION_MANAGER];
  }

  function getWethTokenAddress() public view returns(address) {
    return contractMap[WETH_TOKEN];
  }

  function getDepositManagerAddress() public view returns(address) {
    return contractMap[DEPOSIT_MANAGER];
  }

  function getStakeManagerAddress() public view returns(address) {
    return contractMap[STAKE_MANAGER];
  }

  function getSlashingManagerAddress() public view returns(address) {
    return contractMap[SLASHING_MANAGER];
  }

  function getWithdrawManagerAddress() public view returns(address) {
    return contractMap[WITHDRAW_MANAGER];
  }

  function getChildChainAndStateSender() public view returns(address, address) {
    return (contractMap[CHILD_CHAIN], contractMap[STATE_SENDER]);
  }

  function isTokenMapped(address _token) public view returns (bool) {
    return rootToChildToken[_token] != address(0x0);
  }

  function isTokenMappedAndIsErc721(address _token) public view returns (bool) {
    require(isTokenMapped(_token), "TOKEN_NOT_MAPPED");
    return isERC721[_token];
  }

  function isTokenMappedAndGetPredicate(address _token) public view returns (address) {
    if (isTokenMappedAndIsErc721(_token)) {
      return erc721Predicate;
    }
    return erc20Predicate;
  }

  function isChildTokenErc721(address childToken) public view returns(bool) {
    address rootToken = childToRootToken[childToken];
    require(rootToken != address(0x0), "Child token is not mapped");
    return isERC721[rootToken];
  }
}

// File: openzeppelin-solidity/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.5.2;



/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * https://eips.ethereum.org/EIPS/eip-20
 * Originally based on code by FirstBlood:
 * https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 *
 * This implementation emits additional Approval events, allowing applications to reconstruct the allowance status for
 * all accounts just by listening to said events. Note that this isn't required by the specification, and other
 * compliant implementations may not do it.
 */
contract ERC20 is IERC20 {
    using SafeMath for uint256;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowed;

    uint256 private _totalSupply;

    /**
     * @dev Total number of tokens in existence
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner The address to query the balance of.
     * @return A uint256 representing the amount owned by the passed address.
     */
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }

    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param owner address The address which owns the funds.
     * @param spender address The address which will spend the funds.
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }

    /**
     * @dev Transfer token to a specified address
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * Beware that changing an allowance with this method brings the risk that someone may use both the old
     * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
     * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     */
    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev Transfer tokens from one address to another.
     * Note that while this function emits an Approval event, this is not required as per the specification,
     * and other compliant implementations may not emit the event.
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint256 the amount of tokens to be transferred
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender].sub(value));
        return true;
    }

    /**
     * @dev Increase the amount of tokens that an owner allowed to a spender.
     * approve should be called when _allowed[msg.sender][spender] == 0. To increment
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * Emits an Approval event.
     * @param spender The address which will spend the funds.
     * @param addedValue The amount of tokens to increase the allowance by.
     */
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Decrease the amount of tokens that an owner allowed to a spender.
     * approve should be called when _allowed[msg.sender][spender] == 0. To decrement
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * Emits an Approval event.
     * @param spender The address which will spend the funds.
     * @param subtractedValue The amount of tokens to decrease the allowance by.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowed[msg.sender][spender].sub(subtractedValue));
        return true;
    }

    /**
     * @dev Transfer token for a specified addresses
     * @param from The address to transfer from.
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     */
    function _transfer(address from, address to, uint256 value) internal {
        require(to != address(0));

        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
        emit Transfer(from, to, value);
    }

    /**
     * @dev Internal function that mints an amount of the token and assigns it to
     * an account. This encapsulates the modification of balances such that the
     * proper events are emitted.
     * @param account The account that will receive the created tokens.
     * @param value The amount that will be created.
     */
    function _mint(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.add(value);
        _balances[account] = _balances[account].add(value);
        emit Transfer(address(0), account, value);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account.
     * @param account The account whose tokens will be burnt.
     * @param value The amount that will be burnt.
     */
    function _burn(address account, uint256 value) internal {
        require(account != address(0));

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(0), value);
    }

    /**
     * @dev Approve an address to spend another addresses' tokens.
     * @param owner The address that owns the tokens.
     * @param spender The address that will spend the tokens.
     * @param value The number of tokens that can be spent.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        require(spender != address(0));
        require(owner != address(0));

        _allowed[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account, deducting from the sender's allowance for said account. Uses the
     * internal burn function.
     * Emits an Approval event (reflecting the reduced allowance).
     * @param account The account whose tokens will be burnt.
     * @param value The amount that will be burnt.
     */
    function _burnFrom(address account, uint256 value) internal {
        _burn(account, value);
        _approve(account, msg.sender, _allowed[account][msg.sender].sub(value));
    }
}

// File: contracts/common/tokens/WETH.sol

pragma solidity ^0.5.2;



contract WETH is ERC20 {
  event Deposit(address indexed dst, uint256 wad);
  event Withdrawal(address indexed src, uint256 wad);

  function deposit() public payable;

  function withdraw(uint256 wad) public;

  function withdraw(uint256 wad, address user) public;
}

// File: contracts/root/depositManager/IDepositManager.sol

pragma solidity ^0.5.2;

interface IDepositManager {
  function depositEther() external payable;
  function transferAssets(address _token, address  _user, uint256 _amountOrNFTId) external;
  function depositERC20(address _token, uint256 _amount) external;
  function depositERC721(address _token, uint256 _tokenId) external;
}

// File: solidity-rlp/contracts/RLPReader.sol

/*
* @author Hamdi Allam hamdi.allam97@gmail.com
* Please reach out with any questions or concerns
*/
pragma solidity ^0.5.0;

library RLPReader {
    uint8 constant STRING_SHORT_START = 0x80;
    uint8 constant STRING_LONG_START  = 0xb8;
    uint8 constant LIST_SHORT_START   = 0xc0;
    uint8 constant LIST_LONG_START    = 0xf8;
    uint8 constant WORD_SIZE = 32;

    struct RLPItem {
        uint len;
        uint memPtr;
    }

    struct Iterator {
        RLPItem item;   // Item that's being iterated over.
        uint nextPtr;   // Position of the next item in the list.
    }

    /*
    * @dev Returns the next element in the iteration. Reverts if it has not next element.
    * @param self The iterator.
    * @return The next element in the iteration.
    */
    function next(Iterator memory self) internal pure returns (RLPItem memory) {
        require(hasNext(self));

        uint ptr = self.nextPtr;
        uint itemLength = _itemLength(ptr);
        self.nextPtr = ptr + itemLength;

        return RLPItem(itemLength, ptr);
    }

    /*
    * @dev Returns true if the iteration has more elements.
    * @param self The iterator.
    * @return true if the iteration has more elements.
    */
    function hasNext(Iterator memory self) internal pure returns (bool) {
        RLPItem memory item = self.item;
        return self.nextPtr < item.memPtr + item.len;
    }

    /*
    * @param item RLP encoded bytes
    */
    function toRlpItem(bytes memory item) internal pure returns (RLPItem memory) {
        uint memPtr;
        assembly {
            memPtr := add(item, 0x20)
        }

        return RLPItem(item.length, memPtr);
    }

    /*
    * @dev Create an iterator. Reverts if item is not a list.
    * @param self The RLP item.
    * @return An 'Iterator' over the item.
    */
    function iterator(RLPItem memory self) internal pure returns (Iterator memory) {
        require(isList(self));

        uint ptr = self.memPtr + _payloadOffset(self.memPtr);
        return Iterator(self, ptr);
    }

    /*
    * @param item RLP encoded bytes
    */
    function rlpLen(RLPItem memory item) internal pure returns (uint) {
        return item.len;
    }

    /*
    * @param item RLP encoded bytes
    */
    function payloadLen(RLPItem memory item) internal pure returns (uint) {
        return item.len - _payloadOffset(item.memPtr);
    }

    /*
    * @param item RLP encoded list in bytes
    */
    function toList(RLPItem memory item) internal pure returns (RLPItem[] memory) {
        require(isList(item));

        uint items = numItems(item);
        RLPItem[] memory result = new RLPItem[](items);

        uint memPtr = item.memPtr + _payloadOffset(item.memPtr);
        uint dataLen;
        for (uint i = 0; i < items; i++) {
            dataLen = _itemLength(memPtr);
            result[i] = RLPItem(dataLen, memPtr); 
            memPtr = memPtr + dataLen;
        }

        return result;
    }

    // @return indicator whether encoded payload is a list. negate this function call for isData.
    function isList(RLPItem memory item) internal pure returns (bool) {
        if (item.len == 0) return false;

        uint8 byte0;
        uint memPtr = item.memPtr;
        assembly {
            byte0 := byte(0, mload(memPtr))
        }

        if (byte0 < LIST_SHORT_START)
            return false;
        return true;
    }

    /** RLPItem conversions into data types **/

    // @returns raw rlp encoding in bytes
    function toRlpBytes(RLPItem memory item) internal pure returns (bytes memory) {
        bytes memory result = new bytes(item.len);
        if (result.length == 0) return result;
        
        uint ptr;
        assembly {
            ptr := add(0x20, result)
        }

        copy(item.memPtr, ptr, item.len);
        return result;
    }

    // any non-zero byte is considered true
    function toBoolean(RLPItem memory item) internal pure returns (bool) {
        require(item.len == 1);
        uint result;
        uint memPtr = item.memPtr;
        assembly {
            result := byte(0, mload(memPtr))
        }

        return result == 0 ? false : true;
    }

    function toAddress(RLPItem memory item) internal pure returns (address) {
        // 1 byte for the length prefix
        require(item.len == 21);

        return address(toUint(item));
    }

    function toUint(RLPItem memory item) internal pure returns (uint) {
        require(item.len > 0 && item.len <= 33);

        uint offset = _payloadOffset(item.memPtr);
        uint len = item.len - offset;

        uint result;
        uint memPtr = item.memPtr + offset;
        assembly {
            result := mload(memPtr)

            // shfit to the correct location if neccesary
            if lt(len, 32) {
                result := div(result, exp(256, sub(32, len)))
            }
        }

        return result;
    }

    // enforces 32 byte length
    function toUintStrict(RLPItem memory item) internal pure returns (uint) {
        // one byte prefix
        require(item.len == 33);

        uint result;
        uint memPtr = item.memPtr + 1;
        assembly {
            result := mload(memPtr)
        }

        return result;
    }

    function toBytes(RLPItem memory item) internal pure returns (bytes memory) {
        require(item.len > 0);

        uint offset = _payloadOffset(item.memPtr);
        uint len = item.len - offset; // data length
        bytes memory result = new bytes(len);

        uint destPtr;
        assembly {
            destPtr := add(0x20, result)
        }

        copy(item.memPtr + offset, destPtr, len);
        return result;
    }

    /*
    * Private Helpers
    */

    // @return number of payload items inside an encoded list.
    function numItems(RLPItem memory item) private pure returns (uint) {
        if (item.len == 0) return 0;

        uint count = 0;
        uint currPtr = item.memPtr + _payloadOffset(item.memPtr);
        uint endPtr = item.memPtr + item.len;
        while (currPtr < endPtr) {
           currPtr = currPtr + _itemLength(currPtr); // skip over an item
           count++;
        }

        return count;
    }

    // @return entire rlp item byte length
    function _itemLength(uint memPtr) private pure returns (uint) {
        uint itemLen;
        uint byte0;
        assembly {
            byte0 := byte(0, mload(memPtr))
        }

        if (byte0 < STRING_SHORT_START)
            itemLen = 1;
        
        else if (byte0 < STRING_LONG_START)
            itemLen = byte0 - STRING_SHORT_START + 1;

        else if (byte0 < LIST_SHORT_START) {
            assembly {
                let byteLen := sub(byte0, 0xb7) // # of bytes the actual length is
                memPtr := add(memPtr, 1) // skip over the first byte
                
                /* 32 byte word size */
                let dataLen := div(mload(memPtr), exp(256, sub(32, byteLen))) // right shifting to get the len
                itemLen := add(dataLen, add(byteLen, 1))
            }
        }

        else if (byte0 < LIST_LONG_START) {
            itemLen = byte0 - LIST_SHORT_START + 1;
        } 

        else {
            assembly {
                let byteLen := sub(byte0, 0xf7)
                memPtr := add(memPtr, 1)

                let dataLen := div(mload(memPtr), exp(256, sub(32, byteLen))) // right shifting to the correct length
                itemLen := add(dataLen, add(byteLen, 1))
            }
        }

        return itemLen;
    }

    // @return number of bytes until the data
    function _payloadOffset(uint memPtr) private pure returns (uint) {
        uint byte0;
        assembly {
            byte0 := byte(0, mload(memPtr))
        }

        if (byte0 < STRING_SHORT_START) 
            return 0;
        else if (byte0 < STRING_LONG_START || (byte0 >= LIST_SHORT_START && byte0 < LIST_LONG_START))
            return 1;
        else if (byte0 < LIST_SHORT_START)  // being explicit
            return byte0 - (STRING_LONG_START - 1) + 1;
        else
            return byte0 - (LIST_LONG_START - 1) + 1;
    }

    /*
    * @param src Pointer to source
    * @param dest Pointer to destination
    * @param len Amount of memory to copy from the source
    */
    function copy(uint src, uint dest, uint len) private pure {
        if (len == 0) return;

        // copy as many word sizes as possible
        for (; len >= WORD_SIZE; len -= WORD_SIZE) {
            assembly {
                mstore(dest, mload(src))
            }

            src += WORD_SIZE;
            dest += WORD_SIZE;
        }

        // left over bytes. Mask is used to remove unwanted bytes from the word
        uint mask = 256 ** (WORD_SIZE - len) - 1;
        assembly {
            let srcpart := and(mload(src), not(mask)) // zero out src
            let destpart := and(mload(dest), mask) // retrieve the bytes
            mstore(dest, or(destpart, srcpart))
        }
    }
}

// File: contracts/common/misc/ProxyStorage.sol

pragma solidity ^0.5.2;



contract ProxyStorage is Ownable {
  address internal proxyTo;
}

// File: contracts/root/RootChainStorage.sol

pragma solidity ^0.5.2;




contract RootChainHeader {
  event NewHeaderBlock(
    address indexed proposer,
    uint256 indexed headerBlockId,
    uint256 indexed reward,
    uint256 start,
    uint256 end,
    bytes32 root
  );

  struct HeaderBlock {
    bytes32 root;
    uint256 start;
    uint256 end;
    uint256 createdAt;
    address proposer;
  }
}

contract RootChainStorage is ProxyStorage, RootChainHeader {
  bytes32 public heimdallId;
  uint8 public constant VOTE_TYPE = 2;

  uint16 internal constant MAX_DEPOSITS = 10000;
  uint256 internal _nextHeaderBlock = MAX_DEPOSITS;
  uint256 internal _blockDepositId = 1;
  mapping(uint256 => HeaderBlock) public headerBlocks;
  Registry internal registry;
}

// File: contracts/staking/IStakeManager.sol

pragma solidity ^0.5.2;


contract IStakeManager {
  event Staked(address indexed signer, uint256 indexed validatorId, uint256 indexed activationEpoch, uint256 amount, uint256 total);
  event Unstaked(address indexed user, uint256 indexed validatorId, uint256 amount, uint256 total);
   // event to ack unstaking which will start at deactivationEpoch
  event UnstakeInit(address indexed user, uint256 indexed validatorId, uint256 deactivationEpoch, uint256 indexed amount);

  event SignerChange(uint256 indexed validatorId, address indexed oldSigner, address indexed newSigner);
  event ReStaked(uint256 indexed validatorId, uint256 amount, uint256 total);
  event Jailed(uint256 indexed validatorId, uint256 indexed exitEpoch);
  event ThresholdChange(uint256 newThreshold, uint256 oldThreshold);
  event DynastyValueChange(uint256 newDynasty, uint256 oldDynasty);
  event RewardUpdate(uint256 newReward, uint256 oldReward);
  event StakeUpdate(uint256 indexed validatorId, uint256 indexed oldAmount, uint256 indexed newAmount);
  event ClaimRewards(uint256 indexed validatorId, uint256 indexed amount, uint256 indexed totalAmount);
  event StartAuction(uint256 indexed validatorId, uint256 indexed amount, uint256 indexed auctionAmount);
  event ConfirmAuction(uint256 indexed newValidatorId, uint256 indexed oldValidatorId, uint256 indexed amount);

  // Todo: fix WITHDRAWAL_DELAY with interface
  uint256 public WITHDRAWAL_DELAY = (2**13)/2; // unit: epoch
  // validator replacement
  function startAuction(uint256 validatorId, uint256 amount) external;
  function confirmAuctionBid(uint256 validatorId, address signer, bool isContract) external;

  function delegationTransfer(uint256 amount, address delegator) external;
  function stake(uint256 amount, address signer, bool isContract) external;
  function unstake(uint256 validatorId) external;
  function totalStakedFor(address addr) external view returns (uint256);
  function supportsHistory() external pure returns (bool);
  function stakeFor(address user, uint256 amount, address signer, bool isContract) public;
  function checkSignatures(uint256 blockInterval, bytes32 voteHash, bytes32 stateRoot, bytes memory sigs) public returns(uint256);
  function updateValidatorState(uint256 validatorId, uint256 epoch, int256 amount) public;

  // optional
  // function lastStakedFor(address addr) external view returns (uint256);
  // function totalStakedForAt(address addr, uint256 blockNumber) external view returns (uint256);
  // function totalStakedAt(uint256 blockNumber) external view returns (uint256);
}

// File: contracts/root/IRootChain.sol

pragma solidity ^0.5.2;

interface IRootChain {
  function slash() external;
  function submitHeaderBlock(bytes calldata vote, bytes calldata sigs, bytes calldata extradata) external;
  function getLastChildBlock() external view returns(uint256);
}

// File: contracts/root/RootChain.sol

pragma solidity ^0.5.2;









contract RootChain is RootChainStorage, IRootChain {
  using SafeMath for uint256;
  using RLPReader for bytes;
  using RLPReader for RLPReader.RLPItem;

  modifier onlyDepositManager() {
    require(
      msg.sender == registry.getDepositManagerAddress(),
      "UNAUTHORIZED_DEPOSIT_MANAGER_ONLY"
    );
    _;
  }

  constructor (address _registry, string memory _heimdallId) public {
    registry = Registry(_registry);
    heimdallId = keccak256(abi.encodePacked(_heimdallId));
  }

  function submitHeaderBlock(
    bytes calldata vote,
    bytes calldata sigs,
    bytes calldata txData)
    external
  {
    RLPReader.RLPItem[] memory dataList = vote.toRlpItem().toList();
    require(keccak256(dataList[0].toBytes()) == heimdallId, "Chain ID is invalid");
    require(dataList[1].toUint() == VOTE_TYPE, "Vote type is invalid");

    // validate hash of txData was signed as part of the vote
    require(keccak256(dataList[4].toBytes()) == keccak256(abi.encodePacked(sha256(txData))), "Extra data is invalid");

    RLPReader.RLPItem[] memory extraData = txData.toRlpItem().toList();
    extraData = extraData[0].toList();
    RootChainHeader.HeaderBlock memory headerBlock = _buildHeaderBlock(extraData);
    headerBlocks[_nextHeaderBlock] = headerBlock;
    // check if it is better to keep it in local storage instead
    IStakeManager stakeManager = IStakeManager(registry.getStakeManagerAddress());
    uint256 _reward = stakeManager.checkSignatures(headerBlock.end.sub(headerBlock.start), keccak256(vote), bytes32(extraData[4].toUint()), sigs);

    emit NewHeaderBlock(headerBlock.proposer, _nextHeaderBlock, _reward, headerBlock.start, headerBlock.end, headerBlock.root);
    _nextHeaderBlock = _nextHeaderBlock.add(MAX_DEPOSITS);
    _blockDepositId = 1;
  }

  function updateDepositId(uint256 numDeposits)
    external
    onlyDepositManager
    returns(uint256 depositId)
  {
    depositId = currentHeaderBlock().add(_blockDepositId);
    // deposit ids will be (_blockDepositId, _blockDepositId + 1, .... _blockDepositId + numDeposits - 1)
    _blockDepositId = _blockDepositId.add(numDeposits);
    require(
      // Since _blockDepositId is initialized to 1; only (MAX_DEPOSITS - 1) deposits per header block are allowed
      _blockDepositId <= MAX_DEPOSITS,
      "TOO_MANY_DEPOSITS"
    );
  }

  function currentHeaderBlock() public view returns(uint256) {
    return _nextHeaderBlock.sub(MAX_DEPOSITS);
  }

  function getLastChildBlock() external view returns(uint256) {
    return headerBlocks[currentHeaderBlock()].end;
  }

  function slash() external {
    //TODO: future implementation
  }

  function _buildHeaderBlock(RLPReader.RLPItem[] memory dataList)
    private
    view
    returns(HeaderBlock memory headerBlock)
  {
    headerBlock.proposer = dataList[0].toAddress();
    // Is this required? Why does a proposer need to be the sender? Think validator relay networks
    // require(msg.sender == dataList[0].toAddress(), "Invalid proposer");

    uint256 nextChildBlock;
    /*
    The ID of the 1st header block is MAX_DEPOSITS.
    if _nextHeaderBlock == MAX_DEPOSITS, then the first header block is yet to be submitted, hence nextChildBlock = 0
    */
    if (_nextHeaderBlock > MAX_DEPOSITS) {
      nextChildBlock = headerBlocks[currentHeaderBlock()].end + 1;
    }

    // Commenting this out to make life easier to run tests using matic.js
    // require(
    //   nextChildBlock == dataList[1].toUint(),
    //   "INCORRECT_START_BLOCK"
    // );
    headerBlock.start = dataList[1].toUint();
    headerBlock.end = dataList[2].toUint();

    // toUintStrict returns the encoded uint. Encoded data must be padded to 32 bytes.
    headerBlock.root = bytes32(dataList[3].toUintStrict());
    headerBlock.createdAt = now;
  }
}

// File: contracts/root/stateSyncer/StateSender.sol

pragma solidity ^0.5.2;



contract StateSender is Ownable {
  using SafeMath for uint256;

  uint256 public counter;
  mapping(address => address) public registrations;

  event NewRegistration(address indexed user, address indexed sender, address indexed receiver);
  event RegistrationUpdated(address indexed user, address indexed sender, address indexed receiver);
  event StateSynced(uint256 indexed id, address indexed contractAddress, bytes data);

  modifier onlyRegistered(address receiver) {
    require(registrations[receiver] == msg.sender, "Invalid sender");
    _;
  }

  // register new contract for state sync
  function register(address sender, address receiver) public {
    require(
      isOwner() || registrations[receiver] == msg.sender,
      "StateSender.register: Not authorized to register"
    );
    registrations[receiver] = sender;
    if (registrations[receiver] == address(0)) {
      emit NewRegistration(msg.sender, sender, receiver);
    } else {
      emit RegistrationUpdated(msg.sender, sender, receiver);
    }
  }

  function syncState(address receiver, bytes calldata data) external onlyRegistered(receiver) {
    counter = counter.add(1);
    emit StateSynced(counter, receiver, data);
  }
}

// File: contracts/root/depositManager/DepositManagerStorage.sol

pragma solidity ^0.5.2;





contract DepositManagerHeader {
  event NewDepositBlock(
    address indexed owner,
    address indexed token,
    uint256 amountOrNFTId,
    uint256 depositBlockId
  );

  struct DepositBlock {
    bytes32 depositHash;
    uint256 createdAt;
  }
}


contract DepositManagerStorage is ProxyStorage, DepositManagerHeader {
  Registry internal registry;
  RootChain internal rootChain;
  StateSender public stateSender;

  mapping(uint256 => DepositBlock) public deposits;

  address public childChain;
}

// File: contracts/root/depositManager/DepositManager.sol

pragma solidity ^0.5.2;












contract DepositManager is DepositManagerStorage, IDepositManager, IERC721Receiver, ContractReceiver {
  using SafeMath for uint256;

  modifier isTokenMapped(address _token) {
    require(registry.isTokenMapped(_token), "TOKEN_NOT_SUPPORTED");
    _;
  }

  modifier isPredicateAuthorized() {
    require(
      uint8(registry.predicates(msg.sender)) != 0,
      "Not a valid predicate"
    );
    _;
  }

  // deposit ETH by sending to this contract
  function () external payable {
    depositEther();
  }

  /**
   * @dev Caches childChain and stateSender (frequently used variables) from registry
   */
  function updateChildChainAndStateSender() public {
    (address _childChain, address _stateSender) = registry.getChildChainAndStateSender();
    require(
      _stateSender != address(stateSender) || _childChain != childChain,
      "Atleast one of stateSender or childChain address should change"
    );
    childChain = _childChain;
    stateSender = StateSender(_stateSender);
  }

  function transferAssets(address _token, address _user, uint256 _amountOrNFTId)
    external
    isPredicateAuthorized
  {
    address wethToken = registry.getWethTokenAddress();
    if (registry.isERC721(_token)) {
      IERC721(_token).transferFrom(address(this), _user, _amountOrNFTId);
    } else if (_token == wethToken) {
      WETH t = WETH(_token);
      t.withdraw(_amountOrNFTId, _user);
    } else {
      require(
        IERC20(_token).transfer(_user, _amountOrNFTId),
        "TRANSFER_FAILED"
      );
    }
  }

  function depositERC20(address _token, uint256 _amount)
    external
  {
    depositERC20ForUser(_token, msg.sender, _amount);
  }

  function depositERC721(address _token, uint256 _tokenId)
    external
  {
    depositERC721ForUser(_token, msg.sender, _tokenId);
  }

  function depositBulk(address[] calldata _tokens, uint256[] calldata _amountOrTokens, address _user)
    external
  {
    require(
      _tokens.length == _amountOrTokens.length,
      "Invalid Input"
    );
    uint256 depositId = rootChain.updateDepositId(_tokens.length);

    for (uint256 i = 0; i < _tokens.length; i++) {
      // will revert if token is not mapped
      if (registry.isTokenMappedAndIsErc721(_tokens[i])) {
        IERC721(_tokens[i]).transferFrom(msg.sender, address(this), _amountOrTokens[i]);
      } else {
        require(
          IERC20(_tokens[i]).transferFrom(msg.sender, address(this), _amountOrTokens[i]),
          "TOKEN_TRANSFER_FAILED"
        );
      }
      _createDepositBlock(_user, _tokens[i], _amountOrTokens[i], depositId);
      depositId = depositId.add(1);
    }
  }

  function depositERC20ForUser(address _token, address _user, uint256 _amount)
    public
  {
    require(
      IERC20(_token).transferFrom(msg.sender, address(this), _amount),
      "TOKEN_TRANSFER_FAILED"
    );
    _safeCreateDepositBlock(_user, _token, _amount);
  }

  function depositERC721ForUser(address _token, address _user, uint256 _tokenId)
    public
  {
    IERC721(_token).transferFrom(msg.sender, address(this), _tokenId);
    _safeCreateDepositBlock(_user, _token, _tokenId);
  }

  // @todo: write depositEtherForUser
  function depositEther()
    public
    payable
  {
    address wethToken = registry.getWethTokenAddress();
    WETH t = WETH(wethToken);
    t.deposit.value(msg.value)();
    _safeCreateDepositBlock(msg.sender, wethToken, msg.value);
  }

  /**
   * @notice This will be invoked when safeTransferFrom is called on the token contract to deposit tokens to this contract
     without directly interacting with it
   * @dev msg.sender is the token contract
   * _operator The address which called `safeTransferFrom` function on the token contract
   * @param _user The address which previously owned the token
   * @param _tokenId The NFT identifier which is being transferred
   * _data Additional data with no specified format
   * @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
   */
  function onERC721Received(address /* _operator */, address _user, uint256 _tokenId, bytes memory /* _data */)
    public
    returns (bytes4)
  {
    // the ERC721 contract address is the message sender
    _safeCreateDepositBlock(_user, msg.sender /* token */, _tokenId);
    return 0x150b7a02;
  }

  // See https://github.com/ethereum/EIPs/issues/223
  function tokenFallback(address _user, uint256 _amount, bytes memory /* _data */)
  public
  {
    _safeCreateDepositBlock(_user, msg.sender /* token */, _amount);
  }

  function _safeCreateDepositBlock(address _user, address _token, uint256 _amountOrToken)
    internal
    isTokenMapped(_token)
  {
    _createDepositBlock(_user, _token, _amountOrToken, rootChain.updateDepositId(1) /* returns _depositId */);
  }

  function _createDepositBlock(address _user, address _token, uint256 _amountOrToken, uint256 _depositId)
    internal
  {
    deposits[_depositId] = DepositBlock(keccak256(abi.encodePacked(_user, _token, _amountOrToken)), now);
    stateSender.syncState(childChain, abi.encode(_user, _token, _amountOrToken, _depositId));
    emit NewDepositBlock(_user, _token, _amountOrToken, _depositId);
  }
}
