
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: qos_queries; Type: TABLE; Schema: public; Owner: ubuntu
--

CREATE TABLE qos_queries (
    query text,
    metric_key text,
    create_dt timestamp without time zone DEFAULT now()
);


ALTER TABLE qos_queries OWNER TO qos;

--
-- Data for Name: qos_queries; Type: TABLE DATA; Schema: public; Owner: ubuntu
--

COPY qos_queries (query, metric_key, create_dt) FROM stdin;
select platform, qos_100 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.100th	2017-02-15 16:22:34.867508
select platform, qos_99 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.99th	2017-02-15 16:22:56.950979
select platform, qos_95 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.95th	2017-02-15 16:22:56.954136
select platform, qos_90 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.90th	2017-02-15 16:22:56.957959
select platform, qos_50 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.50th	2017-02-15 16:22:56.961766
select platform, qos_10 as metric from qos_spinner_duration_60m_c_v;	qos.spinner_duration.60m.10th	2017-02-15 16:22:56.964674
select platform, qos_100 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.100th	2017-02-15 16:22:56.967668
select platform, qos_99 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.99th	2017-02-15 16:22:56.971501
select platform, qos_95 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.95th	2017-02-15 16:22:57.048594
select platform, qos_90 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.90th	2017-02-15 16:22:57.052655
select platform, qos_50 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.50th	2017-02-15 16:22:57.056507
select platform, qos_10 as metric from qos_spinner_duration_10m_c_v;	qos.spinner_duration.10m.10th	2017-02-15 16:22:57.060331
select platform, qos_100 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.100th	2017-02-15 16:22:57.064047
select platform, qos_99 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.99th	2017-02-15 16:22:57.067715
select platform, qos_95 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.95th	2017-02-15 16:22:57.071497
select platform, qos_90 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.90th	2017-02-15 16:22:57.141678
select platform, qos_50 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.50th	2017-02-15 16:22:57.145537
select platform, qos_10 as metric from qos_spinner_events_60m_c_v;	qos.spinner_events.60m.10th	2017-02-15 16:22:57.149261
select platform, qos_100 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.100th	2017-02-15 16:22:57.153057
select platform, qos_99 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.99th	2017-02-15 16:22:57.156833
select platform, qos_95 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.95th	2017-02-15 16:22:57.160614
select platform, qos_90 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.90th	2017-02-15 16:22:57.164378
select platform, qos_50 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.50th	2017-02-15 16:22:57.241364
select platform, qos_10 as metric from qos_spinner_events_10m_c_v;	qos.spinner_events.10m.10th	2017-02-15 16:22:57.245455
select platform, qos_100 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.100th	2017-02-15 16:22:57.24891
select platform, qos_99 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.99th	2017-02-15 16:22:57.252299
select platform, qos_95 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.95th	2017-02-15 16:22:57.255725
select platform, qos_90 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.90th	2017-02-15 16:22:57.259145
select platform, qos_50 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.50th	2017-02-15 16:22:57.262624
select platform, qos_10 as metric from qos_quality_view_60m_c_v;	qos.bitrate.60m.10th	2017-02-15 16:22:57.266066
select platform, qos_100 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.100th	2017-02-15 16:22:57.342154
select platform, qos_99 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.99th	2017-02-15 16:22:57.345751
select platform, qos_95 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.95th	2017-02-15 16:22:57.349132
select platform, qos_90 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.90th	2017-02-15 16:22:57.352517
select platform, qos_50 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.50th	2017-02-15 16:22:57.355957
select platform, qos_10 as metric from qos_quality_view_10m_c_v;	qos.bitrate.10m.10th	2017-02-15 16:22:57.359363
select platform, qos_100 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.100th	2017-02-15 16:22:57.362979
select platform, qos_99 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.99th	2017-02-15 16:22:57.440346
select platform, qos_95 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.95th	2017-02-15 16:22:57.44421
select platform, qos_90 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.90th	2017-02-15 16:22:57.447871
select platform, qos_50 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.50th	2017-02-15 16:22:57.451442
select platform, qos_10 as metric from qos_startup_time_60m_c_v;	qos.startup_time.60m.10th	2017-02-15 16:22:57.455077
select platform, qos_100 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.100th	2017-02-15 16:22:57.458744
select platform, qos_99 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.99th	2017-02-15 16:22:57.462295
select platform, qos_95 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.95th	2017-02-15 16:22:57.465949
select platform, qos_90 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.90th	2017-02-15 16:22:57.544116
select platform, qos_50 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.50th	2017-02-15 16:22:57.548001
select platform, qos_10 as metric from qos_startup_time_10m_c_v;	qos.startup_time.10m.10th	2017-02-15 16:22:57.55351
select platform, count as metric from qos_ad_plays_60m;	qos.ad_plays.60m	2017-02-22 17:04:11.779011
select 'global' as platform, qos_100 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.100th	2017-02-22 21:46:12.333127
select 'global' as platform, qos_99 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.99th	2017-02-22 21:48:26.791463
select 'global' as platform, qos_95 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.95th	2017-02-22 21:48:26.79495
select 'global' as platform, qos_90 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.90th	2017-02-22 21:48:26.798064
select 'global' as platform, qos_50 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.50th	2017-02-22 21:48:26.80114
select 'global' as platform, qos_10 as metric from qos_startup_time_60m_c_gl;	qos.startup_time.60m.10th	2017-02-22 21:48:26.805198
select 'global' as platform, qos_100 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.100th	2017-02-22 21:48:26.809175
select 'global' as platform, qos_99 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.99th	2017-02-22 21:48:26.889837
select 'global' as platform, qos_95 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.95th	2017-02-22 21:48:26.893488
select 'global' as platform, qos_90 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.90th	2017-02-22 21:48:26.896744
select 'global' as platform, qos_50 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.50th	2017-02-22 21:48:26.901048
select 'global' as platform, qos_10 as metric from qos_startup_time_10m_c_gl;	qos.startup_time.10m.10th	2017-02-22 21:48:26.905499
select 'global' as platform, qos_100 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.100th	2017-02-22 21:48:26.909326
select 'global' as platform, qos_99 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.99th	2017-02-22 21:48:26.913229
select 'global' as platform, qos_95 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.95th	2017-02-22 21:48:26.990074
select 'global' as platform, qos_90 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.90th	2017-02-22 21:48:26.992959
select 'global' as platform, qos_50 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.50th	2017-02-22 21:48:26.995793
select 'global' as platform, qos_10 as metric from qos_bitrate_60m_c_gl;	qos.bitrate.60m.10th	2017-02-22 21:48:26.999515
select 'global' as platform, qos_100 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.100th	2017-02-22 21:48:27.003289
select 'global' as platform, qos_99 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.99th	2017-02-22 21:48:27.006995
select 'global' as platform, qos_95 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.95th	2017-02-22 21:48:27.00997
select 'global' as platform, qos_90 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.90th	2017-02-22 21:48:27.089626
select 'global' as platform, qos_50 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.50th	2017-02-22 21:48:27.092535
select 'global' as platform, qos_10 as metric from qos_bitrate_10m_c_gl;	qos.bitrate.10m.10th	2017-02-22 21:48:27.095349
select 'global' as platform, qos_100 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.100th	2017-02-22 21:48:27.099806
select 'global' as platform, qos_99 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.99th	2017-02-22 21:48:27.10418
select 'global' as platform, qos_95 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.95th	2017-02-22 21:48:27.108579
select 'global' as platform, qos_90 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.90th	2017-02-22 21:48:27.112945
select 'global' as platform, qos_50 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.50th	2017-02-22 21:48:27.192104
select 'global' as platform, qos_10 as metric from qos_buffering_spinner_duration_60m_c_gl;	qos.spinner_duration.60m.10th	2017-02-22 21:48:27.195676
select 'global' as platform, qos_100 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.100th	2017-02-22 21:48:27.200193
select 'global' as platform, qos_99 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.99th	2017-02-22 21:48:27.204636
select 'global' as platform, qos_95 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.95th	2017-02-22 21:48:27.209066
select 'global' as platform, qos_90 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.90th	2017-02-22 21:48:27.214846
select 'global' as platform, qos_50 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.50th	2017-02-22 21:48:27.293516
select 'global' as platform, qos_10 as metric from qos_buffering_spinner_duration_10m_c_gl;	qos.spinner_duration.10m.10th	2017-02-22 21:48:27.297076
select 'global' as platform, qos_100 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.100th	2017-02-22 21:48:27.303324
select 'global' as platform, qos_99 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.99th	2017-02-22 21:48:27.307626
select 'global' as platform, qos_95 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.95th	2017-02-22 21:48:27.312983
select 'global' as platform, qos_90 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.90th	2017-02-22 21:48:27.317895
select 'global' as platform, qos_50 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.50th	2017-02-22 21:48:27.407872
select 'global' as platform, qos_10 as metric from qos_buffering_spinner_events_60m_c_gl;	qos.spinner_events.60m.10th	2017-02-22 21:48:27.411194
select 'global' as platform, qos_100 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.100th	2017-02-22 21:48:27.41562
select 'global' as platform, qos_99 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.99th	2017-02-22 21:48:27.42083
select 'global' as platform, qos_95 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.95th	2017-02-22 21:48:27.426538
select 'global' as platform, qos_90 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.90th	2017-02-22 21:48:27.431672
select 'global' as platform, qos_50 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.50th	2017-02-22 21:48:27.494453
select 'global' as platform, qos_10 as metric from qos_buffering_spinner_events_10m_c_gl;	qos.spinner_events.10m.10th	2017-02-22 21:48:27.498104
select 'global' as platform, count as metric from qos_ad_plays_60m_gl	qos.ad_plays.60m	2017-02-22 21:48:27.502123
select 'global' as platform, c as metric from qos_startup_time_60m_c_gl;	qos.samples.60m	2017-02-22 21:57:48.908635
select 'global' as platform, c as metric from qos_startup_time_10m_c_gl;	qos.samples.10m	2017-02-22 21:57:48.911718
select 'global' as platform, count as metric from qos_unique_users_60m_gl;	qos.unique_registered.60m	2017-02-22 22:17:45.496567
select 'global' as platform, count as metric from qos_unique_anon_60m_gl;	qos.unique_anonymous.60m	2017-02-22 22:17:45.500054
select 'global' as platform, count as metric from qos_unique_countries_60m_gl;	qos.unique_countries.60m	2017-02-22 22:17:45.504216
select platform, count as metric from qos_unique_users_60m_pl;	qos.unique_registered.60m	2017-02-22 22:34:03.282455
select platform, count as metric from qos_unique_anon_60m_pl;	qos.unique_anonymous.60m	2017-02-22 22:34:03.28549
select platform, count as metric from qos_unique_countries_60m_pl;	qos.unique_countries.60m	2017-02-22 22:34:03.288191
select platform, c as metric from qos_startup_time_60m_c_v;	qos.samples.60m	2017-02-22 22:35:25.283684
select platform, c as metric from qos_startup_time_10m_c_v;	qos.samples.10m	2017-02-22 22:35:25.28618
select platform, count as metric from qos_ad_plays_10m;	qos.ad_plays.10m	2017-02-22 22:38:11.165801
select 'global' as platform, count as metric from qos_ad_plays_10m_gl	qos.ad_plays.10m	2017-02-22 22:38:11.168607
\.


--
-- Name: qos_queries; Type: ACL; Schema: public; Owner: ubuntu
--

REVOKE ALL ON TABLE qos_queries FROM PUBLIC;
GRANT ALL ON TABLE qos_queries TO qos;


--
-- PostgreSQL database dump complete
--
