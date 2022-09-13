# ===================================== Kafka Service =====================================
module "varo-kafka-s3" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_name"])}-cdc-kafka"
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cdc-kafka"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "msk"
      "Service Owner" = "platform"
    }
  )
}

module "varo-kafka-s3-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_name"])}-cdc-kafka-east"
  tags = merge(module.common_east.tags,
    {
      Service         = "msk"
      "Service Owner" = "platform"
    }
  )
}
# ===================================== Netsuite Service =====================================
module "varo-general-ledger-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-general-ledger"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-general-ledger"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "netsuite"
      "Service Owner" = "banking"
    }
  )
}

module "varo-general-ledger-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-general-ledger-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "netsuite"
      "Service Owner" = "banking"
    }
  )
}
# ===================================== Netsuite ADP GL Bucket =====================================
module "varo-adp-gl-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adp-gl"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adp-gl"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "netsuite"
    "Service Owner" = "banking"
  }
  )
}

module "varo-adp-gl-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adp-gl-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "netsuite"
    "Service Owner" = "banking"
  }
  )
}
# ===================================== Unsorted ====================================
module "varo-aiml" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-aiml"
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-aiml"]
    }
  ]
  tags = merge(module.common_east.tags,
    {
      Service         = "feature"
      "Service Owner" = "aiml"
    }
  )
}

module "varo-aiml-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-aiml-east"
  tags = merge(module.common_east.tags,
    {
      Service         = "feature"
      "Service Owner" = "aiml"
    }
  )
}

## TODO Check if these are actually being used
module "varo-python-artifacts-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-python-artifacts"
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-python-artifacts"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "Unknown"
      "Service Owner" = "Unknown"
    }
  )
}

## TODO Check if these are actually being used
module "varo-athena-query-source-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-athena-source-data"
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-athena-source-data"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "Unknown"
      "Service Owner" = "Unknown"
    }
  )
}

## TODO Check if these are actually being used
module "varo-athena-query-results-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-athena-query-results"
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-athena-query-results"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "Unknown"
      "Service Owner" = "Unknown"
    }
  )
}

# ================================== Offers Service =====================================

module "varo-batch-offers-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-batch-offers"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-batch-offers"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "offers"
      "Service Owner" = "lending"
    }
  )
}

module "varo-batch-offers-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-batch-offers-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "offers"
      "Service Owner" = "lending"
    }
  )
}

module "varo-cashback-netsuite-gl" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cashback-netsuite-gl"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cashback-netsuite-gl"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "offers"
    "Service Owner" = "Auxilary"
  }
  )
}

module "varo-cashback-netsuite-gl-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cashback-netsuite-gl-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "offers"
    "Service Owner" = "Auxilary"
  }
  )
}

# ================================== Document Service =====================================

module "varo-legal-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-legal-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  cors_rules = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://*.varomoney.com"]
      allowed_headers = ["*"]
    }
  ]
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-legal-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-legal-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-legal-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  cors_rules = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://*.varomoney.com"]
      allowed_headers = ["*"]
    }
  ]
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

# ==================================== KYC SUPPRESSION LIST ====================================
module "varo-kyc-suppression-list-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-suppression-list"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-suppression-list"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "kyc"
      "Service Owner" = "risk"
    }
  )
}

module "varo-kyc-suppression-list-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-suppression-list-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "kyc"
      "Service Owner" = "risk"
    }
  )
}

# ==================================== BANKING DOCUMENT ====================================
module "varo-banking-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-banking-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-banking-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "Unknown"
      "Service Owner" = "Unknown"
    }
  )
}

module "varo-banking-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-banking-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "Unknown"
      "Service Owner" = "Unknown"
    }
  )
}

module "varo-check-image-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

resource "aws_s3_bucket_policy" "varo-check-image-document-bucket-policy" {
  bucket = module.varo-check-image-document-bucket.bucket_id
  policy = data.aws_iam_policy_document.varo-check-image-document-bucket-policy-document.json
}

data "aws_iam_policy_document" "varo-check-image-document-bucket-policy-document" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]

    effect = "Allow"

    resources = [
      module.varo-check-image-document-bucket.bucket_arn,
      "${module.varo-check-image-document-bucket.bucket_arn}/*",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/dl-image-access-service-role"]
      type = "AWS"
    }
  }
}

resource "aws_kms_grant" "varo-check-image-kms-allow-dl-image-access-service-role" {
  name              = "varo-check-image-kms-allow"
  key_id            = module.varo-check-image-document-bucket.kms_key_id[0]
  grantee_principal = "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/dl-image-access-service-role"
  operations        = ["Decrypt", "GenerateDataKey"]
}

resource "aws_s3_bucket_policy" "varo-check-image-file-document-bucket-policy" {
  bucket = module.varo-check-image-file-document-bucket.bucket_id
  policy = data.aws_iam_policy_document.varo-check-image-file-document-bucket-policy-document.json
}

data "aws_iam_policy_document" "varo-check-image-file-document-bucket-policy-document" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
    ]

    effect = "Allow"

    resources = [
      module.varo-check-image-file-document-bucket.bucket_arn,
      "${module.varo-check-image-file-document-bucket.bucket_arn}/*",
    ]

    principals {
      identifiers = [
        "arn:aws:iam::${data.vault_generic_secret.vaultkey.data["data_account_id"]}:role/dl-image-access-service-role"]
      type = "AWS"
    }
  }
}

resource "aws_kms_grant" "varo-check-image-file-kms-allow-dl-image-access-service-role" {
  name = "varo-check-image-file-kms-allow"
  key_id = module.varo-check-image-file-document-bucket.kms_key_id[0]
  grantee_principal = "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/dl-image-access-service-role"
  operations        = ["Decrypt", "GenerateDataKey"]
}

module "varo-check-image-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-return-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-return-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-return-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-return-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-return-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-rejected-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-rejected-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-rejected-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x9-rejected-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x9-rejected-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-rdc-kitchen-sink-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-rdc-kitchen-sink-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-rdc-kitchen-sink-file-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-rdc-kitchen-sink-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-rdc-kitchen-sink-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-cst-offboard-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-offboard-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-offboard-file-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-cst-offboard-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-offboard-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-positive-pay-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-positive-pay-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-positive-pay-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-positive-pay-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-positive-pay-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-check-register-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-register-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-register-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-check-register-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-register-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-direct-deposit-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-direct-deposit"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? [
        "https://bank.varomoney.com",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
      ] : [
        "http://localhost:8080",
        "https://localhost:8080",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
        "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
      ]
    }
  ]
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-direct-deposit"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-direct-deposit-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-direct-deposit-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x12-out-svb-file-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x12-out-svb-file"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x12-out-svb-file"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-x12-out-svb-file-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-x12-out-svb-file-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-selfie-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-selfie"
  kms_key_policy     = data.aws_iam_policy_document.varo-prod-selfie-key-policy-document.json
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-selfie"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}



resource "aws_s3_bucket_policy" "varo-prod-selfie-s3-bucket-policy" {
  count  = nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_name"]) == "prod" ? 1 : 0
  bucket = module.varo-selfie-bucket.bucket_id
  policy = data.aws_iam_policy_document.varo-prod-selfie-bucket-policy-document.json
}

data "aws_iam_policy_document" "varo-prod-selfie-key-policy-document" {
  statement {
    sid = "1"

    principals {
      identifiers = [
        "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/EMR_EC2_DefaultRole"
      ]

      type = "AWS"
    }

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:DescribeKey"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:kms:us-west-2:678601750823:key/e060567c-f788-4c81-97a8-a177ec128a8b"
    ]
  }

  statement {
    sid = "Enable IAM User Permissions"

    principals {
      identifiers = [
        "arn:aws:iam::678601750823:root"
      ]

      type = "AWS"
    }

    actions = [
      "kms:*"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "varo-prod-selfie-bucket-policy-document" {
  statement {
    sid = "1"

    principals {
      identifiers = [
        "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/EMR_EC2_DefaultRole"
      ]

      type = "AWS"
    }

    actions = [
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetBucketLocation"
    ]

    effect = "Allow"

    resources = [
      "${module.varo-selfie-bucket.bucket_arn}/*",
      module.varo-selfie-bucket.bucket_arn
    ]
  }
}


module "varo-selfie-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-selfie-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
}

module "varo-address-verification-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-address-verification"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-address-verification"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-address-verification-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-address-verification-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-ssn-verification-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-ssn-verification"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-ssn-verification"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-ssn-verification-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-ssn-verification-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-risk-based-pricing-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-risk-based-pricing"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-risk-based-pricing"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-risk-based-pricing-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-risk-based-pricing-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-other-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-other"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-other"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-other-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-other-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-monthly-cda-recon-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-monthly-cda-recon-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-monthly-cda-recon-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-monthly-cda-recon-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-monthly-cda-recon-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-check-image-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-file-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-check-image-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-check-image-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "document"
      "Service Owner" = "banking"
    }
  )
}

module "varo-fast-track-ack-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fast-track-ack-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fast-track-ack-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-fast-track-ack-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fast-track-ack-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-mac-check-image-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-check-image-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-check-image-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-mac-check-image-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-check-image-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-customer-profile-image-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-customer-profile-image-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-customer-profile-image-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-customer-profile-image-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-customer-profile-image-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-idemia-comp-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-idemia-comp-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-idemia-comp-file-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-idemia-comp-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-idemia-comp-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-mac-tv-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-tv-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-tv-file-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-mac-tv-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-mac-tv-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

# ================================== Lending Service =====================================

module "varo-user-id-docs-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-user-id-document"
  kms_key_policy     = data.aws_iam_policy_document.varo-prod-user-id-document-key-policy-document.json
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-user-id-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}


resource "aws_s3_bucket_policy" "varo-prod-user-id-document-s3-bucket-policy" {
  count  = nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_name"]) == "prod" ? 1 : 0
  bucket = module.varo-user-id-docs-bucket.bucket_id
  policy = data.aws_iam_policy_document.varo-prod-user-id-document-bucket-policy-document.json
}

data "aws_iam_policy_document" "varo-prod-user-id-document-key-policy-document" {
  statement {
    sid = "1"

    principals {
      identifiers = [
        "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/EMR_EC2_DefaultRole"
      ]

      type = "AWS"
    }

    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    effect = "Allow"

    resources = [
      "arn:aws:kms:us-west-2:678601750823:key/bc11c1af-2b74-4645-992b-9090146b6cbc"
    ]
  }

  statement {
    sid = "Enable IAM User Permissions"

    principals {
      identifiers = [
        "arn:aws:iam::678601750823:root"
      ]

      type = "AWS"
    }

    actions = [
      "kms:*"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "varo-prod-user-id-document-bucket-policy-document" {
  statement {
    sid = "1"

    principals {
      identifiers = [
        "arn:aws:iam::${nonsensitive(data.vault_generic_secret.vaultkey.data["data_account_id"])}:role/EMR_EC2_DefaultRole"
      ]

      type = "AWS"
    }

    actions = [
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetBucketLocation"
    ]

    effect = "Allow"

    resources = [
      "${module.varo-user-id-docs-bucket.bucket_arn}/*",
      module.varo-user-id-docs-bucket.bucket_arn
    ]
  }
}



module "varo-user-id-docs-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-user-id-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-income-verification-docs-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-income-verification-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-income-verification-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-income-verification-docs-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-income-verification-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-unidentified-docs-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-unidentified-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-unidentified-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-unidentified-docs-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-unidentified-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-til-docs-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-til-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  log_rotate         = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  cors_rules = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://*.varomoney.com"]
      allowed_headers = ["*"]
    }
  ]
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-til-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}


module "varo-til-docs-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-til-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  log_rotate         = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  cors_rules = [
    {
      allowed_methods = ["GET"]
      allowed_origins = ["https://*.varomoney.com"]
      allowed_headers = ["*"]
    }
  ]
  tags = merge(module.common_east.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-adverse-action-docs-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adverse-action-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  log_rotate         = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adverse-action-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}

module "varo-adverse-action-docs-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-adverse-action-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  log_rotate         = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "lending"
      "Service Owner" = "lending"
    }
  )
}


# ================================== Statement Service =====================================

module "varo-efs-raw-documents" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-efs-raw-documents"
  versioning_enabled = false

  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-efs-raw-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "statement"
      "Service Owner" = "banking"
    }
  )
}

resource "aws_s3_bucket_notification" "varo-efs-raw-documents" {
  bucket = module.varo-efs-raw-documents.bucket_id

  queue {
    queue_arn = module.statement_efs_raw_document_queue.queue_arn
    events    = ["s3:ObjectCreated:*"]
  }
}

module "varo-efs-raw-documents-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-efs-raw-documents-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "statement"
      "Service Owner" = "banking"
    }
  )
}

resource "aws_s3_bucket_notification" "varo-efs-raw-documents-east" {
  provider = aws.us-east-1
  bucket   = module.varo-efs-raw-documents-east.bucket_id

  queue {
    queue_arn = module.statement_efs_raw_document_queue_east.queue_arn
    events    = ["s3:ObjectCreated:*"]
  }
}

module "varo-account-statement-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-account-statement-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-account-statement-document"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "statement"
      "Service Owner" = "banking"
    }
  )
}

module "varo-account-statement-document-bucket-east" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-account-statement-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
    {
      Service         = "statement"
      "Service Owner" = "banking"
    }
  )
}

module "varo-fed-routing-import-file-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fed-routing-import-file-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fed-routing-import-file-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-fed-routing-import-file-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-fed-routing-import-file-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}
# ===================================== GraphQL =====================================

resource "aws_kms_key" "varo-bank-graphql-private-key" {
  description             = "This key is used to encrypt the S3 bucket: varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
  deletion_window_in_days = 10
  tags = merge(module.common.tags,
    {
      Name            = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
      Service         = "graphql-document"
      "Service Owner" = "graphql"
    }
  )
}

resource "aws_kms_alias" "varo-bank-graphql-private-key" {
  name          = "alias/varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
  target_key_id = aws_kms_key.varo-bank-graphql-private-key.key_id
}

resource "aws_s3_bucket" "varo-bank-graphql-private" {
  bucket = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST"]
    allowed_origins = data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? [
      "https://bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
      ] : [
      "http://localhost:8080",
      "https://localhost:8080",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  lifecycle_rule {
    id      = "all"
    enabled = true

    expiration {
      days = 2
    }

  }

  versioning {
    enabled = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.varo-bank-graphql-private-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"
    target_prefix = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
  }
  tags = merge(module.common.tags,
    {
      Name            = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private"
      Service         = "graphql-private"
      "Service Owner" = "graphql"
    }
  )
}

resource "aws_kms_key" "varo-bank-graphql-private-key-east" {
  provider                = aws.us-east-1
  description             = "This key is used to encrypt the S3 bucket: varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private-east"
  deletion_window_in_days = 10
  tags = merge(module.common_east.tags,
    {
      Name            = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private-east"
      Service         = "graphql-document"
      "Service Owner" = "graphql"
    }
  )
}

resource "aws_kms_alias" "varo-bank-graphql-private-key-east" {
  provider      = aws.us-east-1
  name          = "alias/varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private-east"
  target_key_id = aws_kms_key.varo-bank-graphql-private-key-east.key_id
}

resource "aws_s3_bucket" "varo-bank-graphql-private-east" {
  provider = aws.us-east-1
  bucket   = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private-east"
  acl      = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST"]
    allowed_origins = data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? [
      "https://bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
      ] : [
      "http://localhost:8080",
      "https://localhost:8080",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_west_region"])}-bank.varomoney.com",
      "https://${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_east_region"])}-bank.varomoney.com"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  lifecycle_rule {
    id      = "all"
    enabled = true

    expiration {
      days = 2
    }

  }

  versioning {
    enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.varo-bank-graphql-private-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  tags = merge(module.common_east.tags,
    {
      Name            = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-graphql-private-east"
      Service         = "graphql-private"
      "Service Owner" = "graphql"
    }
  )
}

# ======================= customer-ops-api-upload Service =========================

module "varo-cst-graphql-api-upload-private" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-graphql-api-upload-private"
  versioning_enabled = false
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-graphql-api-upload-private"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "customer-ops-api-upload"
    "Service Owner" = "cst"
  }
  )
}

module "varo-cst-graphql-api-upload-private-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-cst-graphql-api-upload-private-east"
  versioning_enabled = false
  tags = merge(module.common_east.tags,
  {
    Service         = "customer-ops-api-upload"
    "Service Owner" = "cst"
  }
  )
}

# ======= Vendors SFTP Bucket =======
module "vendors-sftp-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-vendors-sftp"
  versioning_enabled = true
  kms_encryption     = true
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-vendors-sftp"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "vendors"
      "Service Owner" = "shared"
    }
  )
}

module "msk-logs-s3-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-msk-broker-logs"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)

  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-msk-broker-logs"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "msk"
      "Service Owner" = "platform"
    }
  )
}


module "varo-aiml-features" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-aiml-features"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)

  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-aiml-features"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "feature"
      "Service Owner" = "aiml"
    }
  )
}

#s3 cross owner and cross region logging is not supported, so we need accounts per environment
module "varo-s3logs" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"
  log_rotate         = false
  versioning_enabled = false
  kms_encryption     = false
  acl                = "log-delivery-write"
  tags = merge(module.common.tags,
    {
      Service         = "platform"
      "Service Owner" = "platform"
    }
  )
}

resource "aws_kms_key" "backups_kms_key" {
  description = "This key is used to encrypt the S3 bucket: varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-database-backups"
  deletion_window_in_days = 10
  enable_key_rotation = false
  policy = null
  tags = merge(module.common.tags,
  {
    Service = "database"
    "Service Owner" = "platform"
  }
  )
}

resource "aws_kms_alias" "backups_kms_alias" {
  name = "alias/varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-database-backups"
  target_key_id = aws_kms_key.backups_kms_key.key_id
}

resource "aws_s3_bucket" "varo-database-backups" {
  count = data.vault_generic_secret.vaultkey.data["aws_account_name"] == "prod" ? 1 : 0
  bucket = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-database-backups"

  logging {
      target_bucket = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"
      target_prefix = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-athena-query-results"
  }

  tags = merge(module.common.tags,
    {
      Service = "database"
      "Service Owner" = "platform"
    }
  )
  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "log-expiration"
    enabled = true

    noncurrent_version_expiration {
      days = 5
    }

    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_encryption ? join(" ", aws_kms_key.backups_kms_key.*.arn) : ""
        sse_algorithm = var.kms_encryption ? "aws:kms" : "AES256"
      }
    }
  }
}

# ======= Job Auditing Bucket =======
module "job-auditing-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-job-auditing-bucket"
  versioning_enabled = true
  kms_encryption     = true
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-job-auditing-bucket"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "platform"
      "Service Owner" = "platform"
    }
  )
}

module "varo-applications-bulk-decline-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-applications-bulk-decline"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-applications-bulk-decline"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "customer-ops"
    "Service Owner" = "cst"
  }
  )
}

module "varo-applications-bulk-decline-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-applications-bulk-decline-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "customer-ops"
    "Service Owner" = "cst"
  }
  )
}

# INF-1991: S3 bucket to handle PII data coming from RDS
module "varo-rds-database-exports" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-database-exports"
  versioning_enabled = true
  kms_encryption     = true
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-rds-database-exports-logs"]
    }
  ]
  tags = merge(module.common.tags,
    {
      Service         = "database"
      "Service Owner" = "database"
    }
  )
}

module "varo-loki" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-loki"
  versioning_enabled = false
  log_rotate         = false
}

# INF-3746 Store kalpita-wiremock json mappings  backup in the s3 bucket
module "kalpita-wiremock-mapping" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-kalpita-wiremock-mapping"
  versioning_enabled = false
  log_rotate         = false
  kms_encryption     = false
}
#=================Nownetwork-Integration-Service-Start==========
module "varo-nownetwork-recon-files-document-bucket" {
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-nownetwork-recon-files-document"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  logging = [
    {
      target_bucket = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-s3logs"]
      target_prefix = ["varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-nownetwork-recon-files-document"]
    }
  ]
  tags = merge(module.common.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}

module "varo-nownetwork-recon-files-document-bucket-east" {
  providers = {
    aws = aws.us-east-1
  }
  source = "gitlab.varomoney.com/varo-bank/s3/aws"
  version = "0.1.0"

  bucket_name        = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-nownetwork-recon-files-document-east"
  versioning_enabled = (data.vault_generic_secret.vaultkey.data["aws_account_env"] == "prod" ? true : false)
  tags = merge(module.common_east.tags,
  {
    Service         = "document"
    "Service Owner" = "banking"
  }
  )
}
#=================Nownetwork-Integration-Service-End==========

#=================External-Communication-Service-Start==========

resource "aws_s3_bucket" "external-communication-email-attributes-bucket" {
  bucket = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-external-communication-email-attributes"
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.email-attributes-s3-kms-key.arn
        sse_algorithm     = "aws:kms"
      }
      bucket_key_enabled = true
    }
  }
  tags   = merge(module.common.tags,
    {
      Service         = "external-communication"
      "Service Owner" = "cst"
    }
  )
}

resource "aws_kms_key" "email-attributes-s3-kms-key" {
  description             = "This key is used to encrypt the S3 containing email attributes: varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-email-attributes-s3-kms-key"
  deletion_window_in_days = 10
  tags                    = merge(module.common.tags,
    {
      Name            = "varo-${nonsensitive(data.vault_generic_secret.vaultkey.data["aws_account_env"])}-email-attributes-s3-kms-key"
      Service         = "external-communication"
      "Service Owner" = "cst"
    }
  )
}

#=================External-Communication-Service-End==========