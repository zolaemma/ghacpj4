terraform {
  backend "s3" {
    bucket = "tf-s3a-bk"
    key    = "tf-s3a-bk"
    region = "us-east-1"
  }
}
