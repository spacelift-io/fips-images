target "alpine-base" {
  platforms = ["linux/amd64", "linux/arm64"]
  args = {
    "BASE_IMAGE": "alpine:3.22"
  }
  dockerfile = "alpine/Dockerfile"
  context = "./"
}

target "alpine-gcp" {
  platforms = ["linux/amd64", "linux/arm64"]
  args = {"BASE_IMAGE": "gcr.io/google.com/cloudsdktool/google-cloud-cli:alpine"}
  dockerfile = "alpine/Dockerfile"
  context = "./"
}

target "alpine-python" {
  platforms = ["linux/amd64", "linux/arm64"]
  args = {"BASE_IMAGE": "python:3.12-alpine"}
  dockerfile = "alpine/Dockerfile"
  context = "./"
}

target "debian-base" {
  platforms = ["linux/amd64", "linux/arm64"]
  dockerfile = "debian/Dockerfile"
  context = "./"
}