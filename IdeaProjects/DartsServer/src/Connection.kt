import java.net.Socket
import java.util.*

class Connection(var sock: Socket){
//    lateinit var rTime: Date

    fun closeConnection(){
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