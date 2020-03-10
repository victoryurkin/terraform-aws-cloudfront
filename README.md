## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\\_name | Name of the client. | `string` | n/a | yes |
| environment | The organization environment | `string` | n/a | yes |
| aws\\_region | This is the AWS region. | `string` | n/a | yes |
| provisioning | Is it manually provisioned or using terraform? | `string` | n/a | yes |
| defcon\\_level | Level of distress! | `number` | n/a | yes |
| propagate\\_at\\_launch | Propogate at launch | `bool` | n/a | yes |
| comment | Any comments you want to include about the distribution. | `string` | Managed by Terraform | no |
| default\_root\_object | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | index.html | no |
| aliases | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list` | [] | no |
| web\_acl\_id | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. | `string` |  | no |
| price\_class | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100. | `string` | PriceClass\_All | no |
| acm\_certificate\_arn | The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm\_certificate\_arn, or cloudfront\_default\_certificate. | `string` |  | no |
| viewer\_minimum\_protocol\_version | The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront\_default\_certificate = false. One of SSLv3, TLSv1, TLSv1\_2016, TLSv1.1\_2016 or TLSv1.2\_2018. | `string` | TLSv1.1\_2016 | no |
| logging\_enabled | Wether logging config enabled | `bool` | false | no |
| log\_include\_cookies | Specifies whether you want CloudFront to include cookies in access logs. | `bool` | true | no |
| log\_bucket\_domain\_name | The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com. Required if logging\_enabled is true. | `string` |  | no |
| log\_prefix | An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/. | `string` | logs | no |
| origins | A list of the origin objects. | `list` | [] | no |
| origin\_ssl\_protocols\_default | The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. | `list` | ["TLSv1", "TLSv1.1", "TLSv1.2"] | no |
| origin\_protocol\_policy\_default | The origin protocol policy to apply to your origin. | `string` | match-viewer | no |
| origin\_read\_timeout\_default | The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. | `number` | 60 | no |
| origin\_keepalive\_timeout\_default | The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. | `number` | 60 | no |
| origin\_http\_port\_default | The HTTP port the custom origin listens on. | `number` | 80 | no |
| origin\_https\_port\_default | The HTTPS port the custom origin listens on. | `number` | 443 | no |

| default\_behavior\_target\_origin\_id | The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior. | `string` | n/a | yes |
| ordered\_behaviors | A list of the ordered behaviors | `list` | [] | no |
| cache\_behavior\_viewer\_protocol\_policy\_default | Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https. | `string` | redirect-to-https | no |
| cache\_behavior\_allowed\_methods\_default | Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin. | `list` | ["GET", "HEAD", "OPTIONS"] | no |
| cache\_behavior\_cached\_methods\_default | Controls whether CloudFront caches the response to requests using the specified HTTP methods. | `list` | ["GET", "HEAD", "OPTIONS"] | no |
| cache\_behavior\_default\_ttl\_default | The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day. | `number` | 86400 | no |
| cache\_behavior\_min\_ttl\_default | The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds. | `number` | 0 | no |
| cache\_behavior\_max\_ttl\_default | The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days. | `number` | 31536000 | no |
| cache\_behavior\_forwarded\_values\_query\_string\_default | Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior. | `bool` | false | no |
| cache\_behavior\_forwarded\_values\_headers\_default | Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers. | `list` | [] | no |
| cache\_behavior\_forwarded\_values\_cookies\_forward\_default | Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted\_names. | `string` | none | no |
| cache\_behavior\_forwarded\_values\_cookies\_whitelisted\_names\_default | If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin. | `list` | [] | no |
| custom\_error\_responses | List of one or more custom error response element maps. | `list` | `[{error\_caching\_min\_ttl = 0 error\_code            = 403 response\_code         = 200 response\_page\_path    = "/index.html"}]` | no |
| geo\_restriction\_type | The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | none | no |
| geo\_restriction\_locations | The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist). | `list` | [] | no |

## Outputs

| Name | Description | Type |
|------|-------------|:-----:|
| cf\_id | ID of AWS CloudFront distribution | `string` |
| cf\_arn | ID of AWS CloudFront distribution | `string` |
| cf\_aliases | Extra CNAMEs of AWS CloudFront | `list` |
| cf\_domain\_name | Domain name corresponding to the distribution | `string` |
