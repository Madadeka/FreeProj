//import jdk.internal.misc.Signal.handle
import com.google.gson.Gson
import java.net.ServerSocket
import java.net.Socket
import java.nio.charset.Charset
import java.util.*


class tConnection(var sock: Socket){
//    lateinit var rTime: Date

    private fun closeConnection(){
        if (this.sock != null && !this.sock.isClosed()) {
            try {
                this.sock.close()
            } catch (ex: Exception) {
                print("Невозможно закрыть сокет: " + ex.printStackTrace())
            } finally {
                //
            }
        }
        //
    }

    fun sendData(data: ByteArray?) {
        if (this.sock == null || this.sock.isClosed()) {
            print("Невозможно отправить данные. Сокет не создан или закрыт")
        }
        try {
            this.sock.getOutputStream().write(data)
            this.sock.getOutputStream().flush()
        } catch (ex: Exception) {
            print("Невозможно отправить данные: " + ex.printStackTrace())
        }
    }

    fun readData(): String {
        var str = ""
        if (this.sock == null || this.sock.isClosed()) {
            print("Невозможно считать данные. Сокет не создан или закрыт")
        }
        val reader = Scanner(this.sock.getInputStream())
        try {
            str += reader.nextLine()
        }
        catch (ex: Exception) {
            print("Невозможно считать данные: " + ex.printStackTrace())
        }
        return str
    }

}

class tWorkThread(val con: tConnection): Thread(){
    //    private var conList = mutableListOf<tConnection>()
//    private var isBusy = BusyFlag()
    private var isRunning: Boolean = false

//    fun addConnection(con: tConnection){
//        synchronized(isBusy){
//            this.conList.add(con)
//        }
//    }

//    fun removeConnection(con: tConnection){
//        synchronized(isBusy){
////            con.fChannal.close()
//            this.conList.remove(con)
//        }
//    }

    @Override
    override fun run() {
        while (isRunning){
            if ((con.sock != null) and (!con.sock.isClosed)){

            }
        }

    }
}

/**
 *  Класс tDataProvider - сервер для подключения клиентов и обработки запросов от них
 *  Данные передаются в формате json
 *  У класса есть объект для работы с базой данных PostgreSQL
 */

class tDataProvider(settings: providerSettings) {
    var fIsRunning: Boolean = false
    private  val fServerPort = settings.servPort
    private lateinit var fServer: ServerSocket
    private lateinit var conList: MutableList<tConnection>
    private val dbConnection = TPostgreSQLConnection(
        settings.dbip,
        settings.dbPort,
        settings.dbName,
        settings.dbUser,
        settings.dbPassWord)

    private fun requestProcess(RequestString: String, con: tConnection) {
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

            else -> con.sock.close() //TODO:

        }
    }
    //накапливаю статистику, перевожу все в одну строку, разделитель - "01010", пересылаю все одним пакетом
    private fun getAllFromGames(con: tConnection){
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

    private fun getLiteGamesWithPlayer(con: tConnection){
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

    private fun saveLiteGame(con: tConnection){
        try {
            var conRequest: String = "IDWait" + "\n"
            con.sendData(conRequest.toByteArray(Charset.defaultCharset()))
            println("string out: $conRequest")
            conRequest = con.readData()
            if (conRequest != "") {
                println("string in: $conRequest")
                val JSON = Gson()
                val tempGame = JSON.fromJson(conRequest,tGame::class.java)
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

    private fun getLiteGamesWithPlayers(con: tConnection){
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
                val tempConnection = tConnection(client)
                conList = mutableListOf()
                conList.add(tempConnection)
                println(conList.count().toString())
            }
            Thread.sleep(1)
            //
            for (con: tConnection in conList){

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