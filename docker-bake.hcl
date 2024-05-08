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

target "base" {
    tags = ["${ORGANIZATION}/build-machine:latest"]
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