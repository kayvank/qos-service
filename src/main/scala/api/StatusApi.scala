package api

import io.circe.Json
import io.circe.syntax._
import org.http4s._
import org.http4s.dsl._
import scalaz._
import Scalaz._
import scalaz.concurrent.Task
import io.circe.parser._
import scala.util.Try
import utils._
import repository._

import scala.concurrent.ExecutionContext

object StatusApi extends BaseApi {

  val na = "na"
  val gocdPipelineCounter = Try(System.getProperty("build_number")).toOption.getOrElse(na)
  val bs = Map("gocdPipelineCounter" -> (
    (gocdPipelineCounter == null) ? na | gocdPipelineCounter)).asJson
  lazy val binfo =
    parse(info.BuildInfo.toJson).right.getOrElse(Json.Null).deepMerge(bs)
  val bInfoT = Task(binfo)

  def apply(): HttpService = service

  val service= HttpService {
    case req@GET -> Root =>
      Ok()

    case request@GET -> Root / "db" =>
      Ok( for {
        p <- bInfoT
        r <- Task(p.deepMerge(Map("pipelinedb-database-isUp" -> Ds.connectionStatus).asJson).deepMerge(p))
      } yield (r)
      )
  }.mapK(Task.fork(_)(CustomExecutor.ec))

}
