# SwiftyReversi

A [Reversi](https://en.wikipedia.org/wiki/Reversi) library for Swift.

```swift
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
```

## License

[MIT](LICENSE)
