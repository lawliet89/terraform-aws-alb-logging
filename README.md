# Access Logging Bucket

This module is a utility module to create and set IAM permissions for ALB logging.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.access_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.logging_elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logging_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | Name of Access Logging bucket to create | `string` | n/a | yes |
| <a name="input_logging_bucket_policy"></a> [logging\_bucket\_policy](#input\_logging\_bucket\_policy) | Bucket policy document, if any | `string` | `""` | no |
| <a name="input_logging_expiration"></a> [logging\_expiration](#input\_logging\_expiration) | Expiration lifecycle rules for access logging bucket | <pre>list(object({<br>    enabled = bool<br><br>    date = optional(string) # Specifies the date after which you want the corresponding action to take effect.<br>    days = optional(number) # Specifies the number of days after object creation when the specific rule action takes effect.<br>    id   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_logging_prefixes"></a> [logging\_prefixes](#input\_logging\_prefixes) | Prefixes you want to include in the resource policy for the bucket. Set to an empty list to allow all (*) | `list(string)` | `[]` | no |
| <a name="input_logging_transition"></a> [logging\_transition](#input\_logging\_transition) | Logging class storage transitions | <pre>list(object({<br>    enabled       = bool<br>    storage_class = string<br><br>    date = optional(string) # Specifies the date after which you want the corresponding action to take effect.<br>    days = optional(number) # Specifies the number of days after object creation when the specific rule action takes effect.<br>    id   = optional(string)<br>  }))</pre> | <pre>[<br>  {<br>    "days": 30,<br>    "enabled": true,<br>    "id": "IA",<br>    "storage_class": "STANDARD_IA"<br>  },<br>  {<br>    "days": 365,<br>    "enabled": true,<br>    "id": "Glacier",<br>    "storage_class": "GLACIER"<br>  }<br>]</pre> | no |
| <a name="input_object_default_retention"></a> [object\_default\_retention](#input\_object\_default\_retention) | Object lock default retention configuration. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html | <pre>object({<br>    mode  = string<br>    days  = optional(number)<br>    years = optional(number)<br>  })</pre> | <pre>{<br>  "mode": "GOVERNANCE",<br>  "years": 2<br>}</pre> | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | Enable Object Lock on the bucket. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html | `bool` | `false` | no |
| <a name="input_public_block"></a> [public\_block](#input\_public\_block) | Public block settings for S3 bucket | <pre>object({<br>    block_public_acls   = bool<br>    block_public_policy = bool<br><br>    ignore_public_acls      = bool<br>    restrict_public_buckets = bool<br>  })</pre> | <pre>{<br>  "block_public_acls": true,<br>  "block_public_policy": true,<br>  "ignore_public_acls": true,<br>  "restrict_public_buckets": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | <pre>{<br>  "Terraform": "true"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the logging bucket |
| <a name="output_name"></a> [name](#output\_name) | Name of the logging bucket |
<!-- END_TF_DOCS -->
