FROM golang:1.8 as builder

ENV GLIDE_VERSION v0.12.3
ENV APP_VERSION 1.0.2

ADD https://github.com/Masterminds/glide/releases/download/${GLIDE_VERSION}/glide-${GLIDE_VERSION}-linux-amd64.tar.gz /tmp
RUN cp /tmp/linux-amd64/glide /usr/local/bin/glide && \
    chmod 755 /usr/local/bin/glide && \
    rm -rf /tmp/linux-amd64/


COPY . /go/src/github.com/apiaryio/heroku-datadog-drain-go

RUN cd /go/src/github.com/apiaryio/heroku-datadog-drain-go && \
    glide install && \
    go install

FROM scratch
COPY --from=builder /go/bin/heroku-datadog-drain-go .
CMD ["./heroku-datadog-drain-go"]
