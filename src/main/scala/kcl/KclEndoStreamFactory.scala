package kcl

import com.amazonaws.services.kinesis.clientlibrary.interfaces.IRecordProcessorCheckpointer
import com.amazonaws.services.kinesis.clientlibrary.interfaces.v2.{IRecordProcessor, IRecordProcessorFactory}
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.ShutdownReason
import com.amazonaws.services.kinesis.clientlibrary.types.{InitializationInput, ProcessRecordsInput, ShutdownInput}
import com.typesafe.scalalogging.LazyLogging
import kcl.Kcl.endoStreamName
import kcl.KclCheckpoint.doCheckPointTask

import scalaz.concurrent.Task
import model._



class KclEndoStreamFactory(
  eventSink: ProcessRecordsInput => Task[ProgramResutl],
  checkpoint: IRecordProcessorCheckpointer => Task[Long])
  extends IRecordProcessorFactory {

  @Override
  def createProcessor: IRecordProcessor = {
    new KclProcessor(eventSink, checkpoint)
  }
}




