// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol

// pragma solidity ^0.6.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * // importANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol

// pragma solidity ^0.6.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/utils/Address.sol

// pragma solidity ^0.6.2;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [// importANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * // importANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol

// pragma solidity ^0.6.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/Address.sol";

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for ERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(value);
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(value, "SafeERC20: decreased allowance below zero");
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves.

        // A Solidity high level call has three parts:
        //  1. The target address is checked to verify it contains contract code
        //  2. The call itself is made, and success asserted
        //  3. The return value is decoded, which in turn checks the size of the returned data.
        // solhint-disable-next-line max-line-length
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// Dependency file: contracts/external/maker/DaiInterface.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity ^0.6.12;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

interface DaiInterface is IERC20 {
    // --- Approve by signature ---
  function permit(address holder, address spender, uint256 nonce, uint256 expiry, bool allowed, uint8 v, bytes32 r, bytes32 s) external;
  function transferFrom(address src, address dst, uint wad) external override returns (bool);
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/Initializable.sol

// pragma solidity >=0.4.24 <0.7.0;


/**
 * @title Initializable
 *
 * @dev Helper contract to support initializer functions. To use it, replace
 * the constructor with a function that has the `initializer` modifier.
 * WARNING: Unlike constructors, initializer functions must be manually
 * invoked. This applies both to deploying an Initializable contract, as well
 * as extending an Initializable contract via inheritance.
 * WARNING: When used with inheritance, manual care must be taken to not invoke
 * a parent initializer twice, or ensure that all initializers are idempotent,
 * because this is not dealt with automatically as with constructors.
 */
contract Initializable {

  /**
   * @dev Indicates that the contract has been initialized.
   */
  bool private initialized;

  /**
   * @dev Indicates that the contract is in the process of being initialized.
   */
  bool private initializing;

  /**
   * @dev Modifier to use in the initializer function of a contract.
   */
  modifier initializer() {
    require(initializing || isConstructor() || !initialized, "Contract instance has already been initialized");

    bool isTopLevelCall = !initializing;
    if (isTopLevelCall) {
      initializing = true;
      initialized = true;
    }

    _;

    if (isTopLevelCall) {
      initializing = false;
    }
  }

  /// @dev Returns true if and only if the function is running in the constructor
  function isConstructor() private view returns (bool) {
    // extcodesize checks the size of the code stored in an address, and
    // address returns the current address. Since the code is still not
    // deployed when running a constructor, any checks on its code size will
    // yield zero, making it an effective way to detect if a contract is
    // under construction or not.
    address self = address(this);
    uint256 cs;
    assembly { cs := extcodesize(self) }
    return cs == 0;
  }

  // Reserved storage space to allow for layout changes in the future.
  uint256[50] private ______gap;
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol

// pragma solidity ^0.6.0;
// import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract ContextUpgradeSafe is Initializable {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.

    function __Context_init() internal initializer {
        __Context_init_unchained();
    }

    function __Context_init_unchained() internal initializer {


    }


    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }

    uint256[50] private __gap;
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol

// pragma solidity ^0.6.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract OwnableUpgradeSafe is Initializable, ContextUpgradeSafe {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */

    function __Ownable_init() internal initializer {
        __Context_init_unchained();
        __Ownable_init_unchained();
    }

    function __Ownable_init_unchained() internal initializer {


        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);

    }


    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    uint256[49] private __gap;
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/utils/SafeCast.sol

// pragma solidity ^0.6.0;


/**
 * @dev Wrappers over Solidity's uintXX casting operators with added overflow
 * checks.
 *
 * Downcasting from uint256 in Solidity does not revert on overflow. This can
 * easily result in undesired exploitation or bugs, since developers usually
 * assume that overflows raise errors. `SafeCast` restores this intuition by
 * reverting the transaction when such an operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 *
 * Can be combined with {SafeMath} to extend it to smaller types, by performing
 * all math on `uint256` and then downcasting.
 */
library SafeCast {

    /**
     * @dev Returns the downcasted uint128 from uint256, reverting on
     * overflow (when the input is greater than largest uint128).
     *
     * Counterpart to Solidity's `uint128` operator.
     *
     * Requirements:
     *
     * - input must fit into 128 bits
     */
    function toUint128(uint256 value) internal pure returns (uint128) {
        require(value < 2**128, "SafeCast: value doesn\'t fit in 128 bits");
        return uint128(value);
    }

    /**
     * @dev Returns the downcasted uint64 from uint256, reverting on
     * overflow (when the input is greater than largest uint64).
     *
     * Counterpart to Solidity's `uint64` operator.
     *
     * Requirements:
     *
     * - input must fit into 64 bits
     */
    function toUint64(uint256 value) internal pure returns (uint64) {
        require(value < 2**64, "SafeCast: value doesn\'t fit in 64 bits");
        return uint64(value);
    }

    /**
     * @dev Returns the downcasted uint32 from uint256, reverting on
     * overflow (when the input is greater than largest uint32).
     *
     * Counterpart to Solidity's `uint32` operator.
     *
     * Requirements:
     *
     * - input must fit into 32 bits
     */
    function toUint32(uint256 value) internal pure returns (uint32) {
        require(value < 2**32, "SafeCast: value doesn\'t fit in 32 bits");
        return uint32(value);
    }

    /**
     * @dev Returns the downcasted uint16 from uint256, reverting on
     * overflow (when the input is greater than largest uint16).
     *
     * Counterpart to Solidity's `uint16` operator.
     *
     * Requirements:
     *
     * - input must fit into 16 bits
     */
    function toUint16(uint256 value) internal pure returns (uint16) {
        require(value < 2**16, "SafeCast: value doesn\'t fit in 16 bits");
        return uint16(value);
    }

    /**
     * @dev Returns the downcasted uint8 from uint256, reverting on
     * overflow (when the input is greater than largest uint8).
     *
     * Counterpart to Solidity's `uint8` operator.
     *
     * Requirements:
     *
     * - input must fit into 8 bits.
     */
    function toUint8(uint256 value) internal pure returns (uint8) {
        require(value < 2**8, "SafeCast: value doesn\'t fit in 8 bits");
        return uint8(value);
    }

    /**
     * @dev Converts a signed int256 into an unsigned uint256.
     *
     * Requirements:
     *
     * - input must be greater than or equal to 0.
     */
    function toUint256(int256 value) internal pure returns (uint256) {
        require(value >= 0, "SafeCast: value must be positive");
        return uint256(value);
    }

    /**
     * @dev Converts an unsigned uint256 into a signed int256.
     *
     * Requirements:
     *
     * - input must be less than or equal to maxInt256.
     */
    function toInt256(uint256 value) internal pure returns (int256) {
        require(value < 2**255, "SafeCast: value doesn't fit in an int256");
        return int256(value);
    }
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol

// pragma solidity ^0.6.0;
// import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
contract ReentrancyGuardUpgradeSafe is Initializable {
    bool private _notEntered;


    function __ReentrancyGuard_init() internal initializer {
        __ReentrancyGuard_init_unchained();
    }

    function __ReentrancyGuard_init_unchained() internal initializer {


        // Storing an initial non-zero value makes deployment a bit more
        // expensive, but in exchange the refund on every call to nonReentrant
        // will be lower in amount. Since refunds are capped to a percetange of
        // the total transaction's gas, it is best to keep them low in cases
        // like this one, to increase the likelihood of the full refund coming
        // into effect.
        _notEntered = true;

    }


    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _notEntered = false;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }

    uint256[49] private __gap;
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/introspection/IERC165.sol

// pragma solidity ^0.6.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721.sol

// pragma solidity ^0.6.2;

// import "@openzeppelin/contracts-ethereum-package/contracts/introspection/IERC165.sol";

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of NFTs in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     *
     *
     * Requirements:
     * - `from`, `to` cannot be zero.
     * - `tokenId` must be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this
     * NFT by either {approve} or {setApprovalForAll}.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    /**
     * @dev Transfers a specific NFT (`tokenId`) from one account (`from`) to
     * another (`to`).
     *
     * Requirements:
     * - If the caller is not `from`, it must be approved to move this NFT by
     * either {approve} or {setApprovalForAll}.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);


    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}


// Dependency file: contracts/external/pooltogether/FixedPoint.sol

// SPDX-License-Identifier: GPL-3.0
// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";

/**
 * @author Brendan Asselstine
 * @notice Provides basic fixed point math calculations.
 *
 * This library calculates integer fractions by scaling values by 1e18 then performing standard integer math.
 */
library FixedPoint {
    using SafeMath for uint256;

    // The scale to use for fixed point numbers.  Same as Ether for simplicity.
    uint256 internal constant SCALE = 1e18;

    /**
        * Calculates a Fixed18 mantissa given the numerator and denominator
        *
        * The mantissa = (numerator * 1e18) / denominator
        *
        * @param numerator The mantissa numerator
        * @param denominator The mantissa denominator
        * @return The mantissa of the fraction
        */
    function calculateMantissa(uint256 numerator, uint256 denominator) internal pure returns (uint256) {
        uint256 mantissa = numerator.mul(SCALE);
        mantissa = mantissa.div(denominator);
        return mantissa;
    }

    /**
        * Multiplies a Fixed18 number by an integer.
        *
        * @param b The whole integer to multiply
        * @param mantissa The Fixed18 number
        * @return An integer that is the result of multiplying the params.
        */
    function multiplyUintByMantissa(uint256 b, uint256 mantissa) internal pure returns (uint256) {
        uint256 result = mantissa.mul(b);
        result = result.div(SCALE);
        return result;
    }

    /**
    * Divides an integer by a fixed point 18 mantissa
    *
    * @param dividend The integer to divide
    * @param mantissa The fixed point 18 number to serve as the divisor
    * @return An integer that is the result of dividing an integer by a fixed point 18 mantissa
    */
    function divideUintByMantissa(uint256 dividend, uint256 mantissa) internal pure returns (uint256) {
        uint256 result = SCALE.mul(dividend);
        result = result.div(mantissa);
        return result;
    }
}


// Dependency file: contracts/reserve/ReserveInterface.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.5.0 <0.7.0;

/// @title Interface that allows a user to draw an address using an index
interface ReserveInterface {
  function reserveRateMantissa(address prizePool) external view returns (uint256);
}


// Dependency file: contracts/prize-pool/YieldSource.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

/// @title Defines the functions used to interact with a yield source.  The Prize Pool inherits this contract.
/// @notice Prize Pools subclasses need to implement this interface so that yield can be generated.
abstract contract YieldSource {
  /// @notice Determines whether the passed token can be transferred out as an external award.
  /// @dev Different yield sources will hold the deposits as another kind of token: such a Compound's cToken.  The
  /// prize strategy should not be allowed to move those tokens.
  /// @param _externalToken The address of the token to check
  /// @return True if the token may be awarded, false otherwise
  function _canAwardExternal(address _externalToken) internal virtual view returns (bool);

  /// @notice Returns the ERC20 asset token used for deposits.
  /// @return The ERC20 asset token
  function _token() internal virtual view returns (IERC20);

  /// @notice Returns the total balance (in asset tokens).  This includes the deposits and interest.
  /// @return The underlying balance of asset tokens
  function _balance() internal virtual returns (uint256);

  /// @notice Supplies asset tokens to the yield source.
  /// @param mintAmount The amount of asset tokens to be supplied
  function _supply(uint256 mintAmount) internal virtual;

  /// @notice Redeems asset tokens from the yield source.
  /// @param redeemAmount The amount of yield-bearing tokens to be redeemed
  /// @return The actual amount of tokens that were redeemed.
  function _redeem(uint256 redeemAmount) internal virtual returns (uint256);
}


// Dependency file: contracts/token/TokenListenerInterface.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.5.0 <0.7.0;

/// @title An interface that allows a contract to listen to token mint, transfer and burn events.
interface TokenListenerInterface {
  /// @notice Called when tokens are minted.
  /// @param to The address of the receiver of the minted tokens.
  /// @param amount The amount of tokens being minted
  /// @param controlledToken The address of the token that is being minted
  /// @param referrer The address that referred the minting.
  function beforeTokenMint(address to, uint256 amount, address controlledToken, address referrer) external;

  /// @notice Called when tokens are transferred or burned.
  /// @param from The address of the sender of the token transfer
  /// @param to The address of the receiver of the token transfer.  Will be the zero address if burning.
  /// @param amount The amount of tokens transferred
  /// @param controlledToken The address of the token that was transferred
  function beforeTokenTransfer(address from, address to, uint256 amount, address controlledToken) external;
}

// Dependency file: @openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol

// pragma solidity ^0.6.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/Address.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20MinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin guidelines: functions revert instead
 * of returning `false` on failure. This behavior is nonetheless conventional
 * and does not conflict with the expectations of ERC20 applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20UpgradeSafe is Initializable, ContextUpgradeSafe, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    /**
     * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
     * a default value of 18.
     *
     * To select a different value for {decimals}, use {_setupDecimals}.
     *
     * All three of these values are immutable: they can only be set once during
     * construction.
     */

    function __ERC20_init(string memory name, string memory symbol) internal initializer {
        __Context_init_unchained();
        __ERC20_init_unchained(name, symbol);
    }

    function __ERC20_init_unchained(string memory name, string memory symbol) internal initializer {


        _name = name;
        _symbol = symbol;
        _decimals = 18;

    }


    /**
     * @dev Returns the name of the token.
     */
    function name() public view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless {_setupDecimals} is
     * called.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Sets {decimals} to a value other than the default one of 18.
     *
     * WARNING: This function should only be called from the constructor. Most
     * applications that interact with token contracts will not expect
     * {decimals} to ever change, and may work incorrectly if it does.
     */
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }

    uint256[44] private __gap;
}


// Dependency file: @opengsn/gsn/contracts/interfaces/IRelayRecipient.sol

// SPDX-License-Identifier:MIT
// pragma solidity ^0.6.2;

/**
 * a contract must implement this interface in order to support relayed transaction.
 * It is better to inherit the BaseRelayRecipient as its implementation.
 */
abstract contract IRelayRecipient {

    /**
     * return if the forwarder is trusted to forward relayed transactions to us.
     * the forwarder is required to verify the sender's signature, and verify
     * the call is not a replay.
     */
    function isTrustedForwarder(address forwarder) public virtual view returns(bool);

    /**
     * return the sender of this call.
     * if the call came through our trusted forwarder, then the real sender is appended as the last 20 bytes
     * of the msg.data.
     * otherwise, return `msg.sender`
     * should be used in the contract anywhere instead of msg.sender
     */
    function _msgSender() internal virtual view returns (address payable);

    /**
     * return the msg.data of this call.
     * if the call came through our trusted forwarder, then the real sender was appended as the last 20 bytes
     * of the msg.data - so this method will strip those 20 bytes off.
     * otherwise, return `msg.data`
     * should be used in the contract instead of msg.data, where the difference matters (e.g. when explicitly
     * signing or hashing the
     */
    function _msgData() internal virtual view returns (bytes memory);

    function versionRecipient() external virtual view returns (string memory);
}


// Dependency file: @opengsn/gsn/contracts/BaseRelayRecipient.sol

// SPDX-License-Identifier:MIT
// solhint-disable no-inline-assembly
// pragma solidity ^0.6.2;

// import "@opengsn/gsn/contracts/interfaces/IRelayRecipient.sol";

/**
 * A base contract to be inherited by any contract that want to receive relayed transactions
 * A subclass must use "_msgSender()" instead of "msg.sender"
 */
abstract contract BaseRelayRecipient is IRelayRecipient {

    /*
     * Forwarder singleton we accept calls from
     */
    address public trustedForwarder;

    function isTrustedForwarder(address forwarder) public override view returns(bool) {
        return forwarder == trustedForwarder;
    }

    /**
     * return the sender of this call.
     * if the call came through our trusted forwarder, return the original sender.
     * otherwise, return `msg.sender`.
     * should be used in the contract anywhere instead of msg.sender
     */
    function _msgSender() internal override virtual view returns (address payable ret) {
        if (msg.data.length >= 24 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // so we trust that the last bytes of msg.data are the verified sender address.
            // extract sender address from the end of msg.data
            assembly {
                ret := shr(96,calldataload(sub(calldatasize(),20)))
            }
        } else {
            return msg.sender;
        }
    }

    /**
     * return the msg.data of this call.
     * if the call came through our trusted forwarder, then the real sender was appended as the last 20 bytes
     * of the msg.data - so this method will strip those 20 bytes off.
     * otherwise, return `msg.data`
     * should be used in the contract instead of msg.data, where the difference matters (e.g. when explicitly
     * signing or hashing the
     */
    function _msgData() internal override virtual view returns (bytes memory ret) {
        if (msg.data.length >= 24 && isTrustedForwarder(msg.sender)) {
            // At this point we know that the sender is a trusted forwarder,
            // we copy the msg.data , except the last 20 bytes (and update the total length)
            assembly {
                let ptr := mload(0x40)
                // copy only size-20 bytes
                let size := sub(calldatasize(),20)
                // structure RLP data as <offset> <length> <bytes>
                mstore(ptr, 0x20)
                mstore(add(ptr,32), size)
                calldatacopy(add(ptr,64), 0, size)
                return(ptr, add(size,64))
            }
        } else {
            return msg.data;
        }
    }
}


// Dependency file: contracts/utils/RelayRecipient.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@opengsn/gsn/contracts/BaseRelayRecipient.sol";

contract RelayRecipient is BaseRelayRecipient {
  function versionRecipient() external override view returns (string memory) {
    return "2.0.0";
  }
}


// Dependency file: contracts/token/TokenControllerInterface.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.5.0 <0.7.0;

/// @title Controlled ERC20 Token Interface
/// @notice Required interface for Controlled ERC20 Tokens linked to a Prize Pool
/// @dev Defines the spec required to be implemented by a Controlled ERC20 Token
interface TokenControllerInterface {

  /// @dev Controller hook to provide notifications & rule validations on token transfers to the controller.
  /// This includes minting and burning.
  /// @param from Address of the account sending the tokens (address(0x0) on minting)
  /// @param to Address of the account receiving the tokens (address(0x0) on burning)
  /// @param amount Amount of tokens being transferred
  function beforeTokenTransfer(address from, address to, uint256 amount) external;
}


// Dependency file: contracts/token/ControlledToken.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";

// import "contracts/utils/RelayRecipient.sol";
// import "contracts/token/TokenControllerInterface.sol";

/// @title Controlled ERC20 Token
/// @notice ERC20 Tokens with a controller for minting & burning
contract ControlledToken is RelayRecipient, ERC20UpgradeSafe {

  /// @notice Interface to the contract responsible for controlling mint/burn
  TokenControllerInterface public controller;

  /// @notice Initializes the Controlled Token with Token Details and the Controller
  /// @param _name The name of the Token
  /// @param _symbol The symbol for the Token
  /// @param _decimals The number of decimals for the Token
  /// @param _trustedForwarder Address of the Forwarding Contract for GSN Meta-Txs
  /// @param _controller Address of the Controller contract for minting & burning
  function initialize(
    string memory _name,
    string memory _symbol,
    uint8 _decimals,
    address _trustedForwarder,
    TokenControllerInterface _controller
  )
    public
    virtual
    initializer
  {
    trustedForwarder = _trustedForwarder;
    __ERC20_init(_name, _symbol);
    controller = _controller;
    _setupDecimals(_decimals);
  }

  /// @notice Allows the controller to mint tokens for a user account
  /// @dev May be overridden to provide more granular control over minting
  /// @param _user Address of the receiver of the minted tokens
  /// @param _amount Amount of tokens to mint
  function controllerMint(address _user, uint256 _amount) external virtual onlyController {
    _mint(_user, _amount);
  }

  /// @notice Allows the controller to burn tokens from a user account
  /// @dev May be overridden to provide more granular control over burning
  /// @param _user Address of the holder account to burn tokens from
  /// @param _amount Amount of tokens to burn
  function controllerBurn(address _user, uint256 _amount) external virtual onlyController {
    _burn(_user, _amount);
  }

  /// @notice Allows an operator via the controller to burn tokens on behalf of a user account
  /// @dev May be overridden to provide more granular control over operator-burning
  /// @param _operator Address of the operator performing the burn action via the controller contract
  /// @param _user Address of the holder account to burn tokens from
  /// @param _amount Amount of tokens to burn
  function controllerBurnFrom(address _operator, address _user, uint256 _amount) external virtual onlyController {
    if (_operator != _user) {
      uint256 decreasedAllowance = allowance(_user, _operator).sub(_amount, "ControlledToken/exceeds-allowance");
      _approve(_user, _operator, decreasedAllowance);
    }
    _burn(_user, _amount);
  }

  /// @dev Function modifier to ensure that the caller is the controller contract
  modifier onlyController {
    require(_msgSender() == address(controller), "ControlledToken/only-controller");
    _;
  }

  /// @dev Controller hook to provide notifications & rule validations on token transfers to the controller.
  /// This includes minting and burning.
  /// May be overridden to provide more granular control over operator-burning
  /// @param from Address of the account sending the tokens (address(0x0) on minting)
  /// @param to Address of the account receiving the tokens (address(0x0) on burning)
  /// @param amount Amount of tokens being transferred
  function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
    controller.beforeTokenTransfer(from, to, amount);
  }

  /// @dev Provides information about the current execution context for GSN Meta-Txs.
  /// @return The payable address of the message sender
  function _msgSender()
    internal
    override(BaseRelayRecipient, ContextUpgradeSafe)
    virtual
    view
    returns (address payable)
  {
    return BaseRelayRecipient._msgSender();
  }

  /// @dev Provides information about the current execution context for GSN Meta-Txs.
  /// @return The payable address of the message sender
  function _msgData()
    internal
    override(BaseRelayRecipient, ContextUpgradeSafe)
    virtual
    view
    returns (bytes memory)
  {
    return BaseRelayRecipient._msgData();
  }
}


// Dependency file: contracts/utils/MappedSinglyLinkedList.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

/// @notice An efficient implementation of a singly linked list of addresses
/// @dev A mapping(address => address) tracks the 'next' pointer.  A special address called the SENTINEL is used to denote the beginning and end of the list.
library MappedSinglyLinkedList {

  /// @notice The special value address used to denote the end of the list
  address public constant SENTINEL = address(0x1);

  /// @notice The data structure to use for the list.
  struct Mapping {
    uint256 count;

    mapping(address => address) addressMap;
  }

  /// @notice Initializes the list.
  /// @dev It is // important that this is called so that the SENTINEL is correctly setup.
  function initialize(Mapping storage self) internal {
    require(self.count == 0, "Already init");
    self.addressMap[SENTINEL] = SENTINEL;
  }

  function start(Mapping storage self) internal view returns (address) {
    return self.addressMap[SENTINEL];
  }

  function next(Mapping storage self, address current) internal view returns (address) {
    return self.addressMap[current];
  }

  function end(Mapping storage) internal pure returns (address) {
    return SENTINEL;
  }

  function addAddresses(Mapping storage self, address[] memory addresses) internal {
    for (uint256 i = 0; i < addresses.length; i++) {
      addAddress(self, addresses[i]);
    }
  }

  /// @notice Adds an address to the front of the list.
  /// @param self The Mapping struct that this function is attached to
  /// @param newAddress The address to shift to the front of the list
  function addAddress(Mapping storage self, address newAddress) internal {
    require(newAddress != SENTINEL && newAddress != address(0), "Invalid address");
    require(self.addressMap[newAddress] == address(0), "Already added");
    self.addressMap[newAddress] = self.addressMap[SENTINEL];
    self.addressMap[SENTINEL] = newAddress;
    self.count = self.count + 1;
  }

  /// @notice Removes an address from the list
  /// @param self The Mapping struct that this function is attached to
  /// @param prevAddress The address that precedes the address to be removed.  This may be the SENTINEL if at the start.
  /// @param addr The address to remove from the list.
  function removeAddress(Mapping storage self, address prevAddress, address addr) internal {
    require(addr != SENTINEL && addr != address(0), "Invalid address");
    require(self.addressMap[prevAddress] == addr, "Invalid prevAddress");
    self.addressMap[prevAddress] = self.addressMap[addr];
    delete self.addressMap[addr];
    self.count = self.count - 1;
  }

  /// @notice Determines whether the list contains the given address
  /// @param self The Mapping struct that this function is attached to
  /// @param addr The address to check
  /// @return True if the address is contained, false otherwise.
  function contains(Mapping storage self, address addr) internal view returns (bool) {
    return addr != SENTINEL && addr != address(0) && self.addressMap[addr] != address(0);
  }

  /// @notice Returns an address array of all the addresses in this list
  /// @dev Contains a for loop, so complexity is O(n) wrt the list size
  /// @param self The Mapping struct that this function is attached to
  /// @return An array of all the addresses
  function addressArray(Mapping storage self) internal view returns (address[] memory) {
    address[] memory array = new address[](self.count);
    uint256 count;
    address currentAddress = self.addressMap[SENTINEL];
    while (currentAddress != address(0) && currentAddress != SENTINEL) {
      array[count] = currentAddress;
      currentAddress = self.addressMap[currentAddress];
      count++;
    }
    return array;
  }

  /// @notice Removes every address from the list
  /// @param self The Mapping struct that this function is attached to
  function clearAll(Mapping storage self) internal {
    address currentAddress = self.addressMap[SENTINEL];
    while (currentAddress != address(0) && currentAddress != SENTINEL) {
      address nextAddress = self.addressMap[currentAddress];
      delete self.addressMap[currentAddress];
      currentAddress = nextAddress;
    }
    self.addressMap[SENTINEL] = SENTINEL;
    self.count = 0;
  }
}


// Dependency file: contracts/prize-pool/PrizePoolInterface.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/SafeCast.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/ReentrancyGuard.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol";

// import "contracts/external/pooltogether/FixedPoint.sol";
// import "contracts/reserve/ReserveInterface.sol";
// import "contracts/prize-pool/YieldSource.sol";
// import "contracts/token/TokenListenerInterface.sol";
// import "contracts/token/ControlledToken.sol";
// import "contracts/token/TokenControllerInterface.sol";
// import "contracts/utils/MappedSinglyLinkedList.sol";
// import "contracts/utils/RelayRecipient.sol";

/// @title Escrows assets and deposits them into a yield source.  Exposes interest to Prize Strategy.  Users deposit and withdraw from this contract to participate in Prize Pool.
/// @notice Accounting is managed using Controlled Tokens, whose mint and burn functions can only be called by this contract.
/// @dev Must be inherited to provide specific yield-bearing asset control, such as Compound cTokens
interface PrizePoolInterface {

  /// @notice Deposit assets into the Prize Pool in exchange for tokens
  /// @param to The address receiving the newly minted tokens
  /// @param amount The amount of assets to deposit
  /// @param controlledToken The address of the type of token the user is minting
  /// @param referrer The referrer of the deposit
  function depositTo(
    address to,
    uint256 amount,
    address controlledToken,
    address referrer
  )
    external;

  /// @notice Withdraw assets from the Prize Pool instantly.  A fairness fee may be charged for an early exit.
  /// @param from The address to redeem tokens from.
  /// @param amount The amount of tokens to redeem for assets.
  /// @param controlledToken The address of the token to redeem (i.e. ticket or sponsorship)
  /// @param maximumExitFee The maximum exit fee the caller is willing to pay.  This should be pre-calculated by the calculateExitFee() fxn.
  /// @return The actual exit fee paid
  function withdrawInstantlyFrom(
    address from,
    uint256 amount,
    address controlledToken,
    uint256 maximumExitFee
  ) external returns (uint256);

  /// @notice Withdraw assets from the Prize Pool by placing them into the timelock.
  /// The timelock is used to ensure that the tickets have contributed their fair share of the prize.
  /// @dev Note that if the user has previously timelocked funds then this contract will try to sweep them.
  /// If the existing timelocked funds are still locked, then the incoming
  /// balance is added to their existing balance and the new timelock unlock timestamp will overwrite the old one.
  /// @param from The address to withdraw from
  /// @param amount The amount to withdraw
  /// @param controlledToken The type of token being withdrawn
  /// @return The timestamp from which the funds can be swept
  function withdrawWithTimelockFrom(
    address from,
    uint256 amount,
    address controlledToken
  ) external returns (uint256);

  function withdrawReserve(address to) external returns (uint256);

  /// @notice Returns the balance that is available to award.
  /// @dev captureAwardBalance() should be called first
  /// @return The total amount of assets to be awarded for the current prize
  function awardBalance() external view returns (uint256);

  /// @notice Captures any available interest as award balance.
  /// @dev This function also captures the reserve fees.
  /// @return The total amount of assets to be awarded for the current prize
  function captureAwardBalance() external returns (uint256);

  /// @notice Called by the prize strategy to award prizes.
  /// @dev The amount awarded must be less than the awardBalance()
  /// @param to The address of the winner that receives the award
  /// @param amount The amount of assets to be awarded
  /// @param controlledToken The address of the asset token being awarded
  function award(
    address to,
    uint256 amount,
    address controlledToken
  )
    external;

  /// @notice Called by the Prize-Strategy to transfer out external ERC20 tokens
  /// @dev Used to transfer out tokens held by the Prize Pool.  Could be liquidated, or anything.
  /// @param to The address of the winner that receives the award
  /// @param amount The amount of external assets to be awarded
  /// @param externalToken The address of the external asset token being awarded
  function transferExternalERC20(
    address to,
    address externalToken,
    uint256 amount
  )
    external;

  /// @notice Called by the Prize-Strategy to award external ERC20 prizes
  /// @dev Used to award any arbitrary tokens held by the Prize Pool
  /// @param to The address of the winner that receives the award
  /// @param amount The amount of external assets to be awarded
  /// @param externalToken The address of the external asset token being awarded
  function awardExternalERC20(
    address to,
    address externalToken,
    uint256 amount
  )
    external;

  /// @notice Called by the prize strategy to award external ERC721 prizes
  /// @dev Used to award any arbitrary NFTs held by the Prize Pool
  /// @param to The address of the winner that receives the award
  /// @param externalToken The address of the external NFT token being awarded
  /// @param tokenIds An array of NFT Token IDs to be transferred
  function awardExternalERC721(
    address to,
    address externalToken,
    uint256[] calldata tokenIds
  )
    external;

  /// @notice Sweep all timelocked balances and transfer unlocked assets to owner accounts
  /// @param users An array of account addresses to sweep balances for
  /// @return The total amount of assets swept from the Prize Pool
  function sweepTimelockBalances(
    address[] calldata users
  )
    external
    returns (uint256);

  /// @notice Calculates a timelocked withdrawal duration and credit consumption.
  /// @param from The user who is withdrawing
  /// @param amount The amount the user is withdrawing
  /// @param controlledToken The type of collateral the user is withdrawing (i.e. ticket or sponsorship)
  /// @return durationSeconds The duration of the timelock in seconds
  function calculateTimelockDuration(
    address from,
    address controlledToken,
    uint256 amount
  )
    external
    returns (
      uint256 durationSeconds,
      uint256 burnedCredit
    );

  /// @notice Calculates the early exit fee for the given amount
  /// @param from The user who is withdrawing
  /// @param controlledToken The type of collateral being withdrawn
  /// @param amount The amount of collateral to be withdrawn
  /// @return exitFee The exit fee
  /// @return burnedCredit The user's credit that was burned
  function calculateEarlyExitFee(
    address from,
    address controlledToken,
    uint256 amount
  )
    external
    returns (
      uint256 exitFee,
      uint256 burnedCredit
    );

  /// @notice Estimates the amount of time it will take for a given amount of funds to accrue the given amount of credit.
  /// @param _principal The principal amount on which interest is accruing
  /// @param _interest The amount of interest that must accrue
  /// @return durationSeconds The duration of time it will take to accrue the given amount of interest, in seconds.
  function estimateCreditAccrualTime(
    address _controlledToken,
    uint256 _principal,
    uint256 _interest
  )
    external
    view
    returns (uint256 durationSeconds);

  /// @notice Returns the credit balance for a given user.  Not that this includes both minted credit and pending credit.
  /// @param user The user whose credit balance should be returned
  /// @return The balance of the users credit
  function balanceOfCredit(address user, address controlledToken) external returns (uint256);

  /// @notice Sets the rate at which credit accrues per second.  The credit rate is a fixed point 18 number (like Ether).
  /// @param _controlledToken The controlled token for whom to set the credit plan
  /// @param _creditRateMantissa The credit rate to set.  Is a fixed point 18 decimal (like Ether).
  /// @param _creditLimitMantissa The credit limit to set.  Is a fixed point 18 decimal (like Ether).
  function setCreditPlanOf(
    address _controlledToken,
    uint128 _creditRateMantissa,
    uint128 _creditLimitMantissa
  )
    external;

  /// @notice Returns the credit rate of a controlled token
  /// @param controlledToken The controlled token to retrieve the credit rates for
  /// @return creditLimitMantissa The credit limit fraction.  This number is used to calculate both the credit limit and early exit fee.
  /// @return creditRateMantissa The credit rate. This is the amount of tokens that accrue per second.
  function creditPlanOf(
    address controlledToken
  )
    external
    view
    returns (
      uint128 creditLimitMantissa,
      uint128 creditRateMantissa
    );

  /// @notice Allows the Governor to set a cap on the amount of liquidity that he pool can hold
  /// @param _liquidityCap The new liquidity cap for the prize pool
  function setLiquidityCap(uint256 _liquidityCap) external;

  /// @notice Allows the Governor to add Controlled Tokens to the Prize Pool
  /// @param _controlledToken The address of the Controlled Token to add
  function addControlledToken(address _controlledToken) external;

  /// @notice Sets the prize strategy of the prize pool.  Only callable by the owner.
  /// @param _prizeStrategy The new prize strategy
  function setPrizeStrategy(TokenListenerInterface _prizeStrategy) external;

  /// @dev Returns the address of the underlying ERC20 asset
  /// @return The address of the asset
  function token() external view returns (IERC20);

  /// @notice An array of the Tokens controlled by the Prize Pool (ie. Tickets, Sponsorship)
  /// @return An array of controlled token addresses
  function tokens() external view returns (address[] memory);

  /// @notice The timestamp at which an account's timelocked balance will be made available to sweep
  /// @param user The address of an account with timelocked assets
  /// @return The timestamp at which the locked assets will be made available
  function timelockBalanceAvailableAt(address user) external view returns (uint256);

  /// @notice The balance of timelocked assets for an account
  /// @param user The address of an account with timelocked assets
  /// @return The amount of assets that have been timelocked
  function timelockBalanceOf(address user) external view returns (uint256);

  /// @notice The total of all controlled tokens and timelock.
  /// @return The current total of all tokens and timelock.
  function accountedBalance() external view returns (uint256);
}


// Root file: contracts/permit/PermitAndDepositDai.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.12;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/SafeERC20.sol";

// import "contracts/external/maker/DaiInterface.sol";
// import "contracts/prize-pool/PrizePoolInterface.sol";

/// @title Allows users to approve and deposit dai into a prize pool in a single transaction.
contract PermitAndDepositDai is OwnableUpgradeSafe {
  using SafeERC20 for DaiInterface;

  /// @notice Permits this contract to spend on a users behalf, and deposits into the prize pool.
  /// @dev The Dai permit params match the Dai#permit function, but it expects the `spender` to be
  /// the address of this contract.
  /// @param holder The address spending the tokens
  /// @param nonce The nonce of the tx.  Should be retrieved from the Dai token
  /// @param expiry The timestamp at which the sig expires
  /// @param allowed If true, then the spender is approving holder the max allowance.  False makes the allowance zero.
  /// @param v The `v` portion of the signature.
  /// @param r The `r` portion of the signature.
  /// @param s The `s` portion of the signature.
  /// @param prizePool The prize pool to deposit into
  /// @param to The address that will receive the controlled tokens
  /// @param amount The amount to deposit
  /// @param controlledToken The type of token to be minted in exchange (i.e. tickets or sponsorship)
  /// @param referrer The address that referred the deposit
  function permitAndDepositTo(
    // --- Approve by signature ---
    address dai, address holder, uint256 nonce, uint256 expiry, bool allowed, uint8 v, bytes32 r, bytes32 s,
    address prizePool, address to, uint256 amount, address controlledToken, address referrer
  ) external {
    require(msg.sender == holder, "PermitAndDepositDai/only-signer");
    DaiInterface(dai).permit(holder, address(this), nonce, expiry, allowed, v, r, s);
    _depositTo(dai, holder, prizePool, to, amount, controlledToken, referrer);
  }

  /// @notice Deposits into a Prize Pool from the sender.  Tokens will be transferred from the sender
  /// then deposited into the Pool on the sender's behalf.  This can be called after permitAndDepositTo is called,
  /// as this contract will have full approval for a user.
  /// @param prizePool The prize pool to deposit into
  /// @param to The address that will receive the controlled tokens
  /// @param amount The amount to deposit
  /// @param controlledToken The type of token to be minted in exchange (i.e. tickets or sponsorship)
  /// @param referrer The address that referred the deposit
  function depositTo(
    address dai,
    address prizePool,
    address to,
    uint256 amount,
    address controlledToken,
    address referrer
  ) external {
    _depositTo(dai, msg.sender, prizePool, to, amount, controlledToken, referrer);
  }

  function _depositTo(
    address dai,
    address holder,
    address prizePool,
    address to,
    uint256 amount,
    address controlledToken,
    address referrer
  ) internal {
    DaiInterface(dai).safeTransferFrom(holder, address(this), amount);
    DaiInterface(dai).approve(address(prizePool), amount);
    PrizePoolInterface(prizePool).depositTo(to, amount, controlledToken, referrer);
  }

}
