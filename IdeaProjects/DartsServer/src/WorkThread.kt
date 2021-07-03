

/**
 *  Класс WorkThread - будет обрабатывать входящее соединение
 */

class WorkThread(val con: Connection): Thread(){

    private var isRunning: Boolean = false

    @Override
    override fun run() {
        while (isRunning){
            if ((con.sock != null) and (!con.sock.isClosed)){

            }
        }

    }
}