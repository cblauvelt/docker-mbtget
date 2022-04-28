FROM perl:5.34.1 as builder

RUN apt-get update && apt-get -y --no-install-recommends install \
    build-essential \
    git

RUN git clone https://github.com/cblauvelt/mbtget.git && \
    cd mbtget && \
    perl Makefile.PL && \
    make && \
    make install

FROM perl:5.34 as prod

COPY --from=builder /usr/local/bin/mbtget /usr/local/bin/mbtget

CMD [ "/usr/local/bin/mbtget", "-v" ]