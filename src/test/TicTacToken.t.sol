// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
    uint8 internal constant EMPTY = 0;
    uint8 internal constant X = 1;
    uint8 internal constant O = 2;

    function test_has_empty_board() public {
        for (uint8 i = 0; i < 9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function test_get_board() public {
        uint8[9] memory expected = [
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY
        ];
        uint8[9] memory actual = ttt.getBoard();
        for (uint8 i = 0; i < 9; i++) {
            assertEq(actual[i], expected[i]);
        }
    }

    function test_can_mark_space_with_X() public {
        ttt.markSpace(0, X);
        assertEq(ttt.board(0), X);
    }

    function test_can_mark_space_with_O() public {
        ttt.markSpace(0, O);
        assertEq(ttt.board(0), O);
    }

    function testFail_cannot_mark_space_with_other_symbol() public {
        ttt.markSpace(0, 3);
    }

    function testFail_cannot_overwrite_marked_space() public {
        ttt.markSpace(0, X);
        ttt.markSpace(0, O);
    }

    function test_checks_for_horizontal_win() public {
        ttt.markSpace(0, X);
        ttt.markSpace(1, X);
        ttt.markSpace(2, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_vertical_win() public {
        ttt.markSpace(0, O);
        ttt.markSpace(3, O);
        ttt.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_checks_for_diagonal_win() public {
        ttt.markSpace(0, X);
        ttt.markSpace(4, X);
        ttt.markSpace(8, X);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_antidiagonal_win() public {
        ttt.markSpace(2, O);
        ttt.markSpace(4, O);
        ttt.markSpace(6, O);
        assertEq(ttt.winner(), O);
    }

    function test_returns_zero_on_no_winner() public {
        ttt.markSpace(1, X);
        ttt.markSpace(4, O);
        assertEq(ttt.winner(), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(), 0);
    }
}
