GUROBI_MAKEFILE=gurobi.mak 

-include ${GUROBI_MAKEFILE}

CXX=c++
CXXFLAGS += -std=c++17 -Wall -Wextra -pedantic -fPIC #-Werror
CPPFLAGS += -Isrc -I${GUROBI_HOME}/include
LDPATHS += -L${GUROBI_HOME}/lib
LDFLAGS += -shared ${LDPATHS} 
LDLIBS += -lgurobi_c++ -lgurobi${GUROBI_VERSION_SUFFIX} -lpthread

SRCDIR=src
SHARED_LIB=lib/libgrbfrc.so
STATIC_LIB=lib/libgrbfrc.a
LIBS=$(SHARED_LIB) $(STATIC_LIB)
SOURCES=$(wildcard $(SRCDIR)/*.cpp) $(wildcard $(SRCDIR)/*/*.cpp) 
HEADERS=$(wildcard $(SRCDIR)/*.hpp) $(wildcard $(SRCDIR)/*/*.hpp) 
OBJECTS=$(patsubst %.cpp, %.o, $(SOURCES))
DEPS=$(patsubst %.cpp, %.d, $(SOURCES))

all : $(LIBS) docs examples
	@#

$(SHARED_LIB) : $(OBJECTS) 
	@mkdir -p lib
	$(CXX) -o $@ $^ $(LDFLAGS) $(LDLIBS) $(RUNFLAGS)

$(STATIC_LIB) : $(OBJECTS)
	@mkdir -p lib 
	$(AR) cr $@ $^

$(DEPS) : %.d : %.cpp
	@$(CXX) $(CXXFLAGS) $(CPPFLAGS) -MM $< | sed 's,.*.o:,$*.o:,g' > $@

$(OBJECTS) : %.o :  
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c -o $@ $<

examples: 
	@#

docs: userdocs devdocs 
	@#

userdocs : clean 
	cd doc/user && doxygen Doxyfile

userdocs-open : devdocs 
	cd doc/user/html && $(BROWSER) index.html

devdocs : clean
	cd doc/dev && doxygen Doxyfile

devdocs-open : devdocs 
	cd doc/dev/html && $(BROWSER) index.html

clean :
	rm -f $(OBJECTS) $(DEPS)

destroy : clean
	rm -rf lib
	rm -rf doc/dev/html doc/dev/latex 
	rm -rf doc/user/html doc/user/latex

-include $(DEPS)
