package kcl

import java.net.InetAddress
import java.util.UUID
import com.amazonaws.auth.{AWSCredentials, AWSCredentialsProvider, BasicAWSCredentials}
import com.amazonaws.services.kinesis.AmazonKinesisClientBuilder
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.{InitialPositionInStream, KinesisClientLibConfiguration}
import utils.Global._

sealed trait BasicAWSCredentialsProvider {

  final class BasicAWSCredentialsProvider(basic: BasicAWSCredentials) extends
    AWSCredentialsProvider {
    @Override def getCredentials: AWSCredentials = basic

    @Override def refresh = {}
  }
}

object Kcl extends BasicAWSCredentialsProvider {
  val random = new java.util.Random
  val (size, min, max) = (
    2,
    cfgVevo.getInt("kinesis.streams.endo.time.millis.idleTimeBetweenReads.min"),
    cfgVevo.getInt("kinesis.streams.endo.time.millis.idleTimeBetweenReads.max"))
  val endoStreamName =
    cfgVevo.getString("kinesis.streams.endo.name")
  val idelTimeBetweenReads = random.ints(size, min, max).toArray.head

  val endoKclworkerId =
    s"${InetAddress.getLocalHost.getCanonicalHostName}:${cfgVevo.getString("kinesis.streams.endo.name")}:${UUID.randomUUID.toString}"

  val endoKclClient: KinesisClientLibConfiguration = new KinesisClientLibConfiguration(
    s"${cfgVevo.getString("kinesis.app.name")}-${endoStreamName}",
    endoStreamName,
    new BasicAWSCredentialsProvider(
      new BasicAWSCredentials(
        cfgVevo.getString("aws.access-key"),
        cfgVevo.getString("aws.secret-key"))),
    endoKclworkerId).withInitialPositionInStream(InitialPositionInStream.LATEST)
    .withIdleTimeBetweenReadsInMillis(idelTimeBetweenReads)
    .withInitialLeaseTableWriteCapacity(200)
    .withInitialLeaseTableReadCapacity(200)

  println(s"idletimeBetweenReads = ${idelTimeBetweenReads} ")
  val client = AmazonKinesisClientBuilder.standard()
    .withCredentials(new BasicAWSCredentialsProvider(
      new BasicAWSCredentials(
        cfgVevo.getString("aws.access-key"),
        cfgVevo.getString("aws.secret-key"))))
    .withRegion(cfgVevo.getString("kinesis.streams.qos_telemetry.region"))
    .build()
}
