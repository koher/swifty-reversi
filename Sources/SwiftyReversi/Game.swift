public struct Game {
    public private(set) var board: Board
    public private(set) var state: State
    
    public init(board: Board = Board(width: 8, height: 8), turn: Disk = .dark) {
        self.board = board
        self.state = Game.normalizedState(with: board, for: turn)
    }
    
    private static func normalizedState(with board: Board, for turn: Disk) -> State {
        if board.hasValidMoves(for: turn) || board.hasValidMoves(for: turn.flipped) {
            return .beingPlayed(turn: turn)
        } else {
            return .over(winner: board.sideWithMoreDisks())
        }
    }
    
    public mutating func placeDiskAt(x: Int, y: Int) throws {
        guard case .beingPlayed(let turn) = self.state else {
            throw DiskPlacementError.illegalState
        }
        
        do {
            try board.place(turn, atX: x, y: y)
        } catch _ {
            throw DiskPlacementError.illegalPosition(x: x, y: y)
        }
        
        self.state = Game.normalizedState(with: board, for: turn.flipped)
    }
    
    public mutating func pass() throws {
        guard case .beingPlayed(let turn) = self.state else {
            throw PassError.illegalState
        }
        if board.hasValidMoves(for: turn) {
            throw PassError.havingValidMoves
        }
        
        self.state = .beingPlayed(turn: turn.flipped)
    }
    
    public enum State: Equatable {
        case beingPlayed(turn: Disk)
        case over(winner: Disk?)
    }

    public enum DiskPlacementError: Error {
        case illegalState
        case illegalPosition(x: Int, y: Int)
    }
    
    public enum PassError: Error {
        case illegalState
        case havingValidMoves
    }
}

