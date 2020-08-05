# specify your Gruobi version
GUROBI_VERSION_TAG ?= 9.0.2
GUROBI_VERSION=$(shell echo $(GUROBI_VERSION_TAG) | sed 's/-.*//g')
GUROBI_MAJOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 1)
GUROBI_MINOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 2)
GUROBI_VERSION_SUFFIX=${GUROBI_MAJOR_VERSION}${GUROBI_MINOR_VERSION}
# set GUROBI_HOME according to your environment
GUROBI_HOME ?= ${GUROBI_HOME}/gurobi/${GUROBI_VERSION}

gurobi_major:
	@echo $(GUROBI_MAJOR_VERSION)

gurobi_minor:
	@echo $(GUROBI_MINOR_VERSION)
