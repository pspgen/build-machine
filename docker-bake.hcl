group "default" {
    targets = ["base"]
}

variable "ORGANIZATION" {
    default = "pspgen"
}

variable "BASE_IMAGE" {
}

variable "LIBXC_VERSION" {
}

variable "GNU_COMPILER_VERSION" {
}

variable "LAPACK_VERSION" {
}

variable "REGISTRY" {
}

function "tags" {
  params = [image]
  result = [
    "${REGISTRY}/${ORGANIZATION}/${image}",
  ]
}

target "base-meta" {
    tags = tags("build-machine")
}

target "base" {
    inherits = ["base-meta"]
    context = "."
    contexts = {
        base-image = "docker-image://${BASE_IMAGE}"
    }
    args = {
        "LIBXC_VERSION" = "${LIBXC_VERSION}"
        "GNU_COMPILER_VERSION" = "${GNU_COMPILER_VERSION}"
        "LAPACK_VERSION" = "${LAPACK_VERSION}"
    }
}