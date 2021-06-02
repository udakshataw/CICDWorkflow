provider "aws" {
    region = "${var.aws_creds.aws_region}"
}

terraform {
  backend "s3" {}
}

resource "aws_dynamodb_table" "demo-table-1" {
    name           = "demo-table-1"
    billing_mode   = "PROVISIONED"
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "UserId"
    range_key      = "GameTitle"

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "GameTitle"
        type = "S"
    }

    attribute {
        name = "TopScore"
        type = "N"
    }

    global_secondary_index {
        name               = "GameTitleIndex"
        hash_key           = "GameTitle"
        range_key          = "TopScore"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "INCLUDE"
        non_key_attributes = ["UserId"]
    }

    tags = {
        Name        = "dynamodb-table-1"
        Environment = "staging"
    }

    lifecycle {
        ignore_changes = [
            hash_key,
            range_key,
            local_secondary_index,
        ]
    }
}

resource "aws_dynamodb_table" "demo-table-2" {
    name           = "demo-table-2"
    billing_mode   = "PROVISIONED"
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "UserId"
    range_key      = "GameTitle"

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "GameTitle"
        type = "S"
    }

    attribute {
        name = "TopScore"
        type = "N"
    }

    global_secondary_index {
        name               = "GameTitleIndex"
        hash_key           = "GameTitle"
        range_key          = "TopScore"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "INCLUDE"
        non_key_attributes = ["UserId"]
    }

    tags = {
        Name        = "dynamodb-table-2"
        Environment = "staging"
    }

    lifecycle {
        ignore_changes = [
            hash_key,
            range_key,
            local_secondary_index,
        ]
    }
}

variable "aws_creds" {
    description = "Credentials for deployment"
    type = map(string)
    default = {
        aws_stage = "dev",
        aws_region = "us-east-1"
    }
}

locals {
  stage = "${var.aws_creds.aws_stage}"
  region = "${var.aws_creds.aws_region}"
}