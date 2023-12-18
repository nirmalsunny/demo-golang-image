# syntax=docker/dockerfile:1

FROM golang:1.20.4-alpine3.18 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
COPY *.go ./

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp

# Use a minimal base image for the final container
FROM scratch

# Copy the binary from the builder stage
COPY --from=builder /app/myapp /myapp

# Set the binary as the entry point
ENTRYPOINT ["/myapp"]
