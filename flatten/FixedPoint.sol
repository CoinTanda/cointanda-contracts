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


// Root file: contracts/external/pooltogether/FixedPoint.sol

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

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
