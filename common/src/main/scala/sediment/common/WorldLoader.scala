
package sediment.common

import org.worldengine.world.WorldFileLoader

import java.io.ByteArrayInputStream

object WorldLoader extends App {
    val test = new ByteArrayInputStream("abc".getBytes)
    val loader = WorldFileLoader.fromInputStream(test)
    println("WORKING")
}