ARG GUROBI_VERSION=9.0.2  
ARG LIBGRBFRC_VERSION=local

FROM sebwink/libgrbfrc-grb${GUROBI_VERSION}:${LIBGRBFRC_VERSION} as build

ARG GUROBI_VERSION=9.0.2  
ARG LIBGRBFRC_VERSION=local
ARG GUROBI_USER

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
	apt-get install build-essential -y && \
	mkdir /examples && \
	chown -R ${GUROBI_USER}:${GUROBI_USER} /examples 

USER ${GUROBI_USER}

WORKDIR /examples

COPY *.cpp ./ 
COPY Makefile .

RUN GUROBI_VERSION_TAG=${GUROBI_VERSION} make examples-in-docker
RUN rm *.cpp 

FROM sebwink/libgrbfrc-grb${GUROBI_VERSION}:${LIBGRBFRC_VERSION}

ARG GUROBI_USER

USER root

RUN mkdir /examples && \ 
	chown -R ${GUROBI_USER}:${GUROBI_USER} /examples 

USER ${GUROBI_USER}

COPY --from=build /examples/* /examples/
