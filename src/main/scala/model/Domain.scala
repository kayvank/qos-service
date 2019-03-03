package model

import java.nio.ByteBuffer
import io.circe.Json
import utils.Global.cfgVevo

sealed trait Domain

case class Qos(
  bitrate: Option[Double],
  bandwidth: Option[Double],
  qos_quality: Option[Double],
  qos_startup_time: Option[Double],
  qos_buffering_spinner_duration: Option[Double],
  qos_buffering_spinner_events: Option[Int],
  qos_buffering_at_end: Option[Boolean],
  qos_telemetry: Option[Json] = None
) extends Domain {
  def bandWidthOrBitRate: Option[Double] =
    bitrate orElse bandwidth orElse qos_quality

  def isValid: Boolean =
    (bandWidthOrBitRate orElse
      qos_startup_time orElse
      qos_buffering_spinner_duration orElse
      qos_buffering_spinner_events orElse
      qos_buffering_at_end
      ).isDefined
}

case class Video(
  noun_id: Option[String],
  video_id: Option[String],
  url: Option[String],
  is_ad_bool: Boolean,
  name: Option[String]
) extends Domain {
  def is_ad: Boolean = is_ad_bool

  def is_play: Boolean = ("play" == (
    (name map (_.toLowerCase)).getOrElse(""))
    )

  def isrc = video_id.getOrElse(noun_id)
}

case class Geo(
  ip_address: String,
  region: Option[String],
  city: Option[String],
  country: String,
  lat: Option[Double],
  lng: Option[Double]
) extends Domain {
  lazy val _lat = lat.getOrElse(0.000)
  lazy val _lng = lat.getOrElse(0.000)
}

case class Device(
  platform: String,
  app_version: String,
  device: String,
  user_id: Option[String],
  anon_id: String
) extends Domain {
  def is_anon: Boolean = (user_id == null || user_id.isEmpty)

  val effectiveUserid: String = {
    if (is_anon)
      anon_id
    else user_id.get
  }
}

case class BuildNumber(
  buildAsLong: Option[Long],
  buildAsString: Option[String]
)

case class UserAgent(
  http_user_agent: String
) extends Domain

case class QosStream(
  qos: Qos,
  video: Video,
  geo: Geo,
  device: Device,
  userAgent: UserAgent,
  buildNumber: BuildNumber,
  timestamp: Long = System.currentTimeMillis
) extends Domain {
  lazy val build_number: Option[String] =
    buildNumber.buildAsLong map (_.toString) orElse buildNumber.buildAsString
}

case class ProcessingResults(qosSize: Int, dbInserts: Int)

case class KplRecord(
  data: ByteBuffer,
  partitionKey: String = System.currentTimeMillis.toString,
  streamName: String = cfgVevo.getString("kinesis.streams.qos_telemetry.name")
)

case class ProgramResutl(db: Int, kcl: Int)
