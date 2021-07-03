import java.io.File

class ProviderSettings(){
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
        var someCheck = 0
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
                    someCheck++
                }
                "dbip" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbip = tempString
                    someCheck++

                }
                "dbPort" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbPort = tempString
                    someCheck++

                }
                "dbName" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbName = tempString
                    someCheck++

                }
                "dbUser" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbUser = tempString
                    someCheck++

                }
                "dbPassWord" in line -> {
                    var tempString = dropTrash(line)
                    if (tempString == ""){
                        return false
                    }
                    dbPassWord = tempString
                    someCheck++

                }
            }
        }
        if (someCheck == 6){
            return true
        }
        return false
    }
}