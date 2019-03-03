package svc

import com.amazonaws.services.kinesis.clientlibrary.types.ProcessRecordsInput
import com.typesafe.scalalogging.LazyLogging
import kcl.Kcl
import model.QosStream
import repository.{Ds, KinesisPublisher, QosStreamRepository}
import scalaz._
import Scalaz._
import scalaz.concurrent.Task
import model.QosJsonProtocol._
import model._
import utils._

import scala.collection.JavaConversions._

object TransformerSvc extends LazyLogging {

  val eventSink: ProcessRecordsInput => Task[ProgramResutl] = event => {
    import ApplicativeTask._

    lazy val qosStreamList: List[QosStream] =
      event.getRecords.toList.map(q => q.asQosStreamOpt).filter(_.isDefined).map(_.get)
    val dbTask = QosStreamRepository.insertBatch(qosStreamList)(Ds.hxa)
    val kclTask = KinesisPublisher.publishBulk(qosStreamList)(Kcl.client)

    for {
      p <- T.apply2(dbTask, kclTask)(ProgramResutl(_, _))
      _ <- Task( updateMonitor(p) )
    } yield (p)
  }

  private final val  updateMonitor: ProgramResutl => Unit= p => {
    Monitor.dbCntr.increment(p.db.toLong)
    Monitor.kclCntr.increment(p.kcl.toLong)
  }
}
