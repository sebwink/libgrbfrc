# specify your Gruobi version
GUROBI_VERSION ?= 9.0.2
GUROBI_MAJOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 1)
GUROBI_MINOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 2)
GUROBI_VERSION_SUFFIX=$(GUROBI_MAJOR_VERSION)$(GUROBI_MINOR_VERSION) 
# set GUROBI_HOME according to your environment
GUROBI_HOME ?= ${GUROBI_HOME}/gurobi/${GUROBI_VERSION}
