target "standard" {
  platforms = ["linux/amd64", "linux/arm64"]
  args = {
    "BASE_IMAGE": "alpine:3.21"
  }
}

target "gcp" {
  platforms = ["linux/amd64", "linux/arm64"]
  args = {"BASE_IMAGE": "gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine"}
}