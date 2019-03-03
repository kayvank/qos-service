package kcl

import com.amazonaws.services.kinesis.clientlibrary.exceptions._
import com.amazonaws.services.kinesis.clientlibrary.interfaces.IRecordProcessorCheckpointer
import com.amazonaws.services.kinesis.clientlibrary.interfaces.v2.IRecordProcessor
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.ShutdownReason
import com.amazonaws.services.kinesis.clientlibrary.types._
import com.typesafe.scalalogging.LazyLogging
import io.circe.DecodingFailure
import kcl.KclCheckpoint.doCheckPointTask
import model.ModelExceptions.NoQosElementFoundException
import utils._
import model._
import svc.TransformerSvc.eventSink
import scalaz.concurrent.Task

class KclProcessor(
  eventSink: ProcessRecordsInput => Task[ProgramResutl] = eventSink,
  checkpoint: IRecordProcessorCheckpointer => Task[Long] = doCheckPointTask
) extends IRecordProcessor
  with LazyLogging {

  import Kcl._

  override def shutdown(shutdownInput: ShutdownInput) = {
    logger.info(s"Ending kcl stream processing!")
    shutdownInput.getShutdownReason match {
      case ShutdownReason.TERMINATE =>
        checkpoint(shutdownInput.getCheckpointer) // dont wait, do checkpoint now
        logger.warn(s"Received Shard:  ${ShutdownReason.TERMINATE} for stream= $endoStreamName}")
      case ShutdownReason.ZOMBIE =>
        logger.warn(s"Received Shard: ${ShutdownReason.ZOMBIE} for stream= $endoStreamName}   ")
      case ShutdownReason.REQUESTED =>
        logger.warn(s"received request for shutdown! for stream= $endoStreamName")
    }
  }

  override def initialize(initializationInput: InitializationInput): Unit = {
    logger.debug(s"kcl stream processing begins")
  }

  override def processRecords(processRecordsInput: ProcessRecordsInput): Unit = {

    import CustomExecutor._

    val recordsProcessedTask: Task[ProgramResutl] =
      Task.fork(eventSink(processRecordsInput))(customExecutor).handleWith {
        case e: KinesisClientLibRetryableException =>
          logger.warn(s"KinesisClientLibRetryableException.  ${e.getMessage}")
          Monitor.kclRetriableExceptionCntr.increment()
          Task.now(ProgramResutl(0, 0))
        case e: KinesisClientLibNonRetryableException =>
          logger.error(s"KinesisClientLibNonRetryableException.  ${e.getMessage}")
          Task.now(ProgramResutl(0, 0))
        case e: Throwable =>
          logger.error(s" ${e}")
          checkpoint(processRecordsInput.getCheckpointer)
          Monitor.unKnownExceptionCntr.increment()
          Task.now(ProgramResutl(0, 0))
      }
    val p = recordsProcessedTask.unsafePerformSync
    logger.info(s"program results(db,kcl)= ${p}")
  }
}
