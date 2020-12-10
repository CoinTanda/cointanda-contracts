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


// Dependency file: contracts/utils/UInt256Array.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

library UInt256Array {
  function remove(uint256[] storage self, uint256 index) internal {
    require(index < self.length, "UInt256Array/unknown-index");
    self[index] = self[self.length-1];
    delete self[self.length-1];
    self.pop();
  }
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


// Dependency file: contracts/utils/ExtendedSafeCast.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

library ExtendedSafeCast {

  /**
    * @dev Converts an unsigned uint256 into a unsigned uint112.
    *
    * Requirements:
    *
    * - input must be less than or equal to maxUint112.
    */
  function toUint112(uint256 value) internal pure returns (uint112) {
    require(value < 2**112, "SafeCast: value doesn't fit in an uint112");
    return uint112(value);
  }

  /**
    * @dev Converts an unsigned uint256 into a unsigned uint96.
    *
    * Requirements:
    *
    * - input must be less than or equal to maxUint96.
    */
  function toUint96(uint256 value) internal pure returns (uint96) {
    require(value < 2**96, "SafeCast: value doesn't fit in an uint96");
    return uint96(value);
  }

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


// Dependency file: contracts/drip/BalanceDrip.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/SafeCast.sol";

// import "contracts/utils/ExtendedSafeCast.sol";
// import "contracts/external/pooltogether/FixedPoint.sol";

/// @title Calculates a users share of a token faucet.
/// @notice The tokens are dripped at a "drip rate per second".  This is the number of tokens that
/// are dripped each second to the entire supply of a "measure" token.  A user's share of ownership
/// of the measure token corresponds to the share of the drip tokens per second.
library BalanceDrip {
  using SafeMath for uint256;
  using SafeCast for uint256;
  using ExtendedSafeCast for uint256;

  struct UserState {
    uint128 lastExchangeRateMantissa;
  }

  struct State {
    uint256 dripRatePerSecond;
    uint112 exchangeRateMantissa;
    uint112 totalDripped;
    uint32 timestamp;
    mapping(address => UserState) userStates;
  }

  /// @notice Captures new tokens for a user
  /// @dev This must be called before changes to the user's balance (i.e. before mint, transfer or burns)
  /// @param self The balance drip state
  /// @param user The user to capture tokens for
  /// @param userMeasureBalance The current balance of the user's measure tokens
  /// @return The number of new tokens
  function captureNewTokensForUser(
    State storage self,
    address user,
    uint256 userMeasureBalance
  ) internal returns (uint128) {
    return _captureNewTokensForUser(
      self,
      user,
      userMeasureBalance
    );
  }

  function resetTotalDripped(State storage self) internal {
    self.totalDripped = 0;
  }

  /// @notice Drips new tokens.
  /// @dev Should be called immediately before a change to the measure token's total supply
  /// @param self The balance drip state
  /// @param measureTotalSupply The measure token's last total supply (prior to any change)
  /// @param timestamp The current time
  /// @param maxNewTokens Maximum new tokens that can be dripped
  /// @return The number of new tokens dripped.
  function drip(
    State storage self,
    uint256 measureTotalSupply,
    uint256 timestamp,
    uint256 maxNewTokens
  ) internal returns (uint256) {
    // this should only run once per block.
    if (self.timestamp == uint32(timestamp)) {
      return 0;
    }

    uint256 lastTime = self.timestamp == 0 ? timestamp : self.timestamp;
    uint256 newSeconds = timestamp.sub(lastTime);

    uint112 exchangeRateMantissa = self.exchangeRateMantissa == 0 ? FixedPoint.SCALE.toUint112() : self.exchangeRateMantissa;

    uint256 newTokens;
    if (newSeconds > 0 && self.dripRatePerSecond > 0) {
      newTokens = newSeconds.mul(self.dripRatePerSecond);
      if (newTokens > maxNewTokens) {
        newTokens = maxNewTokens;
      }
      uint256 indexDeltaMantissa = measureTotalSupply > 0 ? FixedPoint.calculateMantissa(newTokens, measureTotalSupply) : 0;
      exchangeRateMantissa = uint256(exchangeRateMantissa).add(indexDeltaMantissa).toUint112();
    }

    self.exchangeRateMantissa = exchangeRateMantissa;
    self.totalDripped = uint256(self.totalDripped).add(newTokens).toUint112();
    self.timestamp = timestamp.toUint32();

    return newTokens;
  }

  function _captureNewTokensForUser(
    State storage self,
    address user,
    uint256 userMeasureBalance
  ) private returns (uint128) {
    UserState storage userState = self.userStates[user];
    uint256 lastExchangeRateMantissa = userState.lastExchangeRateMantissa;
    if (lastExchangeRateMantissa == 0) {
      // if the index is not intialized
      lastExchangeRateMantissa = FixedPoint.SCALE.toUint112();
    }

    uint256 deltaExchangeRateMantissa = uint256(self.exchangeRateMantissa).sub(lastExchangeRateMantissa);
    uint128 newTokens = FixedPoint.multiplyUintByMantissa(userMeasureBalance, deltaExchangeRateMantissa).toUint128();

    self.userStates[user] = UserState({
      lastExchangeRateMantissa: self.exchangeRateMantissa
    });

    return newTokens;
  }
}


// Dependency file: contracts/drip/BalanceDripManager.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

// import "contracts/utils/MappedSinglyLinkedList.sol";
// import "contracts/drip/BalanceDrip.sol";

/// @title Manages the lifecycle of a set of Balance Drips.
library BalanceDripManager {
  using SafeMath for uint256;
  using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;
  using BalanceDrip for BalanceDrip.State;

  struct State {
    mapping(address => MappedSinglyLinkedList.Mapping) activeBalanceDrips;
    mapping(address => mapping(address => BalanceDrip.State)) balanceDrips;
  }

  /// @notice Activates a drip by setting it's state and adding it to the active balance drips list.
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param dripRatePerSecond The amount of the drip token to be dripped per second
  function activateDrip(
    State storage self,
    address measure,
    address dripToken,
    uint256 dripRatePerSecond
  )
    internal
  {
    require(!self.activeBalanceDrips[measure].contains(dripToken), "BalanceDripManager/drip-active");
    if (self.activeBalanceDrips[measure].count == 0) {
      self.activeBalanceDrips[measure].initialize();
    }
    self.activeBalanceDrips[measure].addAddress(dripToken);
    self.balanceDrips[measure][dripToken].resetTotalDripped();
    self.balanceDrips[measure][dripToken].dripRatePerSecond = dripRatePerSecond;
  }

  /// @notice Deactivates an active balance drip.  The balance drip is removed from the active balance drips list.
  /// The drip rate for the balance drip will be set to zero to ensure it's "frozen".
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param prevDripToken The previous drip token previous in the list.
  /// If no previous, then pass the SENTINEL address: 0x0000000000000000000000000000000000000001
  /// @param currentTime The current time
  function deactivateDrip(
    State storage self,
    address measure,
    address dripToken,
    address prevDripToken,
    uint32 currentTime,
    uint256 maxNewTokens
  )
    internal
  {
    self.activeBalanceDrips[measure].removeAddress(prevDripToken, dripToken);
    self.balanceDrips[measure][dripToken].drip(IERC20(measure).totalSupply(), currentTime, maxNewTokens);
    self.balanceDrips[measure][dripToken].dripRatePerSecond = 0;
  }

  /// @notice Gets a list of active balance drip tokens
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @return An array of Balance Drip token addresses
  function getActiveBalanceDrips(State storage self, address measure) internal view returns (address[] memory) {
    return self.activeBalanceDrips[measure].addressArray();
  }

  /// @notice Sets the drip rate for an active balance drip.
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param dripRatePerSecond The amount to drip of the token each second
  /// @param currentTime The current time.
  function setDripRate(
    State storage self,
    address measure,
    address dripToken,
    uint256 dripRatePerSecond,
    uint32 currentTime,
    uint256 maxNewTokens
  ) internal {
    require(self.activeBalanceDrips[measure].contains(dripToken), "BalanceDripManager/drip-not-active");
    self.balanceDrips[measure][dripToken].drip(IERC20(measure).totalSupply(), currentTime, maxNewTokens);
    self.balanceDrips[measure][dripToken].dripRatePerSecond = dripRatePerSecond;
  }

  /// @notice Returns whether or not a drip is active for the given measure, dripToken pair
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @return True if there is an active balance drip for the pair, false otherwise
  function isDripActive(State storage self, address measure, address dripToken) internal view returns (bool) {
    return self.activeBalanceDrips[measure].contains(dripToken);
  }

  /// @notice Returns the BalanceDrip.State for the given measure, dripToken pair
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @return The BalanceDrip.State for the pair
  function getDrip(State storage self, address measure, address dripToken) internal view returns (BalanceDrip.State storage) {
    return self.balanceDrips[measure][dripToken];
  }
}


// Dependency file: contracts/drip/VolumeDrip.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/math/SafeMath.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/utils/SafeCast.sol";

// import "contracts/external/pooltogether/FixedPoint.sol";
// import "contracts/utils/ExtendedSafeCast.sol";

library VolumeDrip {
  using SafeMath for uint256;
  using SafeCast for uint256;
  using ExtendedSafeCast for uint256;

  struct Deposit {
    uint112 balance;
    uint32 period;
  }

  struct Period {
    uint112 totalSupply;
    uint112 dripAmount;
    uint32 endTime;
  }

  struct State {
    mapping(address => Deposit) deposits;
    mapping(uint32 => Period) periods;
    uint32 nextPeriodSeconds;
    uint112 nextDripAmount;
    uint112 __gap;
    uint112 totalDripped;
    uint32 periodCount;
  }

  function setNewPeriod(
    State storage self,
    uint32 _periodSeconds,
    uint112 dripAmount,
    uint32 endTime
  )
    internal
    minPeriod(_periodSeconds)
  {
    self.nextPeriodSeconds = _periodSeconds;
    self.nextDripAmount = dripAmount;
    self.totalDripped = 0;
    self.periodCount = uint256(self.periodCount).add(1).toUint16();
    self.periods[self.periodCount] = Period({
      totalSupply: 0,
      dripAmount: dripAmount,
      endTime: endTime
    });
  }

  function setNextPeriod(
    State storage self,
    uint32 _periodSeconds,
    uint112 dripAmount
  )
    internal
    minPeriod(_periodSeconds)
  {
    self.nextPeriodSeconds = _periodSeconds;
    self.nextDripAmount = dripAmount;
  }

  function drip(
    State storage self,
    uint256 currentTime,
    uint256 maxNewTokens
  )
    internal
    returns (uint256)
  {
    if (_isPeriodOver(self, currentTime)) {
      return _completePeriod(self, currentTime, maxNewTokens);
    }
    return 0;
  }

  function mint(
    State storage self,
    address user,
    uint256 amount
  )
    internal
    returns (uint256)
  {
    if (self.periodCount == 0) {
      return 0;
    }
    uint256 accrued = _lastBalanceAccruedAmount(self, self.deposits[user].period, self.deposits[user].balance);
    uint32 currentPeriod = self.periodCount;
    if (accrued > 0) {
      self.deposits[user] = Deposit({
        balance: amount.toUint112(),
        period: currentPeriod
      });
    } else {
      self.deposits[user] = Deposit({
        balance: uint256(self.deposits[user].balance).add(amount).toUint112(),
        period: currentPeriod
      });
    }
    self.periods[currentPeriod].totalSupply = uint256(self.periods[currentPeriod].totalSupply).add(amount).toUint112();

    return accrued;
  }

  function currentPeriod(State storage self) internal view returns (Period memory) {
    return self.periods[self.periodCount];
  }

  function _isPeriodOver(State storage self, uint256 currentTime) private view returns (bool) {
    return currentTime >= self.periods[self.periodCount].endTime;
  }

  function _completePeriod(
    State storage self,
    uint256 currentTime,
    uint256 maxNewTokens
  ) private onlyPeriodOver(self, currentTime) returns (uint256) {
    // calculate the actual drip amount
    uint112 dripAmount;
    // If no one deposited, then don't drip anything
    if (self.periods[self.periodCount].totalSupply > 0) {
      dripAmount = self.periods[self.periodCount].dripAmount;
    }

    // if the drip amount is not valid, it has to be updated.
    if (dripAmount > maxNewTokens) {
      dripAmount = maxNewTokens.toUint112();
      self.periods[self.periodCount].dripAmount = dripAmount;
    }

    // if we are completing the period far into the future, then we'll have skipped a lot of periods.
    // Here we set the end time so that it's the next period from *now*
    uint256 lastEndTime = self.periods[self.periodCount].endTime;
    uint256 numberOfPeriods = currentTime.sub(lastEndTime).div(self.nextPeriodSeconds).add(1);
    uint256 endTime = lastEndTime.add(numberOfPeriods.mul(self.nextPeriodSeconds));
    self.totalDripped = uint256(self.totalDripped).add(dripAmount).toUint112();
    self.periodCount = uint256(self.periodCount).add(1).toUint16();

    self.periods[self.periodCount] = Period({
      totalSupply: 0,
      dripAmount: self.nextDripAmount,
      endTime: endTime.toUint32()
    });

    return dripAmount;
  }

  function _lastBalanceAccruedAmount(
    State storage self,
    uint32 depositPeriod,
    uint128 balance
  )
    private view
    returns (uint256)
  {
    uint256 accrued;
    if (depositPeriod < self.periodCount && self.periods[depositPeriod].totalSupply > 0) {
      uint256 fractionMantissa = FixedPoint.calculateMantissa(balance, self.periods[depositPeriod].totalSupply);
      accrued = FixedPoint.multiplyUintByMantissa(self.periods[depositPeriod].dripAmount, fractionMantissa);
    }
    return accrued;
  }

  modifier onlyPeriodNotOver(State storage self, uint256 _currentTime) {
    require(!_isPeriodOver(self, _currentTime), "VolumeDrip/period-over");
    _;
  }

  modifier onlyPeriodOver(State storage self, uint256 _currentTime) {
    require(_isPeriodOver(self, _currentTime), "VolumeDrip/period-not-over");
    _;
  }

  modifier minPeriod(uint256 _periodSeconds) {
    require(_periodSeconds > 0, "VolumeDrip/period-gt-zero");
    _;
  }
}


// Dependency file: contracts/drip/VolumeDripManager.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";

// import "contracts/utils/MappedSinglyLinkedList.sol";
// import "contracts/drip/VolumeDrip.sol";

/// @title Manages the active set of Volume Drips.
library VolumeDripManager {
  using SafeMath for uint256;
  using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;
  using VolumeDrip for VolumeDrip.State;

  struct State {
    mapping(address => MappedSinglyLinkedList.Mapping) activeVolumeDrips;
    mapping(address => mapping(address => VolumeDrip.State)) volumeDrips;
  }

  /// @notice Activates a volume drip for the given (measure,dripToken) pair.
  /// @param self The VolumeDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param periodSeconds The period of the volume drip in seconds
  /// @param dripAmount The amount of tokens to drip each period
  /// @param endTime The end time to set for the current period.
  function activate(
    State storage self,
    address measure,
    address dripToken,
    uint32 periodSeconds,
    uint112 dripAmount,
    uint32 endTime
  )
    internal
    returns (uint32)
  {
    require(!self.activeVolumeDrips[measure].contains(dripToken), "VolumeDripManager/drip-active");
    if (self.activeVolumeDrips[measure].count == 0) {
      self.activeVolumeDrips[measure].initialize();
    }
    self.activeVolumeDrips[measure].addAddress(dripToken);
    self.volumeDrips[measure][dripToken].setNewPeriod(periodSeconds, dripAmount, endTime);

    return self.volumeDrips[measure][dripToken].periodCount;
  }

  /// @notice Deactivates the volume drip for the given (measure, dripToken) pair.
  /// @param self The VolumeDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param prevDripToken The active drip token previous to the passed on in the list.
  function deactivate(
    State storage self,
    address measure,
    address dripToken,
    address prevDripToken
  )
    internal
  {
    self.activeVolumeDrips[measure].removeAddress(prevDripToken, dripToken);
  }

  /// @notice Gets a list of active balance drip tokens
  /// @param self The BalanceDripManager state
  /// @param measure The measure token
  /// @return An array of Balance Drip token addresses
  function getActiveVolumeDrips(State storage self, address measure) internal view returns (address[] memory) {
    return self.activeVolumeDrips[measure].addressArray();
  }

  /// @notice Sets the parameters for the next period of an active volume drip
  /// @param self The VolumeDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  /// @param periodSeconds The length in seconds to use for the next period
  /// @param dripAmount The amount of tokens to be dripped in the next period
  function set(State storage self, address measure, address dripToken, uint32 periodSeconds, uint112 dripAmount) internal {
    require(self.activeVolumeDrips[measure].contains(dripToken), "VolumeDripManager/drip-not-active");
    self.volumeDrips[measure][dripToken].setNextPeriod(periodSeconds, dripAmount);
  }

  /// @notice Returns whether or not an active volume drip exists for the given (measure, dripToken) pair
  /// @param self The VolumeDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  function isActive(State storage self, address measure, address dripToken) internal view returns (bool) {
    return self.activeVolumeDrips[measure].contains(dripToken);
  }

  /// @notice Returns the VolumeDrip.State for the given (measure, dripToken) pair.
  /// @param self The VolumeDripManager state
  /// @param measure The measure token
  /// @param dripToken The drip token
  function getDrip(State storage self, address measure, address dripToken) internal view returns (VolumeDrip.State storage) {
    return self.volumeDrips[measure][dripToken];
  }
}


// Dependency file: contracts/comptroller/ComptrollerStorage.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;

// import "@openzeppelin/contracts-ethereum-package/contracts/access/Ownable.sol";

// import "contracts/drip/BalanceDripManager.sol";
// import "contracts/drip/VolumeDripManager.sol";

contract ComptrollerStorage is OwnableUpgradeSafe {
  mapping(address => VolumeDripManager.State) internal volumeDrips;
  mapping(address => VolumeDripManager.State) internal referralVolumeDrips;
  mapping(address => BalanceDripManager.State) internal balanceDrips;

  mapping(address => uint256) internal dripTokenTotalSupply;
  mapping(address => mapping(address => uint256)) internal dripTokenBalances;
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

// Dependency file: contracts/comptroller/Comptroller.sol

// SPDX-License-Identifier: GPL-3.0

// pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

// import "@openzeppelin/contracts-ethereum-package/contracts/utils/SafeCast.sol";

// import "contracts/utils/UInt256Array.sol";
// import "contracts/comptroller/ComptrollerStorage.sol";
// import "contracts/token/TokenListenerInterface.sol";

/// @title The Comptroller disburses rewards to pool users
/* solium-disable security/no-block-members */
contract Comptroller is ComptrollerStorage, TokenListenerInterface {
  using SafeMath for uint256;
  using SafeCast for uint256;
  using UInt256Array for uint256[];
  using ExtendedSafeCast for uint256;
  using BalanceDrip for BalanceDrip.State;
  using VolumeDrip for VolumeDrip.State;
  using BalanceDripManager for BalanceDripManager.State;
  using VolumeDripManager for VolumeDripManager.State;
  using MappedSinglyLinkedList for MappedSinglyLinkedList.Mapping;

  /// @notice Emitted when a balance drip is actived
  event BalanceDripActivated(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    uint256 dripRatePerSecond
  );

  /// @notice Emitted when a balance drip is deactivated
  event BalanceDripDeactivated(
    address indexed source,
    address indexed measure,
    address indexed dripToken
  );

  /// @notice Emitted when a balance drip rate is updated
  event BalanceDripRateSet(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    uint256 dripRatePerSecond
  );

  /// @notice Emitted when a balance drip drips tokens
  event BalanceDripDripped(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    address user,
    uint256 amount
  );

  event DripTokenDripped(
    address indexed dripToken,
    address indexed user,
    uint256 amount
  );

  /// @notice Emitted when a volue drip drips tokens
  event VolumeDripDripped(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral,
    address user,
    uint256 amount
  );

  /// @notice Emitted when a user claims drip tokens
  event DripTokenClaimed(
    address indexed operator,
    address indexed dripToken,
    address indexed user,
    uint256 amount
  );

  /// @notice Emitted when a volume drip is activated
  event VolumeDripActivated(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral,
    uint256 periodSeconds,
    uint256 dripAmount
  );

  event TransferredOut(
    address indexed token,
    address indexed to,
    uint256 amount
  );

  /// @notice Emitted when a new volume drip period has started
  event VolumeDripPeriodStarted(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral,
    uint32 period,
    uint256 dripAmount,
    uint256 endTime
  );

  /// @notice Emitted when a volume drip period has ended
  event VolumeDripPeriodEnded(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral,
    uint32 period,
    uint256 totalSupply,
    uint256 drippedTokens
  );

  /// @notice Emitted when a volume drip is updated
  event VolumeDripSet(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral,
    uint256 periodSeconds,
    uint256 dripAmount
  );

  /// @notice Emitted when a volume drip is deactivated.
  event VolumeDripDeactivated(
    address indexed source,
    address indexed measure,
    address indexed dripToken,
    bool isReferral
  );

  /// @notice Convenience struct used when updating drips
  struct UpdatePair {
    address source;
    address measure;
  }

  /// @notice Convenience struct used to retrieve balances after updating drips
  struct DripTokenBalance {
    address dripToken;
    uint256 balance;
  }

  /// @notice Initializes a new Comptroller.
  constructor () public {
    __Ownable_init();
  }

  function transferOut(address token, address to, uint256 amount) external onlyOwner {
    IERC20(token).transfer(to, amount);

    emit TransferredOut(token, to, amount);
  }

  /// @notice Activates a balance drip.  Only callable by the owner.
  /// @param source The balance drip "source"; i.e. a Prize Pool address.
  /// @param measure The ERC20 token whose balances determines user's share of the drip rate.
  /// @param dripToken The token that is dripped to users.
  /// @param dripRatePerSecond The amount of drip tokens that are awarded each second to the total supply of measure.
  function activateBalanceDrip(address source, address measure, address dripToken, uint256 dripRatePerSecond) external onlyOwner {

    balanceDrips[source].activateDrip(measure, dripToken, dripRatePerSecond);

    emit BalanceDripActivated(
      source,
      measure,
      dripToken,
      dripRatePerSecond
    );
  }

  /// @notice Deactivates a balance drip.  Only callable by the owner.
  /// @param source The balance drip "source"; i.e. a Prize Pool address.
  /// @param measure The ERC20 token whose balances determines user's share of the drip rate.
  /// @param dripToken The token that is dripped to users.
  /// @param prevDripToken The previous drip token in the balance drip list.  If the dripToken is the first address,
  /// then the previous address is the SENTINEL address: 0x0000000000000000000000000000000000000001
  function deactivateBalanceDrip(address source, address measure, address dripToken, address prevDripToken) external onlyOwner {
    _deactivateBalanceDrip(source, measure, dripToken, prevDripToken);
  }

  /// @notice Deactivates a balance drip.  Only callable by the owner.
  /// @param source The balance drip "source"; i.e. a Prize Pool address.
  /// @param measure The ERC20 token whose balances determines user's share of the drip rate.
  /// @param dripToken The token that is dripped to users.
  /// @param prevDripToken The previous drip token in the balance drip list.  If the dripToken is the first address,
  /// then the previous address is the SENTINEL address: 0x0000000000000000000000000000000000000001
  function _deactivateBalanceDrip(address source, address measure, address dripToken, address prevDripToken) internal {
    balanceDrips[source].deactivateDrip(measure, dripToken, prevDripToken, _currentTime().toUint32(), _availableDripTokenBalance(dripToken));

    emit BalanceDripDeactivated(source, measure, dripToken);
  }

  /// @notice Gets a list of active balance drip tokens
  /// @param source The balance drip "source"; i.e. a Prize Pool address.
  /// @param measure The ERC20 token whose balances determines user's share of the drip rate.
  /// @return An array of active Balance Drip token addresses
  function getActiveBalanceDripTokens(address source, address measure) external view returns (address[] memory) {
    return balanceDrips[source].getActiveBalanceDrips(measure);
  }

  /// @notice Returns the state of a balance drip.
  /// @param source The balance drip "source"; i.e. Prize Pool
  /// @param measure The token that measure's a users share of the drip
  /// @param dripToken The token that is being dripped to users
  /// @return dripRatePerSecond The current drip rate of the balance drip.
  /// @return exchangeRateMantissa The current exchange rate from measure to dripTokens
  /// @return timestamp The timestamp at which the balance drip was last updated.
  function getBalanceDrip(
    address source,
    address measure,
    address dripToken
  )
    external
    view
    returns (
      uint256 dripRatePerSecond,
      uint128 exchangeRateMantissa,
      uint32 timestamp
    )
  {
    BalanceDrip.State storage balanceDrip = balanceDrips[source].getDrip(measure, dripToken);
    dripRatePerSecond = balanceDrip.dripRatePerSecond;
    exchangeRateMantissa = balanceDrip.exchangeRateMantissa;
    timestamp = balanceDrip.timestamp;
  }

  /// @notice Sets the drip rate for a balance drip.  The drip rate is the number of drip tokens given to the
  /// entire supply of measure tokens.  Only callable by the owner.
  /// @param source The balance drip "source"; i.e. Prize Pool
  /// @param measure The token to use to measure a user's share of the drip rate
  /// @param dripToken The token that is dripped to the user
  /// @param dripRatePerSecond The new drip rate per second
  function setBalanceDripRate(address source, address measure, address dripToken, uint256 dripRatePerSecond) external onlyOwner {
    balanceDrips[source].setDripRate(measure, dripToken, dripRatePerSecond, _currentTime().toUint32(), _availableDripTokenBalance(dripToken));

    emit BalanceDripRateSet(
      source,
      measure,
      dripToken,
      dripRatePerSecond
    );
  }

  /// @notice Activates a volume drip.  Volume drips distribute tokens to users based on their share of the activity within a period.
  /// @param source The Prize Pool for which to bind to
  /// @param measure The Prize Pool controlled token whose volume should be measured
  /// @param dripToken The token that is being disbursed
  /// @param isReferral Whether this volume drip is for referrals
  /// @param periodSeconds The period of the volume drip, in seconds
  /// @param dripAmount The amount of dripTokens disbursed each period.
  /// @param endTime The time at which the first period ends.
  function activateVolumeDrip(
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    uint32 periodSeconds,
    uint112 dripAmount,
    uint32 endTime
  )
    external
    onlyOwner
  {
    uint32 period;

    if (isReferral) {
      period = referralVolumeDrips[source].activate(measure, dripToken, periodSeconds, dripAmount, endTime);
    } else {
      period = volumeDrips[source].activate(measure, dripToken, periodSeconds, dripAmount, endTime);
    }

    emit VolumeDripActivated(
      source,
      measure,
      dripToken,
      isReferral,
      periodSeconds,
      dripAmount
    );

    emit VolumeDripPeriodStarted(
      source,
      measure,
      dripToken,
      isReferral,
      period,
      dripAmount,
      endTime
    );
  }

  /// @notice Deactivates a volume drip.  Volume drips distribute tokens to users based on their share of the activity within a period.
  /// @param source The Prize Pool for which to bind to
  /// @param measure The Prize Pool controlled token whose volume should be measured
  /// @param dripToken The token that is being disbursed
  /// @param isReferral Whether this volume drip is for referrals
  /// @param prevDripToken The previous drip token in the volume drip list.  Is different for referrals vs non-referral volume drips.
  function deactivateVolumeDrip(
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    address prevDripToken
  )
    external
    onlyOwner
  {
    _deactivateVolumeDrip(source, measure, dripToken, isReferral, prevDripToken);
  }

  /// @notice Deactivates a volume drip.  Volume drips distribute tokens to users based on their share of the activity within a period.
  /// @param source The Prize Pool for which to bind to
  /// @param measure The Prize Pool controlled token whose volume should be measured
  /// @param dripToken The token that is being disbursed
  /// @param isReferral Whether this volume drip is for referrals
  /// @param prevDripToken The previous drip token in the volume drip list.  Is different for referrals vs non-referral volume drips.
  function _deactivateVolumeDrip(
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    address prevDripToken
  )
    internal
  {
    if (isReferral) {
      referralVolumeDrips[source].deactivate(measure, dripToken, prevDripToken);
    } else {
      volumeDrips[source].deactivate(measure, dripToken, prevDripToken);
    }

    emit VolumeDripDeactivated(
      source,
      measure,
      dripToken,
      isReferral
    );
  }


  /// @notice Sets the parameters for the *next* volume drip period.  The source, measure, dripToken and isReferral combined
  /// are used to uniquely identify a volume drip.  Only callable by the owner.
  /// @param source The Prize Pool of the volume drip
  /// @param measure The token whose volume is being measured
  /// @param dripToken The token that is being disbursed
  /// @param isReferral Whether this volume drip is a referral
  /// @param periodSeconds The length to use for the next period
  /// @param dripAmount The amount of tokens to drip for the next period
  function setVolumeDrip(
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    uint32 periodSeconds,
    uint112 dripAmount
  )
    external
    onlyOwner
  {
    if (isReferral) {
      referralVolumeDrips[source].set(measure, dripToken, periodSeconds, dripAmount);
    } else {
      volumeDrips[source].set(measure, dripToken, periodSeconds, dripAmount);
    }

    emit VolumeDripSet(
      source,
      measure,
      dripToken,
      isReferral,
      periodSeconds,
      dripAmount
    );
  }

  function getVolumeDrip(
    address source,
    address measure,
    address dripToken,
    bool isReferral
  )
    external
    view
    returns (
      uint256 periodSeconds,
      uint256 dripAmount,
      uint256 periodCount
    )
  {
    VolumeDrip.State memory drip;

    if (isReferral) {
      drip = referralVolumeDrips[source].volumeDrips[measure][dripToken];
    } else {
      drip = volumeDrips[source].volumeDrips[measure][dripToken];
    }

    return (
      drip.nextPeriodSeconds,
      drip.nextDripAmount,
      drip.periodCount
    );
  }

  /// @notice Gets a list of active volume drip tokens
  /// @param source The volume drip "source"; i.e. a Prize Pool address.
  /// @param measure The ERC20 token whose volume determines user's share of the drip rate.
  /// @param isReferral Whether this volume drip is a referral
  /// @return An array of active Volume Drip token addresses
  function getActiveVolumeDripTokens(address source, address measure, bool isReferral) external view returns (address[] memory) {
    if (isReferral) {
      return referralVolumeDrips[source].getActiveVolumeDrips(measure);
    } else {
      return volumeDrips[source].getActiveVolumeDrips(measure);
    }
  }

  function isVolumeDripActive(
    address source,
    address measure,
    address dripToken,
    bool isReferral
  )
    external
    view
    returns (bool)
  {
    if (isReferral) {
      return referralVolumeDrips[source].isActive(measure, dripToken);
    } else {
      return volumeDrips[source].isActive(measure, dripToken);
    }
  }

  function getVolumeDripPeriod(
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    uint16 period
  )
    external
    view
    returns (
      uint112 totalSupply,
      uint112 dripAmount,
      uint32 endTime
    )
  {
    VolumeDrip.Period memory periodState;

    if (isReferral) {
      periodState = referralVolumeDrips[source].volumeDrips[measure][dripToken].periods[period];
    } else {
      periodState = volumeDrips[source].volumeDrips[measure][dripToken].periods[period];
    }

    return (
      periodState.totalSupply,
      periodState.dripAmount,
      periodState.endTime
    );
  }

  /// @notice Returns a users claimable balance of drip tokens.  This is the combination of all balance and volume drips.
  /// @param dripToken The token that is being disbursed
  /// @param user The user whose balance should be checked.
  /// @return The claimable balance of the dripToken by the user.
  function balanceOfDrip(address user, address dripToken) external view returns (uint256) {
    return dripTokenBalances[dripToken][user];
  }

  /// @notice Claims a drip token on behalf of a user.  If the passed amount is less than or equal to the users drip balance, then
  /// they will be transferred that amount.  Otherwise, it fails.
  /// @param user The user for whom to claim the drip tokens
  /// @param dripToken The drip token to claim
  /// @param amount The amount of drip token to claim
  function claimDrip(address user, address dripToken, uint256 amount) public {
    address sender = _msgSender();
    dripTokenTotalSupply[dripToken] = dripTokenTotalSupply[dripToken].sub(amount);
    dripTokenBalances[dripToken][user] = dripTokenBalances[dripToken][user].sub(amount);
    require(IERC20(dripToken).transfer(user, amount), "Comptroller/claim-transfer-failed");

    emit DripTokenClaimed(sender, dripToken, user, amount);
  }

  function claimDrips(address user, address[] memory dripTokens) public {
    for (uint i = 0; i < dripTokens.length; i++) {
      claimDrip(user, dripTokens[i], dripTokenBalances[dripTokens[i]][user]);
    }
  }

  function updateActiveBalanceDripsForPairs(
    UpdatePair[] memory pairs
  ) public {
    uint256 currentTime = _currentTime();
    uint256 i;
    for (i = 0; i < pairs.length; i++) {
      UpdatePair memory pair = pairs[i];
      _updateActiveBalanceDrips(
        balanceDrips[pair.source],
        pair.source,
        pair.measure,
        IERC20(pair.measure).totalSupply(),
        currentTime
      );
    }
  }

  function updateActiveVolumeDripsForPairs(
    UpdatePair[] memory pairs
  ) public {
    uint256 i;
    for (i = 0; i < pairs.length; i++) {
      UpdatePair memory pair = pairs[i];
      _updateActiveVolumeDrips(
        volumeDrips[pair.source],
        pair.source,
        pair.measure,
        false
      );
      _updateActiveVolumeDrips(
        referralVolumeDrips[pair.source],
        pair.source,
        pair.measure,
        true
      );
    }
  }

  function mintAndCaptureVolumeDripsForPairs(
    UpdatePair[] memory pairs,
    address user,
    uint256 amount,
    address[] memory dripTokens
  ) public {
    uint256 i;
    for (i = 0; i < pairs.length; i++) {
      UpdatePair memory pair = pairs[i];

      _mintAndCaptureForVolumeDrips(pair.source, pair.measure, user, amount, dripTokens);
      _mintAndCaptureReferralVolumeDrips(pair.source, pair.measure, user, amount, dripTokens);
    }
  }

  function _mintAndCaptureForVolumeDrips(
    address source,
    address measure,
    address user,
    uint256 amount,
    address[] memory dripTokens
  ) internal {
    uint i;
    for (i = 0; i < dripTokens.length; i++) {
      address dripToken = dripTokens[i];

      VolumeDrip.State storage state = volumeDrips[source].volumeDrips[measure][dripToken];
      _captureClaimForVolumeDrip(state, source, measure, dripToken, false, user, amount);
    }
  }

  function _mintAndCaptureReferralVolumeDrips(
    address source,
    address measure,
    address user,
    uint256 amount,
    address[] memory dripTokens
  ) internal {
    uint i;
    for (i = 0; i < dripTokens.length; i++) {
      address dripToken = dripTokens[i];

      VolumeDrip.State storage referralState = referralVolumeDrips[source].volumeDrips[measure][dripToken];
      _captureClaimForVolumeDrip(referralState, source, measure, dripToken, true, user, amount);
    }
  }

  function _captureClaimForVolumeDrip(
    VolumeDrip.State storage dripState,
    address source,
    address measure,
    address dripToken,
    bool isReferral,
    address user,
    uint256 amount
  ) internal {
    uint256 newUserTokens = dripState.mint(
      user,
      amount
    );

    if (newUserTokens > 0) {
      _addDripBalance(dripToken, user, newUserTokens);
      emit VolumeDripDripped(source, measure, dripToken, isReferral, user, newUserTokens);
    }
  }

  /// @param pairs The (source, measure) pairs to update.  For each pair all of the balance drips, volume drips, and referral volume drips will be updated.
  /// @param user The user whose drips and balances will be updated.
  /// @param dripTokens The drip tokens to retrieve claim balances for.
  function captureClaimsForBalanceDripsForPairs(
    UpdatePair[] memory pairs,
    address user,
    address[] memory dripTokens
  )
    public
  {
    uint256 i;
    for (i = 0; i < pairs.length; i++) {
      UpdatePair memory pair = pairs[i];
      uint256 measureBalance = IERC20(pair.measure).balanceOf(user);
      _captureClaimsForBalanceDrips(pair.source, pair.measure, user, measureBalance, dripTokens);
    }
  }

  function _captureClaimsForBalanceDrips(
    address source,
    address measure,
    address user,
    uint256 userMeasureBalance,
    address[] memory dripTokens
  ) internal {
    uint i;
    for (i = 0; i < dripTokens.length; i++) {
      address dripToken = dripTokens[i];

      BalanceDrip.State storage state = balanceDrips[source].balanceDrips[measure][dripToken];
      if (state.exchangeRateMantissa > 0) {
        _captureClaimForBalanceDrip(state, source, measure, dripToken, user, userMeasureBalance);
      }
    }
  }

  function _captureClaimForBalanceDrip(
    BalanceDrip.State storage dripState,
    address source,
    address measure,
    address dripToken,
    address user,
    uint256 measureBalance
  ) internal {
    uint256 newUserTokens = dripState.captureNewTokensForUser(
      user,
      measureBalance
    );

    if (newUserTokens > 0) {
      _addDripBalance(dripToken, user, newUserTokens);
      emit BalanceDripDripped(source, measure, dripToken, user, newUserTokens);
    }
  }

  function balanceOfClaims(
    address user,
    address[] memory dripTokens
  ) public view returns (DripTokenBalance[] memory) {
    DripTokenBalance[] memory balances = new DripTokenBalance[](dripTokens.length);
    uint256 i;
    for (i = 0; i < dripTokens.length; i++) {
      balances[i] = DripTokenBalance({
        dripToken: dripTokens[i],
        balance: dripTokenBalances[dripTokens[i]][user]
      });
    }
    return balances;
  }

  /// @notice Updates the given drips for a user and then claims the given drip tokens.  This call will
  /// poke all of the drips and update the claim balances for the given user.
  /// @dev This function will be useful to check the *current* claim balances for a user.
  /// Just need to run this as a constant function to see the latest balances.
  /// in order to claim the values, this function needs to be run alongside a claimDrip function.
  /// @param pairs The (source, measure) pairs of drips to update for the given user
  /// @param user The user for whom to update and claim tokens
  /// @param dripTokens The drip tokens whose entire balance will be claimed after the update.
  /// @return The claimable balance of each of the passed drip tokens for the user.  These are the post-update balances, and therefore the most accurate.
  function updateDrips(
    UpdatePair[] memory pairs,
    address user,
    address[] memory dripTokens
  )
    public returns (DripTokenBalance[] memory)
  {
    updateActiveBalanceDripsForPairs(pairs);
    captureClaimsForBalanceDripsForPairs(pairs, user, dripTokens);
    updateActiveVolumeDripsForPairs(pairs);
    mintAndCaptureVolumeDripsForPairs(pairs, user, 0, dripTokens);
    DripTokenBalance[] memory balances = balanceOfClaims(user, dripTokens);
    return balances;
  }

  /// @notice Updates the given drips for a user and then claims the given drip tokens.  This call will
  /// poke all of the drips and update the claim balances for the given user.
  /// @dev This function will be useful to check the *current* claim balances for a user.
  /// Just need to run this as a constant function to see the latest balances.
  /// in order to claim the values, this function needs to be run alongside a claimDrip function.
  /// @param pairs The (source, measure) pairs of drips to update for the given user
  /// @param user The user for whom to update and claim tokens
  /// @param dripTokens The drip tokens whose entire balance will be claimed after the update.
  /// @return The claimable balance of each of the passed drip tokens for the user.  These are the post-update balances, and therefore the most accurate.
  function updateAndClaimDrips(
    UpdatePair[] calldata pairs,
    address user,
    address[] calldata dripTokens
  )
    external returns (DripTokenBalance[] memory)
  {
    DripTokenBalance[] memory balances = updateDrips(pairs, user, dripTokens);
    claimDrips(user, dripTokens);
    return balances;
  }

  function _activeBalanceDripTokens(address source, address measure) internal view returns (address[] memory) {
    return balanceDrips[source].activeBalanceDrips[measure].addressArray();
  }

  function _activeVolumeDripTokens(address source, address measure) internal view returns (address[] memory) {
    return volumeDrips[source].activeVolumeDrips[measure].addressArray();
  }

  function _activeReferralVolumeDripTokens(address source, address measure) internal view returns (address[] memory) {
    return referralVolumeDrips[source].activeVolumeDrips[measure].addressArray();
  }

  /// @notice Updates the balance drips
  /// @param source The Prize Pool of the balance drip
  /// @param manager The BalanceDripManager whose drips should be updated
  /// @param measure The measure token whose balance is changing
  /// @param measureTotalSupply The last total supply of the measure tokens
  /// @param currentTime The current
  function _updateActiveBalanceDrips(
    BalanceDripManager.State storage manager,
    address source,
    address measure,
    uint256 measureTotalSupply,
    uint256 currentTime
  ) internal {
    address prevDripToken = manager.activeBalanceDrips[measure].end();
    address currentDripToken = manager.activeBalanceDrips[measure].start();
    while (currentDripToken != address(0) && currentDripToken != manager.activeBalanceDrips[measure].end()) {
      BalanceDrip.State storage dripState = manager.balanceDrips[measure][currentDripToken];
      uint256 limit = _availableDripTokenBalance(currentDripToken);

      uint256 newTokens = dripState.drip(
        measureTotalSupply,
        currentTime,
        limit
      );

      // if we've hit the limit, then kill it.
      bool isDripComplete = newTokens == limit;

      if (isDripComplete) {
        _deactivateBalanceDrip(source, measure, currentDripToken, prevDripToken);
      }

      prevDripToken = currentDripToken;
      currentDripToken = manager.activeBalanceDrips[measure].next(currentDripToken);
    }
  }

  /// @notice Records a deposit for a volume drip
  /// @param source The Prize Pool of the volume drip
  /// @param manager The VolumeDripManager containing the drips that need to be iterated through.
  /// @param isReferral Whether the passed manager contains referral volume drip
  /// @param measure The token that was deposited
  function _updateActiveVolumeDrips(
    VolumeDripManager.State storage manager,
    address source,
    address measure,
    bool isReferral
  )
    internal
  {
    address prevDripToken = manager.activeVolumeDrips[measure].end();
    uint256 currentTime = _currentTime();
    address currentDripToken = manager.activeVolumeDrips[measure].start();
    while (currentDripToken != address(0) && currentDripToken != manager.activeVolumeDrips[measure].end()) {
      VolumeDrip.State storage dripState = manager.volumeDrips[measure][currentDripToken];
      uint256 limit = _availableDripTokenBalance(currentDripToken);

      uint32 lastPeriod = dripState.periodCount;
      uint256 newTokens = dripState.drip(
        currentTime,
        limit
      );
      if (lastPeriod != dripState.periodCount) {
        emit VolumeDripPeriodEnded(
          source,
          measure,
          currentDripToken,
          isReferral,
          lastPeriod,
          dripState.periods[lastPeriod].totalSupply,
          newTokens
        );
        emit VolumeDripPeriodStarted(
          source,
          measure,
          currentDripToken,
          isReferral,
          dripState.periodCount,
          dripState.periods[dripState.periodCount].dripAmount,
          dripState.periods[dripState.periodCount].endTime
        );
      }

      // if we've hit the limit, then kill it.
      bool isDripComplete = newTokens == limit;


      if (isDripComplete) {
        _deactivateVolumeDrip(source, measure, currentDripToken, isReferral, prevDripToken);
      }

      prevDripToken = currentDripToken;
      currentDripToken = manager.activeVolumeDrips[measure].next(currentDripToken);
    }
  }

  function _addDripBalance(address dripToken, address user, uint256 amount) internal returns (uint256) {
    uint256 amountAvailable = _availableDripTokenBalance(dripToken);
    uint256 actualAmount = (amount > amountAvailable) ? amountAvailable : amount;

    dripTokenTotalSupply[dripToken] = dripTokenTotalSupply[dripToken].add(actualAmount);
    dripTokenBalances[dripToken][user] = dripTokenBalances[dripToken][user].add(actualAmount);

    emit DripTokenDripped(dripToken, user, actualAmount);
    return actualAmount;
  }

  function _availableDripTokenBalance(address dripToken) internal view returns (uint256) {
    uint256 comptrollerBalance = IERC20(dripToken).balanceOf(address(this));
    uint256 totalClaimable = dripTokenTotalSupply[dripToken];
    return (totalClaimable < comptrollerBalance) ? comptrollerBalance.sub(totalClaimable) : 0;
  }

  /// @notice Called by a "source" (i.e. Prize Pool) when a user mints new "measure" tokens.
  /// @param to The user who is minting the tokens
  /// @param amount The amount of tokens they are minting
  /// @param measure The measure token they are minting
  /// @param referrer The user who referred the minting.
  function beforeTokenMint(
    address to,
    uint256 amount,
    address measure,
    address referrer
  )
    external
    override
  {
    address source = _msgSender();
    uint256 balance = IERC20(measure).balanceOf(to);
    uint256 totalSupply = IERC20(measure).totalSupply();

    address[] memory balanceDripTokens = _activeBalanceDripTokens(source, measure);
    _updateActiveBalanceDrips(
      balanceDrips[source],
      source,
      measure,
      totalSupply,
      _currentTime()
    );
    _captureClaimsForBalanceDrips(source, measure, to, balance, balanceDripTokens);

    address[] memory volumeDripTokens = _activeVolumeDripTokens(source, measure);
    _updateActiveVolumeDrips(
      volumeDrips[source],
      source,
      measure,
      false
    );
    _mintAndCaptureForVolumeDrips(source, measure, to, amount, volumeDripTokens);

    if (referrer != address(0)) {
      address[] memory referralVolumeDripTokens = _activeReferralVolumeDripTokens(source, measure);
      _updateActiveVolumeDrips(
        referralVolumeDrips[source],
        source,
        measure,
        true
      );
      _mintAndCaptureReferralVolumeDrips(source, measure, referrer, amount, referralVolumeDripTokens);
     }
  }

  /// @notice Called by a "source" (i.e. Prize Pool) when tokens change hands or are burned
  /// @param from The user who is sending the tokens
  /// @param to The user who is receiving the tokens
  /// @param measure The measure token they are burning
  function beforeTokenTransfer(
    address from,
    address to,
    uint256,
    address measure
  )
    external
    override
  {
    if (from == address(0)) {
      // ignore minting
      return;
    }
    address source = _msgSender();
    uint256 totalSupply = IERC20(measure).totalSupply();
    uint256 fromBalance = IERC20(measure).balanceOf(from);

    address[] memory balanceDripTokens = _activeBalanceDripTokens(source, measure);

    _updateActiveBalanceDrips(
      balanceDrips[source],
      source,
      measure,
      totalSupply,
      _currentTime()
    );

    _captureClaimsForBalanceDrips(source, measure, from, fromBalance, balanceDripTokens);

    if (to != address(0)) {
      uint256 toBalance = IERC20(measure).balanceOf(to);
      _captureClaimsForBalanceDrips(source, measure, to, toBalance, balanceDripTokens);
    }
  }

  /// @notice returns the current time.  Allows for override in testing.
  /// @return The current time (block.timestamp)
  function _currentTime() internal virtual view returns (uint256) {
    return block.timestamp;
  }

}


// Root file: contracts/test/ComptrollerHarness.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

// import "contracts/comptroller/Comptroller.sol";

/* solium-disable security/no-block-members */
contract ComptrollerHarness is Comptroller {

  uint256 internal time;

  function setCurrentTime(uint256 _time) external {
    time = _time;
  }

  function _currentTime() internal override view returns (uint256) {
    return time;
  }

}