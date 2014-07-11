module Text.Highlighter.Lexers.SquidConf (lexer) where

import Text.Regex.PCRE.Light
import Text.Highlighter.Types

lexer :: Lexer
lexer = Lexer
    { lName = "SquidConf"
    , lAliases = ["squidconf", "squid.conf", "squid"]
    , lExtensions = ["squid.conf"]
    , lMimetypes = ["text/x-squidconf"]
    , lStart = root'
    , lFlags = [caseless]
    }

comment' :: TokenMatcher
comment' =
    [ tokNext "\\s*TAG:.*" (Arbitrary "Literal" :. Arbitrary "String" :. Arbitrary "Escape") Pop
    , tokNext ".*" (Arbitrary "Comment") Pop
    ]

root' :: TokenMatcher
root' =
    [ tok "\\s+" (Arbitrary "Text")
    , tokNext "#" (Arbitrary "Comment") (GoTo comment')
    , tok "\\b(?:acl|always_direct|announce_host|announce_period|announce_port|announce_to|anonymize_headers|append_domain|as_whois_server|auth_param_basic|authenticate_children|authenticate_program|authenticate_ttl|broken_posts|buffered_logs|cache_access_log|cache_announce|cache_dir|cache_dns_program|cache_effective_group|cache_effective_user|cache_host|cache_host_acl|cache_host_domain|cache_log|cache_mem|cache_mem_high|cache_mem_low|cache_mgr|cachemgr_passwd|cache_peer|cache_peer_access|cahce_replacement_policy|cache_stoplist|cache_stoplist_pattern|cache_store_log|cache_swap|cache_swap_high|cache_swap_log|cache_swap_low|client_db|client_lifetime|client_netmask|connect_timeout|coredump_dir|dead_peer_timeout|debug_options|delay_access|delay_class|delay_initial_bucket_level|delay_parameters|delay_pools|deny_info|dns_children|dns_defnames|dns_nameservers|dns_testnames|emulate_httpd_log|err_html_text|fake_user_agent|firewall_ip|forwarded_for|forward_snmpd_port|fqdncache_size|ftpget_options|ftpget_program|ftp_list_width|ftp_passive|ftp_user|half_closed_clients|header_access|header_replace|hierarchy_stoplist|high_response_time_warning|high_page_fault_warning|htcp_port|http_access|http_anonymizer|httpd_accel|httpd_accel_host|httpd_accel_port|httpd_accel_uses_host_header|httpd_accel_with_proxy|http_port|http_reply_access|icp_access|icp_hit_stale|icp_port|icp_query_timeout|ident_lookup|ident_lookup_access|ident_timeout|incoming_http_average|incoming_icp_average|inside_firewall|ipcache_high|ipcache_low|ipcache_size|local_domain|local_ip|logfile_rotate|log_fqdn|log_icp_queries|log_mime_hdrs|maximum_object_size|maximum_single_addr_tries|mcast_groups|mcast_icp_query_timeout|mcast_miss_addr|mcast_miss_encode_key|mcast_miss_port|memory_pools|memory_pools_limit|memory_replacement_policy|mime_table|min_http_poll_cnt|min_icp_poll_cnt|minimum_direct_hops|minimum_object_size|minimum_retry_timeout|miss_access|negative_dns_ttl|negative_ttl|neighbor_timeout|neighbor_type_domain|netdb_high|netdb_low|netdb_ping_period|netdb_ping_rate|never_direct|no_cache|passthrough_proxy|pconn_timeout|pid_filename|pinger_program|positive_dns_ttl|prefer_direct|proxy_auth|proxy_auth_realm|query_icmp|quick_abort|quick_abort|quick_abort_max|quick_abort_min|quick_abort_pct|range_offset_limit|read_timeout|redirect_children|redirect_program|redirect_rewrites_host_header|reference_age|reference_age|refresh_pattern|reload_into_ims|request_body_max_size|request_size|request_timeout|shutdown_lifetime|single_parent_bypass|siteselect_timeout|snmp_access|snmp_incoming_address|snmp_port|source_ping|ssl_proxy|store_avg_object_size|store_objects_per_bucket|strip_query_terms|swap_level1_dirs|swap_level2_dirs|tcp_incoming_address|tcp_outgoing_address|tcp_recv_bufsize|test_reachability|udp_hit_obj|udp_hit_obj_size|udp_incoming_address|udp_outgoing_address|unique_hostname|unlinkd_program|uri_whitespace|useragent_log|visible_hostname|wais_relay|wais_relay_host|wais_relay_port)\\b" (Arbitrary "Keyword")
    , tok "\\b(?:proxy-only|weight|ttl|no-query|default|round-robin|multicast-responder|on|off|all|deny|allow|via|parent|no-digest|heap|lru|realm|children|credentialsttl|none|disable|offline_toggle|diskd|q1|q2)\\b" (Arbitrary "Name" :. Arbitrary "Constant")
    , tok "\\b(?:shutdown|info|parameter|server_list|client_list|squid\\.conf)\\b" (Arbitrary "Literal" :. Arbitrary "String")
    , tok "stats/\\b(?:shutdown|info|parameter|server_list|client_list|squid\\.conf)\\b" (Arbitrary "Literal" :. Arbitrary "String")
    , tok "log/\\b(?:shutdown|info|parameter|server_list|client_list|squid\\.conf)\\b=" (Arbitrary "Literal" :. Arbitrary "String")
    , tok "\\b(?:url_regex|urlpath_regex|referer_regex|port|proto|req_mime_type|rep_mime_type|method|browser|user|src|dst|time|dstdomain|ident|snmp_community)\\b" (Arbitrary "Keyword")
    , tok "\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b(?:/(?:\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b)|\\d+)?" (Arbitrary "Literal" :. Arbitrary "Number")
    , tok "\\b\\d+\\b" (Arbitrary "Literal" :. Arbitrary "Number")
    , tok "\\S+" (Arbitrary "Text")
    ]

