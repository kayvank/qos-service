package model

import io.circe._
import scalaz._
import Scalaz._
import io.circe.generic.auto._
import io.circe.optics.JsonPath._
import model.ModelExceptions.NoQosElementFoundException
import utils.EitherToDisjunction._

object DomainProtocols {

  val buildNumberAsLong: Json => Option[Long] = endoJson =>
    root.device_context.build_number.long.getOption(endoJson)

  val buildNumberAsString: Json => Option[String] = endoJson =>
    root.device_context.build_number.string.getOption(endoJson)


  implicit class QosProtocol(jsonEventData: Json) {
    def asQos: \/[DecodingFailure, Qos] = {

      val endoJson = jsonEventData
      endoJson.as[Qos]
    }
  }

  implicit class VideoProtocol(jsonEventData: Json) {
    def asVideo: \/[DecodingFailure, Video] = {
      val endoJson = jsonEventData
      endoJson.as[Video]
    }
  }

  implicit class GeoProtocol(endoEventData: Json) {
    def asGeo: \/[DecodingFailure, Geo] = {
      val endoJson = endoEventData
      endoJson.as[Geo]
    }
  }

  implicit class DeviceProtocol(endoEventData: Json) {
    def asDevice: \/[DecodingFailure, Device] = {
      val endoJson = endoEventData
      endoJson.as[Device]
    }
  }

  implicit class UserAgentProtocol(json: Json) {
    def asUserAgent: \/[DecodingFailure, UserAgent] = {
      val endoJson = json
      endoJson.as[UserAgent]
    }
  }

  implicit class QProtocol(json: Json) {

    def asQosStream: \/[Throwable, QosStream] = {
      val endoJson = json

      val jsonEventData =
        root.event_data.json.getOption(endoJson).getOrElse(Json.Null)

      for {
        maybeQos <- jsonEventData.asQos
        q <- if (maybeQos.isValid) \/-(maybeQos); else -\/(NoQosElementFoundException(s"${endoJson}")) //(new NoQosElementFoundException(s"${endoJson}"))
        v <- jsonEventData.asVideo
        g <- root.geo_ip.json.getOption(endoJson).getOrElse(Json.Null).asGeo
        d <- root.device_context.json.getOption(endoJson).getOrElse(Json.Null).asDevice
        u <- endoJson.asUserAgent
      } yield (QosStream(qos = q,
        video = v,
        device = d,
        geo = g,
        userAgent = u,
        buildNumber = BuildNumber(
          buildAsLong = buildNumberAsLong(endoJson),
          buildAsString = buildNumberAsString(endoJson))))
    }
  }

}
