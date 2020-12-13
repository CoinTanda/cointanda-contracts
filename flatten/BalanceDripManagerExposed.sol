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


// Root file: contracts/test/BalanceDripManagerExposed.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

// import "contracts/drip/BalanceDripManager.sol";

contract BalanceDripManagerExposed {
  using BalanceDripManager for BalanceDripManager.State;

  BalanceDripManager.State dripManager;

  function activateDrip(address measure, address dripToken, uint256 dripRatePerSecond) external {
    dripManager.activateDrip(measure, dripToken, dripRatePerSecond);
  }

  function deactivateDrip(address measure, address prevDripToken, address dripToken, uint32 currentTime, uint256 maxNewTokens) external {
    dripManager.deactivateDrip(measure, prevDripToken, dripToken, currentTime, maxNewTokens);
  }

  function isDripActive(address measure, address dripToken) external view returns (bool) {
    return dripManager.isDripActive(measure, dripToken);
  }

  function setDripRate(address measure, address dripToken, uint256 dripRatePerSecond, uint32 currentTime, uint256 maxNewTokens) external {
    dripManager.setDripRate(measure, dripToken, dripRatePerSecond, currentTime, maxNewTokens);
  }

  function getActiveBalanceDrips(address measure) external view returns (address[] memory) {
    return dripManager.getActiveBalanceDrips(measure);
  }

  function getDrip(
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
    BalanceDrip.State storage dripState = dripManager.getDrip(measure, dripToken);
    dripRatePerSecond = dripState.dripRatePerSecond;
    exchangeRateMantissa = dripState.exchangeRateMantissa;
    timestamp = dripState.timestamp;
  }
}
