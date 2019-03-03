package repository

import com.typesafe.scalalogging.LazyLogging
import doobie.hikari.hikaritransactor._
import model.QosStream
import doobie.imports._
import utils.Global.cfgVevo
import scalaz._
import Scalaz._
import scalaz.concurrent.Task

object QosStreamRepository extends LazyLogging {

  private final val batchSize=cfgVevo.getInt("db.jdbc.batch.size")

  final case class QosStreamDS(
    bitrate: Option[Double],
    qos_startup_time: Option[Double],
    qos_buffering_spinner_duration: Option[Double],
    qos_buffering_spinner_events: Option[Int],
    qos_buffering_at_end: Option[Boolean],
    video_id: Option[String],
    video_url: Option[String],
    is_ad: Boolean,
    is_play: Boolean,
    region: Option[String],
    city: Option[String],
    country: String,
    lat: Double,
    lng: Double,
    platform: String,
    app_version: String,
    build_number: Option[String],
    device: String,
    user_id: String,
    is_anon: Boolean,
    ip: String,
    http_user_agent: String
  )

  final private val sql =
    s"""
         insert into qos_stream (
         bitrate,
         qos_startup_time,
         qos_buffering_spinner_duration,
         qos_buffering_spinner_events,
         qos_buffering_at_end,
         video_id,
         video_url,
         is_ad,
         is_play,
         region,
         city,
         country,
         lat_lon,
         platform,
         app_version,
         build_number,
         device,
         user_id,
         is_anon,
         ip,
         user_agent
         )
         values
         (
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         Point(?, ?),
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?,
         ?
         )
         """

  implicit class QosStreamDSConverter(q: QosStream) {
    def asDS: QosStreamDS = {
      QosStreamDS(
        bitrate = q.qos.bandWidthOrBitRate,
        qos_startup_time = q.qos.qos_startup_time,
        qos_buffering_spinner_duration = q.qos.qos_buffering_spinner_duration,
        qos_buffering_spinner_events = q.qos.qos_buffering_spinner_events,
        qos_buffering_at_end = q.qos.qos_buffering_at_end,
        video_id = q.video.video_id,
        video_url = q.video.url,
        is_ad = q.video.is_ad,
        is_play = q.video.is_play,
        region = q.geo.region,
        city = q.geo.city,
        country = q.geo.country,
        lat = q.geo._lat,
        lng = q.geo._lng,
        platform = q.device.platform,
        app_version = q.device.app_version,
        build_number = q.build_number,
        device = q.device.device,
        user_id = q.device.effectiveUserid,
        is_anon = q.device.is_anon,
        ip = q.geo.ip_address,
        http_user_agent = q.userAgent.http_user_agent
      )
    }
  }

  def insertBatch(qs: List[QosStream]): HikariTransactor[Task] => Task[Int] = tx => {
    for {
      q2 <- Task.gatherUnordered(insertBatch2(qs).map(_.transact(tx)))
      q3 <- Task(q2.foldLeft(0)((z, a) => z + a))
    } yield (q3)
  }

  def insertBatch2(qosList: List[QosStream]): List[ConnectionIO[Int]] =
    qosList.map(_.asDS).grouped(batchSize).toList.map(Update[QosStreamDS](sql).updateMany(_))
}
