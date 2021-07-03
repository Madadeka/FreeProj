
class Game() {
    var id: Int = 0
    var date: String = ""
    var player1: String = ""
    var Result1: Int = 0
    var player2: String = ""
    var Result2: Int = 0

    fun toStr(): String {
        return "Game: $id; date: ${date.toString()}  player1: $player1; Result: $Result1; player2: $player2; Result2: $Result2"
    }
}