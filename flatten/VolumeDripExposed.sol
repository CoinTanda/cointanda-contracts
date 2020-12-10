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


// Root file: contracts/test/VolumeDripExposed.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

// import "contracts/drip/VolumeDrip.sol";

contract VolumeDripExposed {
  using VolumeDrip for VolumeDrip.State;

  event DripTokensBurned(address user, uint256 amount);
  event Minted(uint256 amount);
  event MintedTotalSupply(uint256 amount);

  VolumeDrip.State state;

  function setNewPeriod(uint32 periodSeconds, uint112 dripAmount, uint32 endTime) external {
    state.setNewPeriod(periodSeconds, dripAmount, endTime);
  }

  function setNextPeriod(uint32 periodSeconds, uint112 dripAmount) external {
    state.setNextPeriod(periodSeconds, dripAmount);
  }

  function drip(uint256 currentTime, uint256 maxNewTokens) external returns (uint256) {
    uint256 newTokens = state.drip(currentTime, maxNewTokens);

    emit MintedTotalSupply(newTokens);

    return newTokens;
  }

  function mint(address user, uint256 amount) external returns (uint256) {
    uint256 accrued = state.mint(user, amount);

    emit Minted(accrued);

    return accrued;
  }

  function getDrip()
    external
    view
    returns (
      uint32 periodSeconds,
      uint128 dripAmount
    )
  {
    periodSeconds = state.nextPeriodSeconds;
    dripAmount = state.nextDripAmount;
  }

  function getPeriod(uint32 period)
    external
    view
    returns (
      uint112 totalSupply,
      uint112 dripAmount,
      uint32 endTime
    )
  {
    totalSupply = state.periods[period].totalSupply;
    endTime = state.periods[period].endTime;
    dripAmount = state.periods[period].dripAmount;
  }

  function getDeposit(address user)
    external
    view
    returns (
      uint112 balance,
      uint32 period
    )
  {
    balance = state.deposits[user].balance;
    period = state.deposits[user].period;
  }

}
