package repository

import com.amazonaws.services.kinesis.AmazonKinesis
import com.typesafe.scalalogging.LazyLogging
import model._
import model.QosJsonProtocol._
import scalaz.concurrent.Task

object KinesisPublisher extends LazyLogging {

  private final val batchSize=495

  def publishBulk(qosVector: List[QosStream]): AmazonKinesis => Task[Int] = client => {
    val telemetry = qosVector.filter(_.qos.qos_telemetry.isDefined)
    if (telemetry.isEmpty)
      Task(0)
    else
      for {
        r1 <- Task(telemetry.map(q => q.asKplRecord))
        r2 <- Task.gatherUnordered(
          r1.grouped(batchSize).toList.map(x =>
            Task(client.putRecords(x.asBatch))))
        r3 <- Task(r2.map(r => r.getFailedRecordCount).foldLeft(0)(_ + _))
      } yield (qosVector.size - r3)
  }
}
