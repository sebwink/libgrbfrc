ARG GUROBI_VERSION

FROM sebwink/gurobi:${GUROBI_VERSION} as build 

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential && \
    mkdir grbfrc   

WORKDIR /grbfrc

COPY Makefile .
COPY gurobi.mak .
COPY src src

RUN make clean && make lib/libgrbfrc.so 

FROM sebwink/gurobi:${GUROBI_VERSION}

COPY --from=build /grbfrc/lib/libgrbfrc.so /usr/local/lib/
COPY --from=build /grbfrc/src/*.hpp /usr/local/include/
