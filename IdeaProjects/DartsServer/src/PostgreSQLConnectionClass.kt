import java.sql.Connection
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.SQLException

/**
 * Класс TPostgreSQLConnection служит для подключения к БД PostgreSQL и обработки запросов
 * класс хранит ip- адрес, порт бд, имя бд, пользователя и пароль
 */

class PostgreSQLConnection(private val ip: String,
                           private val port: String,
                           private val db: String,
                           private val user: String,
                           private val pass: String) {

    private var conn: Connection? = null

    private fun queryExecute(qStr: String): ResultSet? {
        val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
        val query = state.executeQuery(qStr)
        query.first()
        return query
    }

    fun findUserInTableByName(name: String): Person {
        dbConnect()
        println("send get person in users...")
        val tempPerson = Person()
        try {
            val qStr = "SELECT * FROM testusers where username = '$name';"
            val query = queryExecute(qStr)
            if (query != null) {
                tempPerson.name = query.getString("username")
                tempPerson.pass = query.getString("pass")
            }
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
        finally {
            dbDisconnect()
        }
        return tempPerson
    }

    fun findUserInTableByID(){

    }

    fun getAllFromUsers(): List<Person> {
        dbConnect()
        val tempList = mutableListOf<Person>()
        try {
            println("send get all in users...")
            val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
            val query = state.executeQuery("SELECT * FROM testusers")
            query.first()


            do {
                val tempPerson = Person()
                tempPerson.name = query.getString("username")
                tempPerson.pass = query.getString("pass")
                tempList.add(tempPerson)
            } while (query.next())
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
        finally {
            dbDisconnect()
        }
        return tempList
    }

    //тестовый метод
    fun getAllFields() {
        dbConnect()
        println("send get all in users...")
        val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
        val query = state.executeQuery("SELECT * FROM testusers")
        query.first()
        //получить количество столбцов таблицы
        val columnsCount = query.metaData.columnCount
        println(columnsCount.toString())

        //вывод поочередно имен столбцов
        for (i in 1..columnsCount) {
            print(query.metaData.getColumnName(i) + " / ")
        }
        println()
        //вывод поочередно значений ячеек
        println(query.getString("username") + " / " + query.getString("pass"))
        while (query.next()) {
            var tempStr = ""
            for (i in 1 .. columnsCount) {
                tempStr += query.getString(i) + " / "
            }
            tempStr = tempStr.subSequence(0, tempStr.length - 2) as String
            println(tempStr)
        }
        dbDisconnect()
    }


    private fun dbConnect(){
        val drvName = "org.postgresql.Driver"

        try {
            Class.forName(drvName)
            val connString = "jdbc:postgresql://$ip:$port/$db"
            conn = DriverManager.getConnection(connString, user, pass)
        }
        catch (ex: ClassNotFoundException){
            print("No PostgreSQL JDBC Driver found")
            ex.printStackTrace()
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
    }

    private fun dbDisconnect() {
        if (conn != null) {
            try {
                conn!!.close()
                conn = null
            }
            catch (ex: SQLException) {
                // handle any errors
                ex.printStackTrace()
            }
        }
    }

    fun createLightGameTable() {
        dbConnect()
        println("send Create gamesTable...")
        val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
        val sqlString = "CREATE TABLE gamesTest " +
                "(" +
                "id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY," +
                "gameData date," +
                "player1 varchar(30)," +
                "Result1 Int," +
                "player2 varchar(30)," +
                "Result2 Int" +
                ");"
        state.executeUpdate(sqlString)
        dbDisconnect()
    }

    fun addLightGame(p1: String, res1: Int, p2: String, res2: Int) {
        dbConnect()
        println("send insert lightGames...")
        val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
        val sqlString = "INSERT INTO gamesTest " +
                "(gameData, player1, Result1, player2, Result2) VALUES " +
                "(current_date, '$p1', $res1, '$p2', $res2);"
        try {
            state.executeUpdate(sqlString)
        }
        catch (ex: SQLException) {
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            ex.printStackTrace()
        }
        finally {
            println("end sending insert")
        }
        dbDisconnect()
    }

    fun getAllFromGames(): List<Game> {
        dbConnect()
        val tempList = mutableListOf<Game>()
        try {
            println("send get all from gamestest...")
            val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
            val query = state.executeQuery("SELECT * FROM gamestest;")
            query.first()
            do {
                val tempGame = Game()
                tempGame.id = query.getString("id").toInt()
                tempGame.date = query.getString("gamedata")
                tempGame.player1 = query.getString("player1")
                tempGame.Result1 = query.getString("Result1").toInt()
                tempGame.player2 = query.getString("player2")
                tempGame.Result2 = query.getString("Result2").toInt()
                tempList.add(tempGame)
            } while (query.next())
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
        finally {
            dbDisconnect()
        }
        return tempList
    }

    fun getLiteGameWithPlayer(player: String): List<Game> {
        dbConnect()
        val tempList = mutableListOf<Game>()
        try {
            println("send get GameWithPlayer from gamestest...")
            val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
            val query = state.executeQuery("SELECT * FROM gamestest WHERE player1 = '$player' or player2 = '$player';")
            query.first()
            do {
                val tempGame = Game()
                tempGame.id = query.getString("id").toInt()
                tempGame.date = query.getString("gamedata")
                tempGame.player1 = query.getString("player1")
                tempGame.Result1 = query.getString("Result1").toInt()
                tempGame.player2 = query.getString("player2")
                tempGame.Result2 = query.getString("Result2").toInt()
                tempList.add(tempGame)
            } while (query.next())
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
        finally {
            dbDisconnect()
        }
        return tempList
    }

    fun getLiteGameWithPlayers(player1: String, player2: String): List<Game> {
        dbConnect()
        val tempList = mutableListOf<Game>()
        try {
            println("send get GameWithPlayers from gamestest...")
            val state = conn!!.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)
            val query = state.executeQuery("SELECT * FROM gamestest WHERE (player1 = '$player1' and player2 = '$player2') or " +
                    "(player1 = '$player2' and player2 = '$player1') ;")
            query.first()
            do {
                val tempGame = Game()
                tempGame.id = query.getString("id").toInt()
                tempGame.date = query.getString("gamedata")
                tempGame.player1 = query.getString("player1")
                tempGame.Result1 = query.getString("Result1").toInt()
                tempGame.player2 = query.getString("player2")
                tempGame.Result2 = query.getString("Result2").toInt()
                tempList.add(tempGame)
            } while (query.next())
        }
        catch (ex: SQLException) {
            // handle any errors
            ex.printStackTrace()
        }
        catch (ex: Exception) {
            // handle any errors
            ex.printStackTrace()
        }
        finally {
            dbDisconnect()
        }
        return tempList
    }

}