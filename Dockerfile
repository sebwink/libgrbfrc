ARG GUROBI_VERSION

FROM sebwink/gurobi:${GUROBI_VERSION} as build 

RUN echo "sebwink/gurobi:${GUROBI_VERSION}"

ARG GUROBI_VERSION
ARG GUROBI_USER

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential && \
    mkdir grbfrc   

WORKDIR /grbfrc

COPY Makefile .
COPY gurobi.mak .
COPY src src

RUN echo ${GUROBI_VERSION}
RUN GUROBI_VERSION_TAG=$(echo ${GUROBI_VERSION} | tr "-" " " | awk ' { print $1 } ') make gurobi_major && \
    GUROBI_VERSION_TAG=$(echo ${GUROBI_VERSION} | tr "-" " " | awk ' { print $1 } ') make gurobi_minor
RUN make clean && GUROBI_VERSION_TAG=$(echo ${GUROBI_VERSION} | tr "-" " " | awk ' { print $1 } ') make lib/libgrbfrc.so 

FROM sebwink/gurobi:${GUROBI_VERSION}

COPY --from=build /grbfrc/lib/libgrbfrc.so /usr/local/lib/
COPY --from=build /grbfrc/src/*.hpp /usr/local/include/
USER root
RUN mkdir /usr/local/include/grbfrc
COPY --from=build /grbfrc/src/*.hpp /usr/local/include/grbfrc/

USER ${GUROBI_USER}
