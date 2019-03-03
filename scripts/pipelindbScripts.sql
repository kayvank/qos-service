
create stream qos_stream (
 bitrate float,
 qos_startup_time float,
 qos_buffering_spinner_duration float,
 qos_buffering_spinner_events int,
 qos_buffering_at_end bool,
 video_id text,
 video_url text,
 is_ad bool,
 is_play bool,
 region text,
 city text,
 country text,
 lat_lon point,
 platform text,
 app_version text,
 build_number text,
 device text,
 user_id text,
 is_anon bool,
 ip text,
 user_agent text
);

create continuous view qos_unique_users_60m_pl WITH (sw = '60 minute') as
 select
  platform,
  count(distinct user_id)
 from qos_stream
  where is_anon = false
  group by platform;

create continuous view qos_unique_users_60m_gl WITH (sw = '60 minute') as
 select
  count(distinct user_id)
 from qos_stream
  where is_anon = false;

create continuous view qos_unique_anon_60m_pl WITH (sw = '60 minute') as
 select
  platform,
  count(distinct ip)
 from qos_stream
  where is_anon = true
  group by platform;

create continuous view qos_unique_anon_60m_gl WITH (sw = '60 minute') as
 select
  count(distinct ip)
 from qos_stream
  where is_anon = true;

create continuous view qos_plays_60m_gl WITH (sw = '60 minute') as
 select
  count(*)
 from qos_stream
  where is_play = true;

create continuous view qos_unique_countries_60m_pl WITH (sw = '60 minute') as
 select
  platform,
  count(distinct country)
 from qos_stream
  group by platform;

create continuous view qos_unique_countries_60m_gl WITH (sw = '60 minute') as
 select
  count(distinct country)
 from qos_stream
  where is_anon = true;

create continuous view qos_buffering_at_end_60m_gl WITH (sw = '60 minute') as
 select
  count(*)
 from qos_stream
  where qos_buffering_at_end = true;

create continuous view qos_startup_time_60m_c_gl WITH (sw = '60 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_startup_time) as qos_100,
  percentile_cont(0.99) within group (order by qos_startup_time) as qos_99,
  percentile_cont(0.95) within group (order by qos_startup_time) as qos_95,
  percentile_cont(0.90) within group (order by qos_startup_time) as qos_90,
  percentile_cont(0.50) within group (order by qos_startup_time) as qos_50,
  percentile_cont(0.10) within group (order by qos_startup_time) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_startup_time_10m_c_gl WITH (sw = '10 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_startup_time) as qos_100,
  percentile_cont(0.99) within group (order by qos_startup_time) as qos_99,
  percentile_cont(0.95) within group (order by qos_startup_time) as qos_95,
  percentile_cont(0.90) within group (order by qos_startup_time) as qos_90,
  percentile_cont(0.50) within group (order by qos_startup_time) as qos_50,
  percentile_cont(0.10) within group (order by qos_startup_time) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_startup_time_60m_c_v WITH (sw = '60 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_startup_time) as qos_100,
  percentile_cont(0.99) within group (order by qos_startup_time) as qos_99,
  percentile_cont(0.95) within group (order by qos_startup_time) as qos_95,
  percentile_cont(0.90) within group (order by qos_startup_time) as qos_90,
  percentile_cont(0.50) within group (order by qos_startup_time) as qos_50,
  percentile_cont(0.10) within group (order by qos_startup_time) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;

create continuous view qos_startup_time_10m_c_v WITH (sw = '10 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_startup_time) as qos_100,
  percentile_cont(0.99) within group (order by qos_startup_time) as qos_99,
  percentile_cont(0.95) within group (order by qos_startup_time) as qos_95,
  percentile_cont(0.90) within group (order by qos_startup_time) as qos_90,
  percentile_cont(0.50) within group (order by qos_startup_time) as qos_50,
  percentile_cont(0.10) within group (order by qos_startup_time) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;

create continuous view qos_bitrate_60m_c_gl WITH (sw = '60 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by bitrate) as qos_100,
  percentile_cont(0.99) within group (order by bitrate) as qos_99,
  percentile_cont(0.95) within group (order by bitrate) as qos_95,
  percentile_cont(0.90) within group (order by bitrate) as qos_90,
  percentile_cont(0.50) within group (order by bitrate) as qos_50,
  percentile_cont(0.10) within group (order by bitrate) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_bitrate_10m_c_gl WITH (sw = '10 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by bitrate) as qos_100,
  percentile_cont(0.99) within group (order by bitrate) as qos_99,
  percentile_cont(0.95) within group (order by bitrate) as qos_95,
  percentile_cont(0.90) within group (order by bitrate) as qos_90,
  percentile_cont(0.50) within group (order by bitrate) as qos_50,
  percentile_cont(0.10) within group (order by bitrate) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_quality_view_60m_c_v WITH (sw = '60 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by bitrate) as qos_100,
  percentile_cont(0.99) within group (order by bitrate) as qos_99,
  percentile_cont(0.95) within group (order by bitrate) as qos_95,
  percentile_cont(0.90) within group (order by bitrate) as qos_90,
  percentile_cont(0.50) within group (order by bitrate) as qos_50,
  percentile_cont(0.10) within group (order by bitrate) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;

create continuous view qos_quality_view_10m_c_v WITH (sw = '10 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by bitrate) as qos_100,
  percentile_cont(0.99) within group (order by bitrate) as qos_99,
  percentile_cont(0.95) within group (order by bitrate) as qos_95,
  percentile_cont(0.90) within group (order by bitrate) as qos_90,
  percentile_cont(0.50) within group (order by bitrate) as qos_50,
  percentile_cont(0.10) within group (order by bitrate) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;


create continuous view qos_buffering_spinner_duration_60m_c_gl WITH (sw = '60 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_duration) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_duration) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_duration) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_duration) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_duration) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_duration) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_buffering_spinner_duration_10m_c_gl WITH (sw = '10 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_duration) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_duration) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_duration) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_duration) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_duration) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_duration) as qos_10
 from qos_stream
  where is_ad = false;


create continuous view qos_spinner_duration_60m_c_v WITH (sw = '60 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_duration) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_duration) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_duration) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_duration) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_duration) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_duration) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;

create continuous view qos_spinner_duration_10m_c_v WITH (sw = '10 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_duration) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_duration) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_duration) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_duration) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_duration) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_duration) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;


create continuous view qos_buffering_spinner_events_60m_c_gl WITH (sw = '60 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_events) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_events) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_events) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_events) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_events) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_events) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_buffering_spinner_events_10m_c_gl WITH (sw = '10 minute') as
 select
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_events) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_events) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_events) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_events) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_events) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_events) as qos_10
 from qos_stream
  where is_ad = false;

create continuous view qos_spinner_events_60m_c_v WITH (sw = '60 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_events) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_events) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_events) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_events) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_events) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_events) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;

create continuous view qos_spinner_events_10m_c_v WITH (sw = '10 minute') as
 select
  platform,
  count(*) as c,
  percentile_cont(1.0) within group (order by qos_buffering_spinner_events) as qos_100,
  percentile_cont(0.99) within group (order by qos_buffering_spinner_events) as qos_99,
  percentile_cont(0.95) within group (order by qos_buffering_spinner_events) as qos_95,
  percentile_cont(0.90) within group (order by qos_buffering_spinner_events) as qos_90,
  percentile_cont(0.50) within group (order by qos_buffering_spinner_events) as qos_50,
  percentile_cont(0.10) within group (order by qos_buffering_spinner_events) as qos_10
 from qos_stream
  where is_ad = false
  group by platform;



create continuous view qos_ad_plays_60m WITH (sw = '60 minute') as
 select
  platform,
  count(*)
 from qos_stream
  where is_ad = true
  group by platform;

create continuous view qos_ad_plays_10m WITH (sw = '10 minute') as
 select
  platform,
  count(*)
 from qos_stream
  where is_ad = true
  group by platform;


create continuous view qos_ad_plays_60m_gl WITH (sw = '60 minute') as
 select
  count(*)
 from qos_stream
  where is_ad = true;

create continuous view qos_ad_plays_10m_gl WITH (sw = '10 minute') as
 select
  count(*)
 from qos_stream
  where is_ad = true;
