import java.io.File

enum class MSGid {
    IDNone,
    IDSaveLiteGame,
    IDWait,
    RetOK,
    RetErr
}
//{"Players":[{"player":" + name + ", "result": + result + },{"player":" + name + ", "result": + result + },"gameDuration":0}
//data class jsonObj(val comm: MSGid, var strValue1: String = "", var strValue2: String = "")

class BusyFlag(){

}

class tConnectionList() {
    private var conList = mutableListOf<tConnection>()
}

class TDPMessage(msgid: MSGid) {
    public val id: MSGid = msgid
}

class person(){
    public var id: Int = 0
    public var name: String = ""
    public var pass: String = ""
}

data class tpleyer( val name: String, val result:Int){
}

data class tempClass(val name:String, val points: Int){

}

data class tLiteGameValue(val name:String, val points: Int){

}

class tLiteGame(var players: List<tpleyer>){
}

class tGame() {
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


class providerSettings(){
    var servPort: Int = 0
    var dbip: String = ""
    var dbPort: String = ""
    var dbName: String = ""
    var dbUser: String = ""
    var dbPassWord: String = ""

    private fun dropTrash(str: String): String {
        var tempStr = str.dropWhile {
            it != '='
        }
        tempStr = tempStr.replace("=","")
        tempStr = tempStr.trim(' ')
        return tempStr
    }

    fun toStr(): String{
        return "Provider settings: \n" +
                "Server port = $servPort\n" +
                "data base ip = $dbip\n" +
                "data base port = $dbPort\n" +
                "data base name = $dbName\n" +
                "data base user = $dbUser\n" +
                "data base password = $dbPassWord\n"
    }

    fun getSettingsFromFile(fileName: String): Boolean{
        var omgCheck = 0
        if (!File(fileName).exists()){
            print("Error: file \"$fileName\" does not exist")
            return false
        }
        for (line in File(fileName).readLines()){
            when {
                "servPort" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString.toIntOrNull() == null){
                        return false
                    }
                    servPort = tempString.toInt()
                    omgCheck++
                }
                "dbip" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbip = tempString
                    omgCheck++

                }
                "dbPort" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbPort = tempString
                    omgCheck++

                }
                "dbName" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbName = tempString
                    omgCheck++

                }
                "dbUser" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbUser = tempString
                    omgCheck++

                }
                "dbPassWord" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbPassWord = tempString
                    omgCheck++

                }
            }
        }
        if (omgCheck == 6){
            return true
        }
        return false
    }
}