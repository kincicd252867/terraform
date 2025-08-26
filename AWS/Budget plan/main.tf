terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# Create budget plan.
resource "aws_budgets_budget" "like-and-subscribe" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "600.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2024-06-15_00:00"
}

