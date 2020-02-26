resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "main"
}

resource "aws_cloudfront_distribution" "default" {
  
  # General
  enabled             = true
  comment             = var.comment
  default_root_object = var.default_root_object
  aliases             = var.aliases
  web_acl_id          = var.web_acl_id
  price_class         = var.price_class

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.viewer_minimum_protocol_version
    cloudfront_default_certificate = var.acm_certificate_arn == "" ? true : false
  }

  dynamic "logging_config" {
    for_each = var.logging_enabled ? ["true"] : []
    content {
      include_cookies = var.log_include_cookies
      bucket          = var.log_bucket_domain_name
      prefix          = var.log_prefix
    }
  }

  tags = local.base_tags

  # Origins
  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = origin.domain_name
      origin_path = origin.path
      origin_id   = origin.id

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_headers", [])
        content {
          name  = custom_header.name
          value = custom_header.value
        }
      }

      custom_origin_config {
        origin_ssl_protocols     = origin.ssl_protocols || var.origin_ssl_protocols_default
        origin_protocol_policy   = origin.protocol_policy || var.origin_protocol_policy_default
        origin_read_timeout      = origin.read_timeout || var.origin_read_timeout_default
        origin_keepalive_timeout = origin.keepalive_timeout || var.origin_keepalive_timeout_default
        http_port                = origin.http_port || var.origin_http_port_default
        https_port               = origin.https_port || var.origin_https_port_default
      }
    }
  }

  # Behaviors

  default_cache_behavior {
    target_origin_id       = var.default_behavior_target_origin_id
    viewer_protocol_policy = var.cache_behavior_viewer_protocol_policy_default
    allowed_methods        = var.cache_behavior_allowed_methods_default
    cached_methods         = var.cache_behavior_cached_methods_default
    
    forwarded_values {
      query_string = var.cache_behavior_forwarded_values_query_string_default
      cookies {
        forward           = var.cache_behavior_forwarded_values_cookies_forward_default
        whitelisted_names = var.cache_behavior_forwarded_values_cookies_whitelisted_names_default
      }
    }

    default_ttl = var.cache_behavior_default_ttl_default
    min_ttl     = var.cache_behavior_min_ttl_default
    max_ttl     = var.cache_behavior_max_ttl_default
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_behaviors
    content {
      path_pattern           = ordered_cache_behavior.path_pattern
      target_origin_id       = default_cache_behavior.target_origin_id
      viewer_protocol_policy = default_cache_behavior.viewer_protocol_policy || var.cache_behavior_viewer_protocol_policy_default
      allowed_methods        = default_cache_behavior.allowed_methods || var.cache_behavior_allowed_methods_default
      cached_methods         = default_cache_behavior.cached_methods || var.cache_behavior_cached_methods_default
      
      forwarded_values {
        query_string = default_cache_behavior.forward_query_string || var.cache_behavior_forwarded_values_query_string_default
        cookies {
          forward           = default_cache_behavior.forward_cookies || var.cache_behavior_forwarded_values_cookies_forward_default
          whitelisted_names = default_cache_behavior.forward_cookies_whitelisted_names || var.cache_behavior_forwarded_values_cookies_whitelisted_names_default
        }
      }

      default_ttl = default_cache_behavior.default_ttl || var.cache_behavior_default_ttl_default
      min_ttl     = default_cache_behavior.min_ttl || var.cache_behavior_min_ttl_default
      max_ttl     = default_cache_behavior.max_ttl || var.cache_behavior_max_ttl_default      
    }
  }  

  # Error Pages
  dynamic "custom_error_response" {
    for_each = var.custom_error_responses
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = custom_error_response.value.error_code
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }  
}
