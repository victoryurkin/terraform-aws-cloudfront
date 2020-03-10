resource "aws_cloudfront_distribution" "default" {
  # Top-Level Arguments
  enabled             = true
  comment             = var.comment
  default_root_object = var.default_root_object
  aliases             = var.aliases
  web_acl_id          = var.web_acl_id
  price_class         = var.price_class

  # Viewer Certificate Arguments
  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.viewer_minimum_protocol_version
    cloudfront_default_certificate = var.acm_certificate_arn == "" ? true : false
  }

  # Logging Config Arguments
  dynamic "logging_config" {
    for_each = var.logging_enabled ? ["true"] : []
    content {
      include_cookies = var.log_include_cookies
      bucket          = var.log_bucket_domain_name
      prefix          = var.log_prefix
    }
  }

  # Origin Arguments
  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name = origin.value.domain_name
      origin_path = lookup(origin.value, "path", "")
      origin_id   = origin.value.id
      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_headers", [])
        content {
          name  = custom_header.value.name
          value = custom_header.value.value
        }
      }
      custom_origin_config {
        origin_ssl_protocols     = lookup(origin.value, "ssl_protocols", var.origin_ssl_protocols_default)
        origin_protocol_policy   = lookup(origin.value, "protocol_policy", var.origin_protocol_policy_default)
        origin_read_timeout      = lookup(origin.value, "read_timeout", var.origin_read_timeout_default)
        origin_keepalive_timeout = lookup(origin.value, "keepalive_timeout", var.origin_keepalive_timeout_default)
        http_port                = lookup(origin.value, "http_port", var.origin_http_port_default)
        https_port               = lookup(origin.value, "https_port", var.origin_https_port_default)
      }
    }
  }

  # Cache Behavior Arguments
  default_cache_behavior {
    target_origin_id       = var.default_behavior_target_origin_id
    viewer_protocol_policy = var.cache_behavior_viewer_protocol_policy_default
    allowed_methods        = var.cache_behavior_allowed_methods_default
    cached_methods         = var.cache_behavior_cached_methods_default
    default_ttl            = var.cache_behavior_default_ttl_default
    min_ttl                = var.cache_behavior_min_ttl_default
    max_ttl                = var.cache_behavior_max_ttl_default
    forwarded_values {
      query_string = var.cache_behavior_forwarded_values_query_string_default
      cookies {
        forward           = var.cache_behavior_forwarded_values_cookies_forward_default
        whitelisted_names = var.cache_behavior_forwarded_values_cookies_whitelisted_names_default
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_behaviors
    content {
      path_pattern           = ordered_cache_behavior.value.path_pattern
      target_origin_id       = ordered_cache_behavior.value.target_origin_id
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", var.cache_behavior_viewer_protocol_policy_default)
      allowed_methods        = lookup(ordered_cache_behavior.value, "allowed_methods", var.cache_behavior_allowed_methods_default)
      cached_methods         = lookup(ordered_cache_behavior.value, "cached_methods", var.cache_behavior_cached_methods_default)
      default_ttl            = lookup(ordered_cache_behavior.value, "default_ttl", var.cache_behavior_default_ttl_default)
      min_ttl                = lookup(ordered_cache_behavior.value, "min_ttl", var.cache_behavior_min_ttl_default)
      max_ttl                = lookup(ordered_cache_behavior.value, "max_ttl", var.cache_behavior_max_ttl_default)
      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "forward_query_string", var.cache_behavior_forwarded_values_query_string_default)
        cookies {
          forward           = lookup(ordered_cache_behavior.value, "forward_cookies", var.cache_behavior_forwarded_values_cookies_forward_default)
          whitelisted_names = lookup(ordered_cache_behavior.value, "forward_cookies_whitelisted_names", var.cache_behavior_forwarded_values_cookies_whitelisted_names_default)
        }
        headers      = lookup(ordered_cache_behavior.value, "forward_headers", var.cache_behavior_forwarded_values_headers_default)
      }
    }
  }  

  # Custom Error Response Arguments
  dynamic "custom_error_response" {
    for_each = var.custom_error_responses
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = custom_error_response.value.error_code
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }

  # Restrictions Arguments
  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  tags = merge(
    {
      "Name" = format("%s", "Front-End Cloudfront Disctribution ${var.client_name}")
    },
    local.base_tags
  )
}
