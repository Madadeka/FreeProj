
import com.google.gson.Gson
import java.io.IOException
import java.net.Socket
import java.nio.charset.Charset
import java.util.*


fun myReadSocket(soc: Socket): String {
    println("read socket...")
    val reader = Scanner(soc.getInputStream())
    var str = ""
    try {
//        while (true) {
//            if (reader.nextLine() == "end"){
//                break
//            }
        str += reader.next()
//        }
    }
    catch  (ex: Exception){
        str = "RetErr"
        ex.printStackTrace()
    }
    finally {

    }
//    reader.close()
    return str
}

fun myWriteSocket(soc: Socket, str: String) {
    val writer = soc.getOutputStream()
    try {
        writer.write((str + "\n").toByteArray(Charset.defaultCharset()))
    }
    catch (ex: IOException){
        ex.printStackTrace()
    }
    finally {
        //
    }
}

fun saveLiteGame(clientSoc: Socket ,game: tGame){
    var str = "SaveLiteGame"
    myWriteSocket(clientSoc, str)
    println("string out: $str")
    val rTime = Date()
    while ((Date().time - rTime.time)  < 10) {
        val conRequest2: String = myReadSocket(clientSoc)
        if ((conRequest2 != "") and (conRequest2 == "IDWait")) {
            println("string in: $conRequest2")
            val JSON = Gson().toJson(game)
            str = JSON.toString()
            println(str)
            myWriteSocket(clientSoc, str)
            break
        }
    }
}

//TODO: переделать - принимать по одному tGame пока не "end"
fun getAllGames(clientSoc: Socket): List<tGame>{
    var games = mutableListOf<tGame>()
    var str = "GetAllFromGames"
    myWriteSocket(clientSoc, str)
    println("string out: $str")
//    val rTime = Date()
    var conRequest2: String = myReadSocket(clientSoc)
    if ((conRequest2 != "") and (conRequest2 == "IDWait")) {
        println("string in: $conRequest2")
        str = "All"
        println("string out: $str")
        myWriteSocket(clientSoc, str)
        Thread.sleep(100)
        conRequest2 = myReadSocket(clientSoc)
        val strs = conRequest2.split("01010")
        for (str in strs){
            if (str != ""){
                val JSON = Gson()
                val game = JSON.fromJson(str, tGame::class.java)
                games.add(game)
            }
        }
    }
    return games
}

//TODO: переделать - принимать по одному tGame пока не "end"
fun getLiteGamesWithPlayer(clientSoc: Socket, player: String): List<tGame>{
    var games = mutableListOf<tGame>()
    var str = "GetLiteGamesWithPlayer"
    myWriteSocket(clientSoc, str)
    println("string out: $str")
//    val rTime = Date()
    var conRequest2: String = myReadSocket(clientSoc)
    if ((conRequest2 != "") and (conRequest2 == "IDWait")) {
        println("string in: $conRequest2")
        str = "$player"
        println("string out: $str")
        myWriteSocket(clientSoc, str)
        Thread.sleep(100)
        conRequest2 = myReadSocket(clientSoc)
        val strs = conRequest2.split("01010")
        for (str in strs){
            if (str != ""){
                val JSON = Gson()
                val game = JSON.fromJson(str, tGame::class.java)
                games.add(game)
            }
        }
    }
    return games
}

//TODO: сделать ветку если пришло "none"
fun getLiteGamesWithPlayers(clientSoc: Socket, player1: String, player2: String): List<tGame>{
    var games = mutableListOf<tGame>()
    var str = "GetLiteGamesWithPlayers"
    myWriteSocket(clientSoc, str)
    println("string out: $str")
//    val rTime = Date()
    var conRequest2: String = myReadSocket(clientSoc)
    if ((conRequest2 != "") and (conRequest2 == "IDWait")) {
        println("string in: $conRequest2")
        str = "${player1}01010${player2}"
        println("string out: $str")
        myWriteSocket(clientSoc, str)
        Thread.sleep(100)
        conRequest2 = myReadSocket(clientSoc)
        val strs = conRequest2.split("01010")
        for (str in strs){
            if (str != ""){
                val JSON = Gson()
                val game = JSON.fromJson(str, tGame::class.java)
                games.add(game)
            }
        }
    }
    return games
}

fun main() {
    val port = 5012
    val clientSoc = Socket("127.0.0.1", port)
    println("try to connect at port = $port")
//    val game = tGame()
//    game.player1 = "Yuri"
//    game.Result1 = 7
//    game.player2 = "Maks"
//    game.Result2 = 0
//    saveLiteGame(clientSoc, game)
//    val l1 = getAllGames(clientSoc)
//    for (g1 in l1){
//        print(g1.toStr() + "\n")
//    }getLiteGamesWithPlayers

//    val l1 = getLiteGamesWithPlayer(clientSoc, "Maks")
//    for (g1 in l1){
//        print(g1.toStr() + "\n")
//    }

    val l1 = getLiteGamesWithPlayers(clientSoc, "Maks", "Dahilu")
    for (g1 in l1){
        print(g1.toStr() + "\n")
    }

}