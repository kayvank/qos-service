create database qos with owner pipelinedb_usr;

CREATE table qos_stream (
    bitrate double precision,
    qos_startup_time double precision,
    qos_buffering_spinner_duration double precision,
    qos_buffering_spinner_events integer,
    qos_buffering_at_end boolean,
    video_id text,
    video_url text,
    is_ad boolean,
    is_play boolean,
    region text,
    city text,
    country text,
    lat_lon point,
    platform text,
    app_version text,
    build_number text,
    device text,
    user_id text,
    is_anon boolean,
    ip text,
    user_agent text
);
