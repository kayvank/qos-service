package model

import org.specs2.mutable._
import com.typesafe.scalalogging.LazyLogging
import io.circe._
import io.circe.parser._
import scalaz._, Scalaz._
import scala.io.Source
import utils.EitherToDisjunction._


class DomainProtocolSpec extends Specification with LazyLogging {

  "Qos Domain Protocol conversion specs".title

  import DomainProtocols._

  "transform json to non-android qos" >> {

    val endoString =
      Source.fromInputStream(getClass.getResourceAsStream("/play-event.json")).mkString
    val enodJson: \/[Throwable, Json] = parse(endoString)
    val computed = for {
      j <- enodJson
      endoQosStream <- j.asQosStream
    } yield (endoQosStream)
    logger.info(s"----- nonandroid computed qos = ${computed}")
    computed.isRight
  }

  "transform android json to qos" >> {

    val endoString =
      Source.fromInputStream(getClass.getResourceAsStream("/play-event-android.json")).mkString
    val enodJson: \/[Throwable, Json] = parse(endoString)
    val computed = for {
      j <- enodJson
      endoQosStream <- j.asQosStream
    } yield (endoQosStream)
    logger.info(s"---android conversion-> ${computed}")
    computed.toOption.isDefined &&
      computed.toOption.get.qos.bandWidthOrBitRate.isDefined &&
      computed.toOption.get.build_number.isDefined
  }
  "transform android json & validate to qos" >> {

    val endoString =
      Source.fromInputStream(getClass.getResourceAsStream("/play-event-android.json")).mkString
    val enodJson: \/[Throwable, Json] = parse(endoString)
    val computed = for {
      j <- enodJson
      endoQosStream <- j.asQosStream
    } yield (endoQosStream)
    computed.toOption.isDefined &&
      computed.toOption.get.qos.bandWidthOrBitRate.isDefined &&
      computed.toOption.get.build_number.isDefined
  }

}
