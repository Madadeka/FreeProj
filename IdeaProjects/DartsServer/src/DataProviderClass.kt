//import jdk.internal.misc.Signal.handle
import com.google.gson.Gson
import java.net.ServerSocket
import java.net.Socket
import java.nio.charset.Charset

/**
 *  Класс tDataProvider - сервер для подключения клиентов и обработки запросов от них
 *  Данные передаются в формате json
 *  У класса есть объект для работы с базой данных PostgreSQL
 */

class DataProvider(settings: ProviderSettings) {
    var fIsRunning: Boolean = false
    private  val fServerPort = settings.servPort
    private lateinit var fServer: ServerSocket
    private lateinit var conList: MutableList<Connection>
    private val dbConnection = PostgreSQLConnection(
        settings.dbip,
        settings.dbPort,
        settings.dbName,
        settings.dbUser,
        settings.dbPassWord)

    private fun requestProcess(RequestString: String, con: Connection) {
        when (RequestString){

            "SaveLiteGame" -> {
                //после выполнения ответ клиенту не предусмотрен!
                saveLiteGame(con)
            }

            "GetAllFromGames" -> {
                getAllFromGames(con)
            }

            "GetLiteGamesWithPlayer" -> {
                getLiteGamesWithPlayer(con)
            }

            "GetLiteGamesWithPlayers" -> {
                getLiteGamesWithPlayers(con)
            }

            else -> con.closeConnection()

        }
    }
    //накапливаю статистику, перевожу все в одну строку, разделитель - "01010", пересылаю все одним пакетом
    private fun getAllFromGames(con: Connection){
        try {
            var conRequest: String = "IDWait" + "\n"
            con.sendData(conRequest.toByteArray(Charset.defaultCharset()))
            println("string out: $conRequest")
            conRequest = con.readData()
            if ((conRequest != "") and (conRequest == "All")) {
                println("string in: $conRequest")
                val games = dbConnection.getAllFromGames()
                var str : String = ""
                for (game in games){
                    print(game.toStr() + "\n")
                    val JSON = Gson().toJson(game)
                    str += JSON.toString() + "01010"
                }
                str += "\n"
                con.sendData(str.toByteArray(Charset.defaultCharset()))
                print("Answer sent to client")
            }
        }
        finally {
            //fun getLiteGameWithPlayer(player: String): List<tGame>
        }
    }

    private fun getLiteGamesWithPlayer(con: Connection){
        try {
            var conRequest: String = "IDWait" + "\n"
            con.sendData(conRequest.toByteArray(Charset.defaultCharset()))
            println("string out: $conRequest")
            conRequest = con.readData()
            if (conRequest != "") {
                println("string in: $conRequest")
                val games = dbConnection.getLiteGameWithPlayer(conRequest)
                var str : String = ""
                for (game in games){
                    print(game.toStr() + "\n")
                    val JSON = Gson().toJson(game)
                    str += JSON.toString() + "01010"
                }
                str += "\n"
                con.sendData(str.toByteArray(Charset.defaultCharset()))
                print("Answer sent to client")
            }
        }
        finally {
            //fun getLiteGameWithPlayer(player: String): List<tGame>
        }
    }

    private fun saveLiteGame(con: Connection){
        try {
            var conRequest: String = "IDWait" + "\n"
            con.sendData(conRequest.toByteArray(Charset.defaultCharset()))
            println("string out: $conRequest")
            conRequest = con.readData()
            if (conRequest != "") {
                println("string in: $conRequest")
                val JSON = Gson()
                val tempGame = JSON.fromJson(conRequest,Game::class.java)
                println("")
                println(tempGame.id.toString())
                println("${tempGame.player1}: ${tempGame.Result1}")
                println("${tempGame.player2}: ${tempGame.Result2}")
                println()
                dbConnection.addLightGame(
                    tempGame.player1,
                    tempGame.Result1,
                    tempGame.player2,
                    tempGame.Result2
                )
            }
        }
        finally {
            //
        }
    }

    private fun getLiteGamesWithPlayers(con: Connection){
        try {
            var conRequest: String = "IDWait" + "\n"
            con.sendData(conRequest.toByteArray(Charset.defaultCharset()))
            println("string out: $conRequest")
            conRequest = con.readData()
            if (conRequest != "") {

                //получение списка игроков
                val strs = conRequest.split("01010")
                var players = mutableListOf<String>()
                for (str in strs){
                    if (str != ""){
                        players.add(str)
                    }
                }
                //получение списка игроков

                if (players.count() == 2){
                    println("string in: player1 = ${players[0]}, player2 = ${players[1]}")
                    val games = dbConnection.getLiteGameWithPlayers(players[0],players[1])
                    var str : String = ""
                    for (game in games){
                        print(game.toStr() + "\n")
                        val JSON = Gson().toJson(game)
                        str += JSON.toString() + "01010"
                    }
                    str += "\n"
                    con.sendData(str.toByteArray(Charset.defaultCharset()))
                    print("Answer sent to client")
                }
                else{
                    con.sendData("none".toByteArray(Charset.defaultCharset()))
                }

            }
        }
        finally {
            //fun getLiteGameWithPlayer(player: String): List<tGame>
        }
    }

    fun addPort(){
        fIsRunning = true
        fServer = ServerSocket(fServerPort)
        println("server is running at port = $fServerPort")
        while (fIsRunning){
            //TODO: переделать под AsynchronousSocketChannel
            val client: Socket = fServer.accept()

            if (client != null){
                println("got new connection...\n ip: ${client.inetAddress} port: ${client.port}")
                val tempConnection = Connection(client)
                conList = mutableListOf()
                conList.add(tempConnection)
                println(conList.count().toString())
            }
            Thread.sleep(1)
            //
            for (con: Connection in conList){

                if (con.sock == null){
                    conList.remove(con)
                    println("connection closed...")
                    continue
                }

                var conRequest = ""
                conRequest = con.readData()
                //пришел запрос
                if (conRequest != "") {
                    println("string in: $conRequest")
                    //обработка запроса
                    this.requestProcess(conRequest, con)
                    break
                }
            }
        }
    }

}