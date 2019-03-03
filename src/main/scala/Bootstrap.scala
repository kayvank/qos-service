import api.StatusApi
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.Worker
import com.typesafe.scalalogging.LazyLogging
import kamon.Kamon
import kcl.{Kcl, KclEndoStreamFactory}
import kcl.KclCheckpoint._
import svc.TransformerSvc._
import org.http4s.server.{Server, ServerApp}
import org.http4s.server.blaze.BlazeBuilder
import utils.Global.cfgVevo
import repository.Ds._
import scalaz._
import Scalaz._
import scalaz.concurrent.Task


object Bootstrap extends ServerApp with LazyLogging {

  import utils.ApplicativeTask._

  println(s"connecting to jdbcUrl = $jdbcUrl as jdbcUser=${jdbcUser}.  dbUp= ${connectionStatus}")

  case class ProgramStatus(s: Server, u: Unit)

  Kamon.start()

  val awsKclworker = new Worker.Builder()
    .recordProcessorFactory(new KclEndoStreamFactory(eventSink, doCheckPointTask))
    .config(Kcl.endoKclClient).build

  lazy val runWorkerTask = awsKclworker.run()

  def server(args: List[String]): Task[Server] = {

    import utils.CustomExecutor._

    val serverTask = BlazeBuilder.bindHttp(
      port = cfgVevo.getInt("http.port"),
      host = "0.0.0.0")
      .mountService(StatusApi.service, "/status").start

    T.apply2(
      Task.fork(serverTask)(ec),
      Task.fork(Task.delay(runWorkerTask))(customExecutor))(ProgramStatus(_, _)
    ) map (_.s)
  }
}
