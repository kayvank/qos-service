package model

import java.nio.ByteBuffer
import java.nio.charset.StandardCharsets

import com.amazonaws.services.kinesis.model.{PutRecordsRequest, PutRecordsRequestEntry, Record}
import io.circe._
import io.circe.generic.semiauto._
import io.circe.parser.parse
import io.circe.syntax._
import utils.EitherToDisjunction.fromEither2zDisjunction

import collection.JavaConverters._
import scalaz._
import Scalaz._
import scala.util.{Failure, Success, Try}
import DomainProtocols._
import com.typesafe.scalalogging.LazyLogging
import model.ModelExceptions.{KclRecordToStringException, NoQosElementFoundException}
import utils.Monitor

object QosJsonProtocol extends LazyLogging {

  implicit val qosDecoder: Decoder[Qos] = deriveDecoder
  implicit val qosEncoder: Encoder[Qos] = deriveEncoder

  implicit val videoDecoder: Decoder[Video] = deriveDecoder
  implicit val videoEncoder: Encoder[Video] = deriveEncoder

  implicit val geoDecoder: Decoder[Geo] = deriveDecoder
  implicit val geoEncoder: Encoder[Geo] = deriveEncoder

  implicit val deviceDecoder: Decoder[Device] = deriveDecoder
  implicit val deviceEncoder: Encoder[Device] = deriveEncoder

  implicit val buildNumberDecoder: Decoder[BuildNumber] = deriveDecoder
  implicit val buildNumberEncoder: Encoder[BuildNumber] = deriveEncoder

  implicit val userAgentDecoder: Decoder[UserAgent] = deriveDecoder
  implicit val userAgentEncoder: Encoder[UserAgent] = deriveEncoder

  implicit val qsStreamDecoder: Decoder[QosStream] = deriveDecoder
  implicit val qsStreamEncoder: Encoder[QosStream] = deriveEncoder

  implicit class Qos2ByteBuf(qosStream: QosStream) {
    def asKplRecord = {
      KplRecord(data = ByteBuffer.wrap(
        qosStream.asJson.noSpaces.getBytes))
    }
  }

  implicit class BatchInsert(kplRecords: List[KplRecord]) {
    def asBatch: PutRecordsRequest = {
      val putrecsList = kplRecords.foldLeft(List[PutRecordsRequestEntry]())((z, r) =>
        (new PutRecordsRequestEntry).withData(r.data).withPartitionKey(r.partitionKey) :: z)
      (new PutRecordsRequest()).withStreamName(kplRecords.head.streamName).withRecords(putrecsList.asJava)
    }
  }


  implicit class KclStringProtocol(event: Record) {
    def asString: \/[Throwable, String] =
      Try(new java.lang.String(
        (event.getData.array()), "utf-8")) match {
        case Success(s) => s.right
        case Failure(e) => KclRecordToStringException(e.getMessage).left
      }
  }

  implicit class KclRecrod2Qos(rec: Record) {
    def asQosStreamOpt: Option[QosStream] = {
      val q =
        for {
          endoString <- rec.asString
          endoJson <- parse(endoString)
          endoQosStream <- endoJson.asQosStream
        } yield (endoQosStream)
      q match {
        case -\/(e) =>
          exLogger(e)
          None
        case \/-(r) => Some(r)
      }
    }
  }

  val exLogger: Throwable => Throwable = e => {
    e match {
      case NoQosElementFoundException(_) =>
        logger.debug(s"${e}")
        Monitor.noQosCntr.increment()
      case KclRecordToStringException(_) =>
        logger.error(s"Exception occurred. ${e}")
        Monitor.kclToStringExceptionCntr.increment()
      case DecodingFailure(_, _) =>
        logger.debug(s"${e}")
        Monitor.jsonDecoingExceptionCntr.increment()
      case ParsingFailure(_, _) =>
        logger.info(s"json ParsingFailure occurred. ${e}")
        Monitor.kclStringToJsonExcpetionCntr.increment()
      case _ =>
        logger.info(s"UnExpected Exception occurred. ${e}")
        Monitor.jsonDecoingExceptionCntr.increment()
    }
    e
  }
}
