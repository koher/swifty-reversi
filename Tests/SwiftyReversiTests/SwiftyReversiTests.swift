import XCTest
import SwiftyReversi

final class SwiftyReversiTests: XCTestCase {
    func testExample() {
        do {
            var game = Game(board: Board("""
            --------
            --------
            --------
            ---ox---
            ---xo---
            --------
            --------
            --------
            """), turn: .dark)
            try game.placeDiskAt(x: 3, y: 2)
            
            XCTAssertEqual(game.state, .beingPlayed(turn: .light))
            XCTAssertEqual(game.board, Board("""
            --------
            --------
            ---x----
            ---xx---
            ---xo---
            --------
            --------
            --------
            """))
        } catch {
            XCTFail("\(error)")
        }
    }
}
