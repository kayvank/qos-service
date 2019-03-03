package repository

import com.typesafe.scalalogging.LazyLogging
import org.specs2.mutable.Specification
import doobie.imports._
import scalaz._, Scalaz._
import model._

class DSSpec extends Specification with LazyLogging {

  import Ds._

  "Data srouce specifications".title

  "test database connection(s) " >> {
    42.point[ConnectionIO].transact(hxa).run === 42
  }
  "Compute qos insert event " >> {
    val q = Qos(
      bitrate = (1.1).some,
      bandwidth = None,
      qos_quality = None,
      qos_startup_time = (1.1).some,
      qos_buffering_spinner_duration = (1.1).some,
      qos_buffering_spinner_events = (1).some,
      qos_buffering_at_end = true.some
    )
    val v = Video(
      noun_id = "123".some,
      video_id = "123".some,
      url = ("urlspecial").some,
      is_ad_bool = true,
      name = "play".some
    )
    val g = Geo(
      ip_address = "1.1.1.1",
      region = "markaz".some,
      city = "tehran".some,
      country = "iran",
      lat = (0.001).some,
      lng = (0.001).some
    )
    val d = Device(platform = "ios-platform",
      app_version = "appversion-2",
      device = "ios-device",
      user_id = "userid-123".some,
      anon_id = "123anon"
    )
    val u = UserAgent("Agent-99")
    val a = Some(123L)
    val na = Some("nonandroidbuild")

    val qos = QosStream(q, v, g, d, u, BuildNumber(a, na))
    val computedMonad = QosStreamRepository.insertBatch(List(qos))
    computedMonad.some.isDefined
  }

}
