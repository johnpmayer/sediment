
package sediment.common

import world.WorldOuterClass

import java.nio.file.{Paths, StandardOpenOption}
import java.nio.channels.{Channels, FileChannel}

object WorldLoader {
  def main(args: Array[String]) {
    val worldPath = Paths.get(args(0))
    val worldFileChannel = FileChannel.open(worldPath, StandardOpenOption.READ)
    // val loader = WorldFileLoader.fromInputStream(Channels.newInputStream(worldFileChannel))
    println("WORKING")
  }
}
