examples-docker:
	docker build . --build-arg GUROBI_USER=$(USER) -t sebwink/libgrbfrc-examples-demo:local

run@%: 
	docker run --rm --pid host --mac-address $(MAC_ADDRESS_FOR_GUROBI_DOCKER) -v $(GUROBI_LIC_PATH_DOCKER):/gurobi/lic sebwink/libgrbfrc-examples-demo:local /examples/example$*

CXX=c++
CXXFLAGS += -m64 -g -std=c++17 -Wall -Wextra -pedantic -fPIC #-Werror
CPPFLAGS += -Isrc -I${GUROBI_HOME}/include
LDPATHS += -L${GUROBI_HOME}/lib -L/usr/local/lib
LDFLAGS += ${LDPATHS} 
LDLIBS += -lgurobi_c++ -lgurobi${GUROBI_VERSION_SUFFIX} -lpthread -lm -lgrbfrc
RUNFLAGS += -Wl,-rpath=/usr/local/lib

# specify your Gruobi version
GUROBI_VERSION_TAG ?= 9.0.2
GUROBI_VERSION=$(shell echo $(GUROBI_VERSION_TAG) | sed 's/-.*//g')
GUROBI_MAJOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 1)
GUROBI_MINOR_VERSION=$(shell echo $(GUROBI_VERSION) | cut -d"." -f 2)
GUROBI_VERSION_SUFFIX=${GUROBI_MAJOR_VERSION}${GUROBI_MINOR_VERSION}
# set GUROBI_HOME according to your environment
GUROBI_HOME ?= ${GUROBI_HOME}/gurobi/${GUROBI_VERSION}

EXAMPLE_SOURCES=$(wildcard *.cpp)
EXAMPLES=$(patsubst %.cpp, %, $(EXAMPLE_SOURCES))

examples-in-docker: $(EXAMPLES)
	@#

$(EXAMPLES): % : %.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ $< $(LDFLAGS) $(LDLIBS) $(RUNFLAGS)
