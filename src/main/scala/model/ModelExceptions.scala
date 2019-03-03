package model


object ModelExceptions  {
sealed trait ModelExceptions

  case class KclRecordToStringException(
    e: String
  ) extends Throwable(e) with ModelExceptions

  case class NoQosElementFoundException(
    e: String = "No QOS Elements found in endo-event"
  ) extends Throwable(e) with ModelExceptions

  case class NoQosTemetryFoundException(
    e: String = "No QOS-TELEMETRY found in endo-event"
  ) extends Throwable(e) with ModelExceptions

}
